#!/usr/bin/env node

const fs = require("node:fs");
const path = require("node:path");

const SOURCE_REPOSITORY = "jooh/devcontainer-rs";
const FORMULA_PATH = path.join("Formula", "devcontainer-rs.rb");
const REQUIRED_TARGETS = Object.freeze([
  Object.freeze({
    triple: "aarch64-apple-darwin",
    os: "macos",
    cpu: "arm",
  }),
  Object.freeze({
    triple: "x86_64-apple-darwin",
    os: "macos",
    cpu: "intel",
  }),
  Object.freeze({
    triple: "x86_64-unknown-linux-gnu",
    os: "linux",
    cpu: "x86_64",
  }),
]);

function archiveName(triple) {
  return `devcontainer-${triple}.tar.gz`;
}

function parseArgs(argv) {
  const args = {
    repository: SOURCE_REPOSITORY,
    output: FORMULA_PATH,
  };

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];
    if (arg === "--help" || arg === "-h") {
      args.help = true;
      continue;
    }

    if (!arg.startsWith("--")) {
      throw new Error(`unexpected argument: ${arg}`);
    }

    const key = arg.slice(2);
    const value = argv[index + 1];
    if (!value || value.startsWith("--")) {
      throw new Error(`missing value for ${arg}`);
    }
    args[key] = value;
    index += 1;
  }

  return args;
}

function usage() {
  return [
    "Usage: node scripts/update-formula.js [--tag <tag>] [--output <path>]",
    "",
    "Options:",
    "  --tag         Release tag to publish; defaults to the latest release",
    "  --repository  Source release repository; defaults to jooh/devcontainer-rs",
    "  --output      Formula path to write; defaults to Formula/devcontainer-rs.rb",
  ].join("\n");
}

function parseVersionFromTag(tag) {
  const match = /^devcontainer-v(.+)$/.exec(tag || "");
  if (!match) {
    throw new Error(`expected tag like devcontainer-v1.2.3, got ${tag || "<empty>"}`);
  }
  return match[1];
}

function extractSha256(content) {
  const match = String(content).trim().match(/^([a-f0-9]{64})\b/i);
  if (!match) {
    throw new Error("could not parse SHA-256 checksum");
  }
  return match[1].toLowerCase();
}

function releaseTag(release) {
  return release.tag_name || release.tagName;
}

function assetDownloadUrl(asset) {
  return asset.browser_download_url || asset.url;
}

function assetMap(release) {
  return new Map((release.assets || []).map((asset) => [asset.name, asset]));
}

function requireAsset(assets, name) {
  const asset = assets.get(name);
  if (!asset) {
    throw new Error(`missing release asset ${name}`);
  }
  if (!assetDownloadUrl(asset)) {
    throw new Error(`missing download URL for release asset ${name}`);
  }
  return asset;
}

function requireSha256(checksums, triple) {
  const sha256 = checksums[triple];
  if (!sha256) {
    throw new Error(`missing SHA-256 for ${triple}`);
  }
  if (!/^[a-f0-9]{64}$/.test(sha256)) {
    throw new Error(`invalid SHA-256 for ${triple}: ${sha256}`);
  }
  return sha256;
}

function buildFormulaContext({ release, checksums, repository = SOURCE_REPOSITORY }) {
  const tag = releaseTag(release);
  const version = parseVersionFromTag(tag);
  const assets = assetMap(release);

  return {
    repository,
    tag,
    version,
    targets: REQUIRED_TARGETS.map((target) => {
      const archive = archiveName(target.triple);
      const archiveAsset = requireAsset(assets, archive);
      requireAsset(assets, `${archive}.sha256`);

      return {
        ...target,
        url: assetDownloadUrl(archiveAsset),
        sha256: requireSha256(checksums, target.triple),
      };
    }),
  };
}

function findTarget(targets, triple) {
  const target = targets.find((candidate) => candidate.triple === triple);
  if (!target) {
    throw new Error(`missing target ${triple}`);
  }
  return target;
}

function renderFormula({ repository = SOURCE_REPOSITORY, tag, version, targets }) {
  const darwinArm64 = findTarget(targets, "aarch64-apple-darwin");
  const darwinX64 = findTarget(targets, "x86_64-apple-darwin");
  const linuxX64Gnu = findTarget(targets, "x86_64-unknown-linux-gnu");

  return `class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/${repository}"
  version "${version}"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "${darwinArm64.url || releaseDownloadUrl(repository, tag, darwinArm64.triple)}"
      sha256 "${darwinArm64.sha256}"
    else
      url "${darwinX64.url || releaseDownloadUrl(repository, tag, darwinX64.triple)}"
      sha256 "${darwinX64.sha256}"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "${linuxX64Gnu.url || releaseDownloadUrl(repository, tag, linuxX64Gnu.triple)}"
    sha256 "${linuxX64Gnu.sha256}"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end
`;
}

function releaseDownloadUrl(repository, tag, triple) {
  return `https://github.com/${repository}/releases/download/${tag}/${archiveName(triple)}`;
}

async function fetchResponse(url, accept) {
  if (typeof fetch !== "function") {
    throw new Error("Node.js fetch is required; use Node.js 18 or newer");
  }

  const response = await fetch(url, {
    headers: {
      Accept: accept,
      "User-Agent": "homebrew-devcontainer-rs-updater",
      "X-GitHub-Api-Version": "2022-11-28",
    },
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(`GET ${url} failed with ${response.status}: ${body.slice(0, 200)}`);
  }

  return response;
}

async function fetchRelease({ repository = SOURCE_REPOSITORY, tag }) {
  const endpoint = tag
    ? `https://api.github.com/repos/${repository}/releases/tags/${tag}`
    : `https://api.github.com/repos/${repository}/releases/latest`;
  const response = await fetchResponse(endpoint, "application/vnd.github+json");
  return response.json();
}

async function fetchText(url) {
  const response = await fetchResponse(url, "text/plain, application/octet-stream");
  return response.text();
}

async function fetchChecksums(release) {
  const assets = assetMap(release);
  const checksums = {};

  for (const { triple } of REQUIRED_TARGETS) {
    const checksumAsset = requireAsset(assets, `${archiveName(triple)}.sha256`);
    checksums[triple] = extractSha256(await fetchText(assetDownloadUrl(checksumAsset)));
  }

  return checksums;
}

function writeFormula(output, formula) {
  fs.mkdirSync(path.dirname(output), { recursive: true });
  fs.writeFileSync(output, formula, "utf8");
}

async function updateFormula({ repository = SOURCE_REPOSITORY, tag, output = FORMULA_PATH }) {
  const release = await fetchRelease({ repository, tag });
  const checksums = await fetchChecksums(release);
  const context = buildFormulaContext({ release, checksums, repository });
  const formula = renderFormula(context);
  writeFormula(output, formula);
  return context;
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  if (args.help) {
    console.log(usage());
    return;
  }

  const context = await updateFormula({
    repository: args.repository,
    tag: args.tag,
    output: args.output,
  });
  console.log(`Rendered ${args.output} for ${context.tag}`);
}

if (require.main === module) {
  main().catch((error) => {
    console.error(error.message);
    process.exit(1);
  });
}

module.exports = {
  FORMULA_PATH,
  REQUIRED_TARGETS,
  SOURCE_REPOSITORY,
  archiveName,
  buildFormulaContext,
  extractSha256,
  parseVersionFromTag,
  releaseDownloadUrl,
  renderFormula,
  updateFormula,
};

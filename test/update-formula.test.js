const assert = require("node:assert/strict");
const test = require("node:test");

const {
  REQUIRED_TARGETS,
  archiveName,
  buildFormulaContext,
  extractSha256,
  parseVersionFromTag,
  renderFormula,
} = require("../scripts/update-formula");

function releaseWithAssets(tagName, names) {
  return {
    tag_name: tagName,
    assets: names.map((name) => ({
      name,
      browser_download_url: `https://github.com/jooh/devcontainer-rs/releases/download/${tagName}/${name}`,
    })),
  };
}

test("parses devcontainer release tags", () => {
  assert.equal(parseVersionFromTag("devcontainer-v1.2.3"), "1.2.3");
  assert.throws(() => parseVersionFromTag("v1.2.3"), /expected tag/);
});

test("extracts checksums from cargo-dist checksum files", () => {
  assert.equal(
    extractSha256(`${"a".repeat(64)}  devcontainer-aarch64-apple-darwin.tar.gz\n`),
    "a".repeat(64),
  );
  assert.throws(() => extractSha256("not a checksum"), /could not parse/);
});

test("builds formula context from release metadata and sidecar checksums", () => {
  const tag = "devcontainer-v1.2.3";
  const release = releaseWithAssets(
    tag,
    REQUIRED_TARGETS.flatMap(({ triple }) => [
      archiveName(triple),
      `${archiveName(triple)}.sha256`,
    ]),
  );

  const context = buildFormulaContext({
    release,
    checksums: Object.fromEntries(
      REQUIRED_TARGETS.map(({ triple }, index) => [triple, String(index + 1).repeat(64)]),
    ),
  });

  assert.equal(context.version, "1.2.3");
  assert.equal(context.tag, tag);
  assert.equal(context.targets.length, REQUIRED_TARGETS.length);
  assert.equal(context.targets[0].sha256, "1".repeat(64));
});

test("requires all release archives and checksum sidecars", () => {
  const release = releaseWithAssets("devcontainer-v1.2.3", [archiveName("aarch64-apple-darwin")]);

  assert.throws(
    () =>
      buildFormulaContext({
        release,
        checksums: { "aarch64-apple-darwin": "a".repeat(64) },
      }),
    /missing release asset/,
  );
});

test("renders the Homebrew formula", () => {
  const formula = renderFormula({
    version: "1.2.3",
    tag: "devcontainer-v1.2.3",
    repository: "jooh/devcontainer-rs",
    targets: [
      {
        triple: "aarch64-apple-darwin",
        os: "macos",
        cpu: "arm",
        sha256: "a".repeat(64),
      },
      {
        triple: "x86_64-apple-darwin",
        os: "macos",
        cpu: "intel",
        sha256: "b".repeat(64),
      },
      {
        triple: "x86_64-unknown-linux-gnu",
        os: "linux",
        cpu: "x86_64",
        sha256: "c".repeat(64),
      },
      {
        triple: "aarch64-unknown-linux-gnu",
        os: "linux",
        cpu: "arm64",
        sha256: "d".repeat(64),
      },
    ],
  });

  assert.match(formula, /^class DevcontainerRs < Formula/m);
  assert.match(formula, /homepage "https:\/\/github.com\/jooh\/devcontainer-rs"/);
  assert.match(formula, /version "1\.2\.3"/);
  assert.match(
    formula,
    /url "https:\/\/github.com\/jooh\/devcontainer-rs\/releases\/download\/devcontainer-v1\.2\.3\/devcontainer-aarch64-apple-darwin\.tar\.gz"/,
  );
  assert.match(formula, /if Hardware::CPU.arm\?/);
  assert.match(
    formula,
    /devcontainer-aarch64-unknown-linux-gnu\.tar\.gz/,
  );
  assert.match(formula, /depends_on arch: \[:arm64, :x86_64\]/);
  assert.match(formula, /bin\.install "devcontainer"/);
  assert.match(formula, /assert_match version\.to_s, shell_output/);
  assert.equal(formula.endsWith("\n"), true);
});

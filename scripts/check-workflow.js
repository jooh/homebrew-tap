#!/usr/bin/env node

const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");

const workflowPath = path.join(__dirname, "..", ".github", "workflows", "update-formula.yml");
const workflow = fs.readFileSync(workflowPath, "utf8");

assert.match(workflow, /^on:\n[\s\S]*^\s+schedule:/m, "formula updates should poll releases");
assert.match(workflow, /^on:\n[\s\S]*^\s+workflow_dispatch:/m, "formula updates should be manually dispatchable");
assert.match(workflow, /^permissions:\n\s+contents: write/m, "tap workflow needs write access only to this tap");
assert.match(workflow, /node scripts\/update-formula\.js\b/, "tap workflow should run the tap-owned updater");
assert.match(workflow, /\bgit diff --cached --quiet\b/, "tap workflow should be idempotent");
assert.match(workflow, /\bgit push origin HEAD:main\b/, "tap workflow should push only to this tap");
assert.doesNotMatch(workflow, /secrets\./, "tap workflow should not require repository secrets");
assert.doesNotMatch(workflow, /HOMEBREW_TAP_TOKEN/, "tap workflow should not use a cross-repo tap token");
assert.doesNotMatch(workflow, /\bid-token:\s+write\b/, "tap workflow should not request OIDC for GitHub writes");

console.log("[homebrew-workflow] Tap-owned formula workflow is wired.");

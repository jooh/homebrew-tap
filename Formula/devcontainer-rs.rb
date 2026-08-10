class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.64"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.64/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "0f99b19c3b9a84771def874dcb3f3a5b6a7a1e77b2f29896cf8290d3a137b4c1"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.64/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "e45dc77ba4dec06eb3bf4ec665f55f7aec5f8e3e5cbae2d12782e62e29b9fe74"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.64/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "469cf3c628b793171b293715b3a2476f88b03cee9f4d9c3ce43e573a68c6701e"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.64/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e6965ff6a07b64a5e7d1697e9480ed069ffebc40de1de0817d500c780b2a58fc"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

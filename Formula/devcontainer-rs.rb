class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.56"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.56/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "fb0a2420fcb62e31acb21271435ecd7f0d819288008c33acaf4308f97346c2ff"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.56/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "a7d4d879df6adf6515c7a9eade79e7915893ce0b49b2ca9cb7390828ff32ae10"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.56/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5384de92d07b2d8ecef035d411eca631022ad8c447adc6331285dbefaa9d4edb"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.56/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1554983f4d81209637a15c5e3f1d3968418427e490f0ed08e5a6a52c1f7e2a03"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

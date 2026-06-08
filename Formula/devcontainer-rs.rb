class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.58"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.58/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "89a8f702d8fbe91517ee28daaa1604474ac890db0ddd57a8e599e725604b4eb8"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.58/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "9f4612c3c6264765a86bced3018d95636794d518cf45d7949842351842842f56"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.58/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "decdab3b3475a6fe52bb884ef8c32a9210b2eedd3ff2806e0f79f284226a5e61"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.58/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "295524e5bd91ad88f897a83003b48930608f0f963ed029c846beb1715bd4e0e8"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

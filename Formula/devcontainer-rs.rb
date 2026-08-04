class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.63"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.63/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "c83d7e27fda4f0b865fa88a971f1b075a632041c14bddfea37bb5238041aa3a9"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.63/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "81d797021e3a23b5e81aa043ed0420dd8473abda060fb10e0dc8ef2cd245c12c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.63/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0b7744a63f4440d0b6bfa529511a827e19eb1e113e185cd40440ab8b2a2f38b4"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.63/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ce226deea51d5e3541927502a91a0c821656118d0473d99e800dffc3d8764f65"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

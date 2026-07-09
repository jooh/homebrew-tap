class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.59"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.59/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "444f3d570a1b8a0d52f3ad2e9e63841c70299a5df6ce488e493dcea3de858926"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.59/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "392e9e5ba9ca13378588b4b7b9a53fe19d9772bb83570d5ad8164ab9e8cdf93d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.59/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "de026414432750158e939ea60a521616ce759d3b1c0a659d87e7391b1314a0cd"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.59/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c99089f6d9876bee7bac956b748630b860048bcb2e39da85b7813cd7ad679fde"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

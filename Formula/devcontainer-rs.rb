class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.62"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.62/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "3c4d5abec1b569d02ccec632a810ec770917d5f45544abff9b6df957551467fd"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.62/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "dba038a1d916cf60872200a0d4084d562fa32de3bc14c72733674676f8e808a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.62/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b57fac7e7a3f066d09479874f62d356088bc694d1d4914be4d937b84d0173c2b"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.62/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c5429d6da6ea20262da869d72ba11918fce410e1cc1de382e260e8d2a9f8a88d"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

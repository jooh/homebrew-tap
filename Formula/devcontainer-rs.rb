class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.52"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.52/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "87a69bfb5b222e065e82b8edfeb359957c30983c8599311e8e63fad0324f4191"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.52/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "8fe87f9fb3bf8e54d1efc84da2f008ba8aa9098527480e66c9cdab442ad55edf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.52/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "35d8fb5dbc2daf3bf55237e8062d334c53ac627e30d324b8f9b1c1f7855d0104"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.52/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "72fe4eafaa0da10004c01f5b1ccea559a1077c901308de428c02d66694b85cc4"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

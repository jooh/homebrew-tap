class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.45"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.45/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "0217e4a92b1012cebc6fe8cdba22827f986a7baf7400aa5aa156c20994936934"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.45/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "5b289db1fe3844f45d95d770f9bcc708dbbcdc2d924e196905854806fb466251"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.45/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8a73945df6ea1f48bebea525b0a3d847125a149dd5abc8a99662148f0f6bfe7e"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.45/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5619bf8a78e9380ffa0a7b700a91539f0ba36e975ea29f91503c1d509b0b7979"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

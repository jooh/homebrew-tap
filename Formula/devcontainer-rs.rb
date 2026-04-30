class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.41"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.41/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "e018257efdb892d31073476873e623cda814e61ad260954316d8139faf20647f"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.41/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "9a9dab8369f3e4ac6d4c32fcc17300ee70c06123ab86858c6a4b5fee1eddc17e"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.41/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e31138ada3e676d90bbc97a67de766bf9dd855263ba06005c42eaaad3e07d985"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

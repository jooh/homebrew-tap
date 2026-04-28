class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.37"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.37/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "b5b761544afc806269d0ddaeaa3695a414fa910aa3bbb2fbbd12f20d9143a069"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.37/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "d25c7e9b07d61342ea0b53776d76ce1158d5064cfaa06d8750c6e2d399c39482"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.37/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d36585e53aba88dd60d2a900a161de1969c3e7da612ec11988387165024fd24c"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

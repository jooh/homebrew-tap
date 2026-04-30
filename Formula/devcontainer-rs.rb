class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.43"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.43/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "ba3ecc28800f7ebe016fd1da2076df70865c7bead7cc083dc36b85cc47c3c334"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.43/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "2a77a76e0b38806c62cefa155726aa2fda0c31c85b5185821af486394cde0599"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.43/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "886dfdc20d85849dcd393afc888b2e9fb533f47d38a47f0c6387a3c357750bb6"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

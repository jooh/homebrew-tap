class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.40"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.40/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "3c2a08c6eef77aad89e5bd655de0e943176ee0426c9791a109c700ef4b17ecd0"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.40/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "d1f1b9b745c239bf019ab7eeb228a0267b28f9f985ffeb42bc19bb60c4515526"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.40/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "46975564090e51f15782ae536c83e57376fa4fb671922fc797decf62273baff9"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_predicate bin/"devcontainer", :exist?
    assert_predicate bin/"devcontainer", :executable?
  end
end

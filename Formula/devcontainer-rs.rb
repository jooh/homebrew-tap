class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.35"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.35/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "cc2e85fe38d5747433d51beb885567be55f49cecf27402a71a34cb52cb93cf03"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.35/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "ff8412c164ffb654742ddbe2e44c199fbe8047bfe4b6623f1122fabe3ff241f3"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.35/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "05c70fcf3573ce6e14f765f185757eaef0c326ac4aefebb3adee28437dc15dac"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

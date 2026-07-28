class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.60"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.60/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "654e07d0d7b326fdc4b8c73d5647a48746bfc31409d07713bdb597dc18447c90"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.60/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "055f0e981836aa2a45669038b98e09c1f6ba1954bee827abaa7c6f0341ac9424"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.60/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "174a1a60495403c290af8ef54fbced12f7e26169e322d470b9a57170c26001a5"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.60/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0aad04ec6a601a582b6e82070cc52858806786019dfda430389fd0166b44ded0"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.53"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.53/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "41e038603eec0f2688859178139017d395d7b29dced4ab20d96b0a7cb5784b8c"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.53/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "84474691744e3481b0edcea9597cd94819b6752ef0706780ce2efe0987f43fbb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.53/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ef51b4735fb172d9a6ea694b73477c2fdf3525ee838f24aca22da279a9046ebd"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.53/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6ffd3b7df4295be907ce0aa422be36a15ed282f80880a971ec5b5166974e040a"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

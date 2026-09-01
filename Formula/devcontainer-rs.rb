class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.66"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.66/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "8301743a699e2d16ed9f3d0ba1b406f6776f8ccf5e2211139668cbb12b344502"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.66/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "314112f8c1cfe693516d17c16878d9aa9461b8593d21cb833d82ecafd63ad2b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.66/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "929e0d298be37742eb417c8b1baba8ac2fef1adfdefb439bc5c9e4396b2ceec2"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.66/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62549830b2112dc95f94c73cc5018436508f52b9fa497a000c8e8e715bf10cf7"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

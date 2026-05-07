class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.48"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.48/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "6c1f6ebc18d1c8a2deebe8860fa4faf3dc5461b1e2a4c688896cab153cb562c6"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.48/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "bbf196926da5556fdb4df57ef3eb5024638dfb683df8b59c384fb25880d60b7e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.48/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5348f62a766fb5b6c8d6c54c0d0bd33d75002415b0849d07ff179a5e8da1fecb"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.48/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b27b339abf9a39ec6463ead7e91d51035b40a4c4b0fd9d81eed9eea9b919b4cf"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

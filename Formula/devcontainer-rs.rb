class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.42"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.42/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "b26f214b43e19676c3f7ba3f36adf3057ad2dc29709d867c5b81f93b8edc437c"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.42/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "7ff3f6ec6d27af18bcbfff47cfef02a684340b85170862375017d2af79cf16d1"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.42/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "1540b5e079f227caf14fe6f169ca5ccda9f2cc058f554eecec2e57975bab24a3"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

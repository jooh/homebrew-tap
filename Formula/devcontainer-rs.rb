class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.61"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.61/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "820f2fa2e9ec13c4a9be240def56b7065279e6c4bd40995135166ca2086eda13"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.61/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "b12f8e20db0775870ce7b6c06ad8247cbabf06c7b7c0fd76f2881a9d4dcf9f57"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.61/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "01fa59e8a49b7be3d24afd98adf48ab0c7d133860f05a9d22f95c2b0c644486e"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.61/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3300736f3411fac9eee25f123177c2154be824c346e702c1c538ddc715c6d061"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

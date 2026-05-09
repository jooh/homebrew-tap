class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.51"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.51/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "d4d0bf3a9f955d74d9f71d5553a3f45655b2a3fd76893f759af55ef74a0276c2"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.51/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "d1e183c2eab50c13e856237322abab3958f5c1321a919220eef10ece4ba644c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.51/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dbce961587e15e10d006e9ebe05c032cb3c87a4151464a7ea9d55e97fddb5c15"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.51/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4d5b811e2be7555cfb08b5d2d7b5dc83f8e8f9f093f2394f1dcc67745d3996e6"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

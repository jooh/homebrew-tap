class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.54"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.54/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "a08a326fd11b6c57a4c69865be26fe5376f1a6e79a2b85a5e40a9acd589c94db"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.54/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "fde85af46eadc9889f45077134a3d471f8ca342e45386e177ba296662bfd8a81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.54/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6125c5739fe7e10c3ec40aafad75305fa92e9db84a6c7d4582b48400b391ac81"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.54/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "58757570675c7bd87e849c033cd6786781344cc0f05eefeff6d21fd6dd0ed033"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

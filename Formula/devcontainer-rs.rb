class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.36"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.36/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "521fb9180fe2e1413d0f3a6242f0c20c93532425c65ba29dbfbc8c6cf1a91882"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.36/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "72f2658afe352e4ce537218517b1b1de18f88c1116d4249afcb12dc6308d1882"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.36/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "98f328b06927844b6977c750906d5dd955ed2ffb5a5fda363342bd8dc100a7ea"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

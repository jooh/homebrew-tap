class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.47"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.47/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "23ed34ef9a1492f4e93a3e2a460e8b49d5d04e0eb6a59de2781a9d67f74b00dd"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.47/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "e0f6fffab832e38d3287b6fbea1204d76cf994e6ba50eae830567edda6faf70d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.47/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4b079eef2a22db453b3c6a24ac7ba301a9423780a47c1d78c6bbe04590bb27c0"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.47/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "999a5214f15c4dcd3db5ca76e057ff072e531e88dbff2ed86423620ba16ddf09"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

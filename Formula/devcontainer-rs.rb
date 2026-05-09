class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.50"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.50/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "672d8071229a8fff115b4afefa447e6516b5e72d016761da3df97d46bb734517"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.50/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "6f92d9c6d85e036ab7744e085905c6509a8389391d611019a7dd0b85f9c22ceb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.50/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ffd82da62bab21a0b8bd82916c496b94a378617fc352eeb01acf2172501f0d7f"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.50/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "92c05af4efcf53356c645af2793cc88e5bdddf96ae84fc9841593347c98334c8"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

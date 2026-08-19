class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.65"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.65/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "0c3550f3f73e92b45aa1832da9c64b6dd3e0545ee71a80be3e45e9f0e3376b0e"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.65/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "192017499b3406a21e51954a5ac6b1372717e4d1d7a29a943e72c599137ff9f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.65/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6622e610eb6e58382b205ebfda80fe4aceadebfe30fce9b9fdcf7eb724cc83da"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.65/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3e9769fad392c8979b1941f9e516b181d52f33d8b0875d0c3018b5046ad68c56"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

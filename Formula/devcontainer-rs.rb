class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.49"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.49/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "a0c3f1331ad61bea8785dc4416dc35ebfbf10040569bb2592fef8356acc1e8c9"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.49/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "529d80a61737205f7471ca5dbf31707068d42db54998bbe56eea25aa1fccc6ca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.49/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8828da0f553f108e4ffd2f286327b2cbce6e606b84da0f2da2166139a6b08e37"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.49/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c6ca153a99b519fc5489c7daaff33e6295b6a04919e9e9be6a8e4df0080aa04c"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

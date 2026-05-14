class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.55"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.55/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "4e513c54a58c6d962a2de90db9dbb6802bafd3f6fc5a0169411f5b3071f4008b"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.55/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "30ab76bc051c2ccf23190b4ecc9403cbecf0ef087a166ce7bebb0bb1c7017f0f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.55/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4b370561d230aefea8d291a8f848ac46fc6eb47e53e4b33b5d7fd33139f31ea4"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.55/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c93ef58547260f1ab249c17dd235687aee1a28bc1a494ae3dd1253c396ce0140"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

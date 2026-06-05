class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.57"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.57/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "99c666f9823bccaff15e4a2e375f7b18d9fb2dba722da488db547148f2d39d09"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.57/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "123fb696ef530e7ba4327096bf6a90416dca8ffad814312d229c0c04767231bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.57/devcontainer-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5696a9a93747402a8c2b3d5ccde726a2f25ba752a6281bacfa72f4d8bf3b3343"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.57/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a3f37564f6e49615bc14c9440e15fdc3be670bb77d424132c3957fbcb703244e"
    end
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

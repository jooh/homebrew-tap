class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.44"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.44/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "5b4249545d3df2f4e40129f790a6342a70171130ca28b53b0ea963876d3c7956"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.44/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "14c936b3d5281eac01f7dfb2dedaf5cdadccb585c361898a1e2514d2bff6df05"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.44/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "796109c7b30b1bdeba4909d818dd2e3f9b0d18a63af835fea4660902920b00c1"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

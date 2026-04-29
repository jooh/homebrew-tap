class DevcontainerRs < Formula
  desc "Native Rust foundation for devcontainer CLI"
  homepage "https://github.com/jooh/devcontainer-rs"
  version "0.0.39"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.39/devcontainer-aarch64-apple-darwin.tar.gz"
      sha256 "992470d4e43b5097e003852843fb48ec94d9aa19e4dd0f2b0a54ae2917d8298d"
    else
      url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.39/devcontainer-x86_64-apple-darwin.tar.gz"
      sha256 "51e104494d90aaaf48edde07e9bc2016876e607a679bac114b3838f68b233ccb"
    end
  end

  on_linux do
    depends_on arch: :x86_64

    url "https://github.com/jooh/devcontainer-rs/releases/download/devcontainer-v0.0.39/devcontainer-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2099f1834cc49c6210f98bdd23b8fab79379e0f0e970a08bfd8e2ecad8026281"
  end

  def install
    bin.install "devcontainer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devcontainer --version")
  end
end

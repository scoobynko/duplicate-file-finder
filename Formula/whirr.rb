class Whirr < Formula
  desc "A whirring macOS system dashboard for your terminal"
  homepage "https://github.com/scoobynko/whirr"
  version "0.3.2"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/scoobynko/whirr/releases/download/v0.3.2/whirr-aarch64-apple-darwin.tar.xz"
    sha256 "6edd548cb1671ab561d0fa17d90cc236584c4a3a6777fc7538b241f09e17f198"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "whirr" if OS.mac? && Hardware::CPU.arm?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

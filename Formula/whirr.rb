class Whirr < Formula
  desc "A whirring macOS system dashboard for your terminal"
  homepage "https://github.com/scoobynko/whirr"
  version "0.3.11"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/scoobynko/whirr/releases/download/v0.3.11/whirr-aarch64-apple-darwin.tar.xz"
    sha256 "8c52daaf1197633330687b6b5a2cfa7df876e344968472a01d94b299e148b133"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "whirr"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

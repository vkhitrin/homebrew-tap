class NotcursesTmux < Formula
  desc "Blingful character graphics/TUI library"
  homepage "https://nick-black.com/dankwiki/index.php/Notcurses"
  url "https://github.com/dankamongmen/notcurses/archive/refs/tags/v3.0.16.tar.gz"
  sha256 "e893c507eab2183b6c598a8071f2a695efa9e4de4b7f7819a457d4b579bacf05"
  license "Apache-2.0"
  revision 1

  conflicts_with "notcurses", because: "both provide `notcurses.h`"

  depends_on "cmake" => :build
  depends_on "doctest" => :build
  depends_on "pandoc" => :build
  depends_on "pkgconf" => :build
  depends_on "ffmpeg"
  depends_on "libdeflate"
  depends_on "libunistring"
  depends_on "ncurses"

  # Apply tmux patch
  patch do
    url "https://gist.githubusercontent.com/vkhitrin/561fc6921e5193ac40be6791ff777980/raw/5f0b8b5eabcdfc2d2533f211d350741a7aca9db1/notcurses-tmux.patch"
    sha256 "1bc42aa42eece8996f8e6dbb3768bdba0024a8aa8e1f0a3494a6e23c52ffb1ae"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
     <<~EOS
     This is a custom formula to include fix for tmux
     EOS
  end

  test do
    # current homebrew CI runs with TERM=dumb. given that Notcurses explicitly
    # does not support dumb terminals (i.e. those lacking the "cup" terminfo
    # capability), we expect a failure here. all output will go to stderr.
    assert_empty shell_output(bin/"notcurses-info", 1)
  end
end

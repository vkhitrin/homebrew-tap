class GitOpenHelper < Formula
  desc "Open git remote from a terminal"
  homepage "https://github.com/paulirish/git-open"
  license "MIT"
  head "https://github.com/paulirish/git-open.git", branch: "master"

  conflicts_with "git-open", because: "both install `git-open` binaries"

  def install
    bin.install("git-open" => "git-open")
  end

  test do
    system bin / "git-open", "-v"
  end
end

class GitlabCiLinter < Formula
  desc "gitlab-ci lint tool for validating .gitlab-ci.yml using Gitlab API"
  homepage "https://gitlab.com/orobardet/gitlab-ci-linter"
  url(
    "https://gitlab.com/orobardet/gitlab-ci-linter.git",
    tag: "v2.4.0",
    revision: "c00efcbb2477f08dd0610075f46991669f85aea3"
  )
  head "https://gitlab.com/orobardet/gitlab-ci-linter.git", branch: "master"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build

  def install
    revision = Utils.git_head
    system("make", "build", "VERSION=#{version}", "REVISION=#{revision}")
    bin.install(".build/gitlab-ci-linter")
  end

  test do
    system "#{bin}/gitlab-ci-linter", "--version"
  end

end

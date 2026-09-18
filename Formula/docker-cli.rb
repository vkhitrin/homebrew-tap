class DockerCli < Formula
  desc "Command-line client for Docker"
  homepage "https://docker.com"
  url "https://download.docker.com/mac/static/stable/aarch64/docker-29.8.1.tgz"
  sha256 "5a8f5604d7673202b2af925229d15eb4bbb86f7f542e4ac8cd7aa3f14cfa0f8b"
  license "Apache-2.0"

  livecheck do
    url "https://download.docker.com/mac/static/stable/aarch64/"
    regex(/docker[._-](\d+\.\d+\.\d+)\.t/i)
  end

  conflicts_with cask: "docker-desktop", because: "both install `docker` binaries"

  def install
    bin.install "docker"
    generate_completions_from_executable(bin/"docker", "completion")
  end

  def caveats
    <<~EOS
      This is a docker CLI only formula!
      It conflicts with `docker-desktop` cask.

      Combine it with 'socktainer' to mimic docker-like workflow!
    EOS
  end

  test do
    assert_match "Docker version #{version}", shell_output("#{bin}/docker --version")
  end
end

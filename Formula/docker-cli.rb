class DockerCli < Formula
  desc "Command-line client for Docker"
  homepage "https://docker.com"
  url "https://download.docker.com/mac/static/stable/aarch64/docker-29.5.3.tgz"
  sha256 "a579c5fb15bebb35dc443cdf6f17b076b6c90afa6cd0e51463b1608e5b235536"
  license "Apache-2.0"

  livecheck do
    url "https://download.docker.com/mac/static/stable/aarch64/"
    regex(/docker[._-](\d+\.\d+\.\d+)\.t/i)
  end

  conflicts_with cask: "docker-desktop", because: "both install `docker` binaries"

  def install
    bin.install "docker"
    generate_completions_from_executable(bin / "docker", "completion")
  end

  def caveats
    <<~EOS
      This is a docker CLI only formula!
      It conflicts with `docker-desktop` cask.

      Combine it with 'socktainer' to mimic docker-like workflow!
    EOS
  end

  test do
    assert_match "docker", shell_output("#{bin}/ --version")
  end
end

class DockerCli < Formula
  desc "Command-line client for Docker"
  homepage "https://docker.com"
  url "https://download.docker.com/mac/static/stable/aarch64/docker-29.3.1.tgz"
  sha256 "7a448b9d948157f4bcf29369755389049746297d1289a0607ea3d0a811d20e75"
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

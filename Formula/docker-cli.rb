class DockerCli < Formula
  version "29.2.1"
  desc "Docker CLI binary"
  homepage "https://docker.com"
  url "https://download.docker.com/mac/static/stable/aarch64/docker-#{version}.tgz"
  sha256 "10661b2ff179677748d0d5413e922736402a38da40618c1980a1dc9adcf5d7a3"
  livecheck do
    url "https://download.docker.com/mac/static/stable/aarch64/"
    regex(/docker[._-](\d+\.\d+\.\d+)\.tgz/i)
  end
  license "Apache-2.0"

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

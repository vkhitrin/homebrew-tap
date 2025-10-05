class DockerCli < Formula
  version "28.5.0"
  desc "Docker CLI binary"
  homepage "https://docker.com"
  url "https://download.docker.com/mac/static/stable/aarch64/docker-#{version}.tgz"
  sha256 "636ec31956c68b3d04d394d5a2913ef7cef806d4079e7c067f9b566aea78b22d"
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

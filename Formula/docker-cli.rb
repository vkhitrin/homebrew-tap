class DockerCli < Formula
  version "29.0.2"
  desc "Docker CLI binary"
  homepage "https://docker.com"
  url "https://download.docker.com/mac/static/stable/aarch64/docker-#{version}.tgz"
  sha256 "2c0fd4ab77d01adab88874ff3f13149607e66cd1aa2128440a234b5327f495a3"
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

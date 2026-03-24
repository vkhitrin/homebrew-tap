class DockerCli < Formula
  version "29.3.0"
  desc "Docker CLI binary"
  homepage "https://docker.com"
  url "https://download.docker.com/mac/static/stable/aarch64/docker-#{version}.tgz"
  sha256 "bb9de3df0ed22aec01d2cfe495d0429a516ad4cdb189ee85efd8c38dae8e544f"
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

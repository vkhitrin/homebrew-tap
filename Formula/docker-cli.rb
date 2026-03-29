class DockerCli < Formula
  desc "Command-line client for Docker"
  homepage "https://docker.com"
  url "https://download.docker.com/mac/static/stable/aarch64/docker-29.3.0.tgz"
  sha256 "bb9de3df0ed22aec01d2cfe495d0429a516ad4cdb189ee85efd8c38dae8e544f"
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

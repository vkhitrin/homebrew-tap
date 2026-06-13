class Dhictl < Formula
  desc "CLI to manage Docker Hardened Images"
  homepage "https://github.com/docker-hardened-images/dhictl"
  version "0.0.4"
  license :cannot_represent

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_intel do
      url "https://github.com/docker-hardened-images/dhictl/releases/download/v#{version}/dhictl-darwin-amd64"
      sha256 "8f87863e395d8267f65cc34e01e5b7eb7919d37838ae7f775083adbc37214a54"
    end

    on_arm do
      url "https://github.com/docker-hardened-images/dhictl/releases/download/v#{version}/dhictl-darwin-arm64"
      sha256 "2c5ba8ce73e1cbcc4d66adce9e5b770d75595638616f83b4e2c53f680a13a9ab"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/docker-hardened-images/dhictl/releases/download/v#{version}/dhictl-linux-amd64"
      sha256 "c8f927ca1000fed400798ce8a217075df6e1d5db74b64fe10ba752ccf30d0b1d"
    end

    on_arm do
      url "https://github.com/docker-hardened-images/dhictl/releases/download/v#{version}/dhictl-linux-arm64"
      sha256 "6ef0a88e7024c1b26bf4995ba9859c483ca96141514d58aa360a366b672b127b"
    end
  end

  def install
    bin.install cached_download => "dhictl"
    chmod 0755, bin/"dhictl"

    (lib/"docker/cli-plugins").install_symlink bin/"dhictl" => "docker-dhi"

    generate_completions_from_executable(bin/"dhictl", "completion")
  end

  def caveats
    <<~EOS
      dhictl is also installed as a Docker CLI plugin. For Docker to find the plugin,
      add "cliPluginsExtraDirs" to ~/.docker/config.json:
        "cliPluginsExtraDirs": [
            "#{HOMEBREW_PREFIX}/lib/docker/cli-plugins"
        ]
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/dhictl --version")
    assert_match "Docker Hardened Images", shell_output("#{bin}/dhictl --help")
    assert_path_exists lib/"docker/cli-plugins/docker-dhi"
  end
end

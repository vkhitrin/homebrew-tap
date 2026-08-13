class Dhictl < Formula
  desc "CLI to manage Docker Hardened Images"
  homepage "https://github.com/docker-hardened-images/dhictl"
  version "0.0.7"
  license :cannot_represent

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_intel do
      url "https://github.com/docker-hardened-images/dhictl/releases/download/v#{version}/dhictl-darwin-amd64"
      sha256 "97d4d0dab8d2050463c5301a1571ef7105b6d5875e44b3e7f9ddc87d2a4d6573"
    end

    on_arm do
      url "https://github.com/docker-hardened-images/dhictl/releases/download/v#{version}/dhictl-darwin-arm64"
      sha256 "4f23c7b2fb11817403ecd1c32a83adb868f352f94a6a493bea7fae54177624d5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/docker-hardened-images/dhictl/releases/download/v#{version}/dhictl-linux-amd64"
      sha256 "0652b8cce9152587affe030526a8aa54de6989f16ce033535da65e7420551f40"
    end

    on_arm do
      url "https://github.com/docker-hardened-images/dhictl/releases/download/v#{version}/dhictl-linux-arm64"
      sha256 "2e1093ab4822317d36e6120def8794c5977dfc76b22534810af3d73e7153d2cb"
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

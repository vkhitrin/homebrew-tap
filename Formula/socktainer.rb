class Socktainer < Formula
  version "0.1.0"
  desc "Docker-compatible REST API on top of Apple container"
  homepage "https://github.com/socktainer/socktainer"
  url "https://github.com/socktainer/socktainer/releases/download/v#{version}/socktainer.zip"
  sha256 "985f624d508f4075ca1830fae00293d2b701c5f62c25255dd10aa5336e4c9468"
  livecheck do
    url(:url)
    strategy(:github_latest)
  end
  license "Apache-2.0"

  def install
    bin.install "socktainer"
  end

  service do
    run [opt_bin/"socktainer"]
    keep_alive true
    environment_variables PATH: std_service_path_env
    log_path var/"log/socktainer.log"
    error_log_path var/"log/socktainer-error.log"
  end

  def caveats
     <<~EOS
      Requires native Apple macOS container (https://github.com/apple/container)
     EOS
  end

  test do
    assert_match "socktainer", shell_output("#{bin}/socktainer --help")
  end
end

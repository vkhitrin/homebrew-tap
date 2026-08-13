class Allurectl < Formula
  desc "Command-line tool for Allure TestOps"
  homepage "https://github.com/allure-framework/allurectl"
  version "2.22.0"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  on_macos do
    on_intel do
      url "https://github.com/allure-framework/allurectl/releases/download/#{version}/allurectl_darwin_amd64"
      sha256 "5e48cdff132995b251d2c4efe531bf96d503982d08b19918504fe91610686d2a"
    end

    on_arm do
      url "https://github.com/allure-framework/allurectl/releases/download/#{version}/allurectl_darwin_arm64"
      sha256 "d9d30cbf3fce8f50e1e3ce2bc85facbb8bab530ac08a5d1fc39d52cbcebd78e5"
    end
  end

  def install
    bin.install cached_download => "allurectl"
    chmod 0755, bin/"allurectl"

    generate_completions_from_executable(bin/"allurectl", "completion")
  end

  test do
    assert_match "allurectl version #{version}", shell_output("#{bin}/allurectl --version")
  end
end

class Allurectl < Formula
  desc "Command-line tool for Allure TestOps"
  homepage "https://github.com/allure-framework/allurectl"
  license :cannot_represent

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  on_macos do
    on_intel do
      url "https://github.com/allure-framework/allurectl/releases/download/2.22.1/allurectl_darwin_amd64"
      sha256 "5784ca912f5ebeaa092b117f6bada3e3dfb09e3f812d58dc44782b19d38501e1"
    end

    on_arm do
      url "https://github.com/allure-framework/allurectl/releases/download/2.22.1/allurectl_darwin_arm64"
      sha256 "5b5505d72f6f1fc2a70d7feced556d4222baa31cfee5ecabe758689a6d107f01"
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

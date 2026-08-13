class HubTool < Formula
  desc "CLI tool for interacting with Docker Hub"
  homepage "https://github.com/vkhitrin/hub-tool"
  license "Apache-2.0"
  head "https://github.com/vkhitrin/hub-tool.git", branch: "main"

  depends_on "go" => :build

  def install
    system "make", "build", "TAG_NAME=main"
    bin.install "bin/hub-tool"

    generate_completions_from_executable(bin/"hub-tool", "completion")
  end

  def caveats
    <<~EOS
      This is a fork of the previous deprecated hub-tool:
        https://github.com/docker/hub-tool
    EOS
  end

  test do
    assert_match "Docker Hub Tool", shell_output("#{bin}/hub-tool --version")
  end
end

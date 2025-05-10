class ObsidianCli < Formula
  license "MIT"
  desc "Interact with Obsidian in the terminal. Open, search, create, update, move, delete and print notes!"
  homepage "https://github.com/Yakitrak/obsidian-cli"
  head "https://github.com/Yakitrak/obsidian-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[-s -w]
    system("go", "build", *std_go_args(ldflags:, output: bin / "obsidian-cli"), ".")

    generate_completions_from_executable(bin / "obsidian-cli", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jira --version")
  end

end

class Opengrep < Formula
  desc "Static code analysis engine to find security issues in code"
  homepage "https://github.com/opengrep/opengrep"
  license "LGPL-2.1-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  on_macos do
    on_intel do
      url "https://github.com/opengrep/opengrep/releases/download/v1.30.0/opengrep_osx_x86"
      sha256 "650772a849a2986880982b7dea0371f96a75d354de95f94e8c1a2e6f8f6262d1"
    end

    on_arm do
      url "https://github.com/opengrep/opengrep/releases/download/v1.30.0/opengrep_osx_arm64"
      sha256 "0f5bc3dec09d995c61331a4017b856ede508f90d95b018d95f1dc6166be89fdd"
    end
  end

  def install
    bin.install cached_download => "opengrep"
    chmod 0755, bin/"opengrep"
  end

  test do
    (testpath/".config").mkpath
    assert_match version.to_s, shell_output("#{bin}/opengrep --version")

    (testpath/"rules.yml").write <<~YAML
      rules:
        - id: detect-eval
          languages: [python]
          message: Avoid eval
          severity: WARNING
          pattern: eval(...)
    YAML
    (testpath/"test.py").write "eval('1 + 1')\n"

    output = shell_output("#{bin}/opengrep scan --config rules.yml --json test.py")
    results = JSON.parse(output).fetch("results")
    assert_equal 1, results.length
    assert_equal "detect-eval", results.first.fetch("check_id")
    assert_equal "test.py", results.first.fetch("path")
  end
end

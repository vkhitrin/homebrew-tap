class HelmDocsAT0 < Formula
  desc "Tool for automatically generating markdown documentation for helm charts"
  homepage "https://github.com/vkhitrin/helm-docs"
  license "GPL-3.0"
  head "https://github.com/vkhitrin/helm-docs.git", branch: "feat/add_support_for_remote_dependencies"

  depends_on "go" => :build

  conflicts_with "helm-docs", because: "both install `helm-docs` binaries"

  def install
    system("go", "mod", "tidy")

    ldflags = %W[
      -s
      -w
      -X
      main.version=#{version}
    ]
    system("go", "build", *std_go_args(output: bin / "helm-docs", ldflags:), "./cmd/helm-docs")
  end

  test do
    (testpath / "Chart.yaml").write(
      <<~YAML
        apiVersion: v2
        name: test-chart
        description: A test chart
        version: 0.1.0
      YAML
    )

    (testpath / "values.yaml").write(
      <<~YAML
        # replicaCount -- Number of replicas
        replicaCount: 1
      YAML
    )

    system bin / "helm-docs", "--dry-run"
    assert_match "test-chart", File.read(testpath / "README.md") if File.exist?(testpath / "README.md")
  end
end

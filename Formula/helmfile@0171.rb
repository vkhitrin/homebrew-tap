class HelmfileAT0171 < Formula
  desc "Deploy Kubernetes Helm Charts"
  homepage "https://github.com/helmfile/helmfile"
  url "https://github.com/helmfile/helmfile/archive/refs/tags/v0.171.0.tar.gz"
  sha256 "593c51bc5b4e422d347706e1785f3ac2044b437369703907fb120b6ca23d333d"
  license "MIT"
  version_scheme 1
  head "https://github.com/helmfile/helmfile.git", branch: "main"

  depends_on "go" => :build
  depends_on "helm"

  conflicts_with "helmfile", because: "both install `helmfile` binaries"

  def install
    ldflags = %W[
      -s
      -w
      -X
      go.szostok.io/version.version=v#{version}
      -X
      go.szostok.io/version.buildDate=#{time.iso8601}
      -X
      go.szostok.io/version.commit="brew"
      -X
      go.szostok.io/version.commitDate=#{time.iso8601}
      -X
      go.szostok.io/version.dirtyBuild=false
    ]
    system("go", "build", *std_go_args(output: bin / "helmfile", ldflags:))

    generate_completions_from_executable(bin / "helmfile", "completion")
  end

  test do
    (testpath / "helmfile.yaml").write(
      <<~YAML
        repositories:
        - name: stable
          url: https://charts.helm.sh/stable

        releases:
        - name: vault            # name of this release
          namespace: vault       # target namespace
          createNamespace: true  # helm 3.2+ automatically create release namespace (default true)
          labels:                # Arbitrary key value pairs for filtering releases
            foo: bar
          chart: stable/vault    # the chart being installed to create this release, referenced by `repository/chart` syntax
          version: ~1.24.1       # the semver of the chart. range constraint is supported
      YAML
    )
    system Formula["helm"].opt_bin / "helm", "create", "foo"
    output = "Adding repo stable https://charts.helm.sh/stable"
    assert_match output, shell_output("#{bin}/helmfile -f helmfile.yaml repos 2>&1")
    assert_match version.to_s, shell_output("#{bin}/helmfile -v")
  end
end

class Simian < Formula
  desc "Detect duplicate code across large codebases"
  homepage "https://github.com/quandarypeak/simian"
  url "https://github.com/quandarypeak/simian/releases/download/v4.2.1/simian-4.2.1.jar"
  sha256 "b93b79c527476812b975b3dc322a967b6c47eab7c8bae5a9e2c56afdd562b423"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk"

  def install
    libexec.install "simian-#{version}.jar" => "simian.jar"
    bin.write_jar_script libexec/"simian.jar", "simian"
  end

  test do
    (testpath/"a.java").write <<~JAVA
      class A {
        void x() {
          int one = 1;
          int two = 2;
        }
      }
    JAVA

    (testpath/"b.java").write <<~JAVA
      class B {
        void x() {
          int one = 1;
          int two = 2;
        }
      }
    JAVA

    output = shell_output("#{bin}/simian -failOnDuplication- -threshold=2 '#{testpath}/*.java'")
    assert_match "Simian Similarity Analyzer #{version}", output
    assert_match "Found 6 duplicate lines in 2 blocks in 2 files", output
  end
end

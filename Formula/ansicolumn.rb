class Ansicolumn < Formula
  desc "ANSI sequence aware column command"
  homepage "https://github.com/tecolicom/App-ansicolumn"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansicolumn-1.5702.tar.gz"
  sha256 "52a183351b416120bf4dc3a22fa7d2fcb591fa3735fa02170e9c1badd981e2ec"

  depends_on "cpanminus" => :build
  depends_on "perl"

  def install
    ENV.prepend_create_path("PERL5LIB", libexec / "lib/perl5")

    system("tar", "-xzf", cached_download)
    module_dir = "App-ansicolumn-#{version}"

    cd(module_dir) do
      system("cpanm", "--notest", "--local-lib=#{libexec}", ".")
    end

    bin.install(Dir[libexec / "bin/*"])
    bin.env_script_all_files(libexec / "bin", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system "perl", "-e", "use App::ansicolumn;"
  end
end

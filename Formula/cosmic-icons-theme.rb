class CosmicIconsTheme < Formula
  desc "System76 Cosmic icon theme"
  homepage "https://github.com/pop-os/cosmic-icons"
  license "CC-BY-SA-4.0"
  head "https://github.com/pop-os/cosmic-icons.git", branch: "master"

  depends_on "just" => :build

  def install
    icons = Pathname.new("#{share}/icons/Cosmic")
    dirs = `find . -type d -regex '.*scalable.*' | sed -e 's/.*\\(scalable.*\\)/\\1/' | sort | uniq`.split("\n")
    dirs.each do |dir|
      category = icons / dir
      category.mkpath
      raise "Failed to create directory: #{catergory}" unless category.directory?
    end

    system("just --set prefix #{prefix} install")
  end

  test do
    assert_path_exists share / "icons/cosmic-icons/index.theme"
  end
end

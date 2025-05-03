cask("cosmicding") do
  version("2025.5.1")
  sha256("b0c5e98926327863d913fd912aba312cac1118a06e92c58b9c0b9e8232682fe1")

  url("https://github.com/vkhitrin/cosmicding/releases/download/v#{version}/cosmicding-v#{version}.dmg")
  name("Cosmicding")
  desc("linkding companion app")
  homepage("https://github.com/vkhitrin/cosmicding")

  livecheck do
    url(:url)
    strategy(:github_latest)
  end

  caveats(
    "A workaround for libcosmic to set XDG_DATA_DIRS will be installed, reboot in order to see application icons. Refer to https://github.com/pop-os/libcosmic/discussions/860"
  )

  depends_on(formula: "cosmic-icons-theme")

  app("Cosmicding.app")

  postflight do

    def share
      "#{HOMEBREW_PREFIX}/share"
    end

    plist_content = <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Label</key>
          <string>com.vkhitrin.setenv.XDG_DATA_DIRS</string>
          <key>ProgramArguments</key>
          <array>
              <string>launchctl</string>
              <string>setenv</string>
              <string>XDG_DATA_DIRS</string>
              <string>/opt/homebrew/share</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
      </dict>
      </plist>
    EOS

    plist_path = File.expand_path("~/Library/LaunchAgents/com.vkhitrin.setenv.XDG_DATA_DIRS.plist")

    File.write(plist_path, plist_content)

    system("/bin/launchctl bootstrap gui/#{Process.uid} #{Shellwords.escape(plist_path)}") || true

    system(
      "/bin/cp #{appdir}/Cosmicding.app/Contents/Resources/icons/hicolor/scalable/apps/com.vkhitrin.cosmicding.svg #{share}/icons/hicolor/scalable/apps/com.vkhitrin.cosmicding.svg"
    )
    system(
      "/bin/cp #{appdir}/Cosmicding.app/Contents/Resources/icons/hicolor/symbolic/apps/com.vkhitrin.cosmicding-symbolic.svg #{share}/icons/hicolor/symbolic/apps/com.vkhitrin.cosmicding-symbolic.svg"
    )
  end

  uninstall(
    launchctl: "com.vkhitirn.setenv.XDG_DATA_DIRS",
    delete: File.expand_path("~/Library/LaunchDaemons/com.vkhitrin.setenv.XDG_DATA_DIRS.plist")
  )

  zap(
    trash: [
      "#{HOMEBREW_PREFIX}/share/icons/hicolor/scalable/apps/com.vkhitrin.cosmicding.svg",
      "#{HOMEBREW_PREFIX}/share/icons/hicolor/symbolic/apps/com.vkhitrin.cosmicding-symbolic.svg"
    ]
  )
end

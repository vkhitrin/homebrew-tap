cask("cosmicding") do
  version("2025.5.0")
  sha256("9c3866173660e69f582746f727be96448ccc1b166a52f8b32b2ae8467c5c6fe8")

  url("https://github.com/vkhitrin/cosmicding/releases/download/v#{version}/cosmicding-v#{version}.dmg")
  name("cosmicding")
  desc("linkding companion app")
  homepage("https://github.com/vkhitrin/cosmicding")

  livecheck do
    url(:url)
    strategy(:github_latest)
  end

  depends_on(formula: "cosmic-icons-theme")

  app("cosmicding.app")

  postflight do
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
  end

  uninstall(
    launchctl: "com.vkhitirn.setenv.XDG_DATA_DIRS",
    delete: File.expand_path("~/Library/LaunchDaemons/com.vkhitrin.setenv.XDG_DATA_DIRS.plist")
  )
  caveats(
    "A workaround for libcosmic to set XDG_DATA_DIRS will be installed, reboot in order to see application icons. Refer to https://github.com/pop-os/libcosmic/discussions/860"
  )
end

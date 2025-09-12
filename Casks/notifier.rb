cask("notifier") do
  version("3.1")
  sha256("c8bdae27b0ffa675faaa0a94228822b6435f359bd32c9fca9992a5b4747ed09a")

  url("https://github.com/jamf/Notifier/releases/download/#{version}/Notifier-#{version}.pkg")
  name("Notifier")
  desc("Swift project which can post macOS alert or banner notifications")
  homepage("https://github.com/jamf/Notifier")

  pkg "Notifier-#{version}.pkg"

  caveats(
    "CLI must be invoked directly from /Applications/Utilities/Notifier.app/Contents/MacOS/Notifier",
    "Enable notifications for Notifier.app"
  )

  livecheck do
    url(:url)
    strategy(:github_latest)
  end
end

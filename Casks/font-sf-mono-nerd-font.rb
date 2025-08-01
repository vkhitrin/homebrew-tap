cask("font-sf-mono-nerd-font") do
  version(:latest)
  sha256("6d4a0b78e3aacd06f913f642cead1c7db4af34ed48856d7171a2e0b55d9a7945")

  url("https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg")
  name("SF Mono Nerd Font")
  desc("Patched Apple SF Mono fonts using local podman")
  homepage("https://github.com/ryanoasis/nerd-fonts")

  depends_on(formula: "podman")

  installer(
    script: {
      executable: "/bin/bash",
      args: [
        "-c",
        <<~EOS
          set -e
          set -o pipefail
          CONTAINER_HOST="unix:///var/run/docker.sock"
          echo "Checking podman connection..."
          podman ps >/dev/null
          echo "Creating temporary directories..."
          TEMP=$(mktemp --directory)
          pushd "${TEMP}" >/dev/null
          mkdir out
          pkgutil --expand "#{staged_path}/SF Mono Fonts.pkg" "#{staged_path}/pkg"
          cat "#{staged_path}/pkg/SFMonoFonts.pkg/Payload" | gunzip -dc | cpio -i >/dev/null 2>/dev/null
          echo "Starting to patch fonts using podman, this make take a while..."
          podman run --rm -v "${TEMP}/Library/Fonts:/in" -v "./out:/out" "docker.io/nerdfonts/patcher:latest" "-c"
          cp out/* "#{staged_path}"
          pushd "#{staged_path}" >/dev/null
          find . -mindepth 1 ! -name "*.otf" -prune -exec rm -rf {} +
          rm -rf "${TEMP}"
        EOS
      ],
      sudo: false
    }
  )
  font("SFMonoNerdFont-Bold.otf")
  font("SFMonoNerdFont-BoldItalic.otf")
  font("SFMonoNerdFont-Heavy.otf")
  font("SFMonoNerdFont-HeavyItalic.otf")
  font("SFMonoNerdFont-Italic.otf")
  font("SFMonoNerdFont-Light.otf")
  font("SFMonoNerdFont-LightItalic.otf")
  font("SFMonoNerdFont-Medium.otf")
  font("SFMonoNerdFont-MediumItalic.otf")
  font("SFMonoNerdFont-Regular.otf")
  font("SFMonoNerdFont-SemiBold.otf")
  font("SFMonoNerdFont-SemiBoldItalic.otf")
end

cask("swama") do
  version("v1.3.0")
  sha256("2a638eb493c888deae6ee4190a67eb2ba9b3e29f1c8877b38b1681f72fb29076")

  url("https://github.com/Trans-N-ai/swama/releases/download/#{version}/Swama.dmg")
  name("swama")
  desc("High-performance MLX-based LLM inference engine for macOS with native Swift implementation")
  homepage("https://github.com/Trans-N-ai/swama")

  livecheck do
    url(:url)
    strategy(:github_latest)
  end

  app("Swama.app")
end

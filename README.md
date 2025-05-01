# homebrew-tap

> [!NOTE]
> This repository contains tools provided by the community.

Homebrew formulae that allows installation of custom tools through the [Homebrew](https://brew.sh/) package manager.

## Installation

```
brew tap vkhitrin/tap
brew install <FORMULA>
brew install --cask <CASK>
```

## Formula

| Source                                                                  | Formula                                                  | Description                                              |
| ----------------------------------------------------------------------- | -------------------------------------------------------- | -------------------------------------------------------- |
| [dbohdan/initool](https://github.com/dbohdan/initool)                   | [initool.rb](./Formula/initool.rb)                       | CLI to Parse INI files.                                  |
| [tecolicom/App-ansicolumn](https://github.com/tecolicom/App-ansicolumn) | [ansicolumn.rb](./Formula/ansicolumn.rb)                 | `column` alternative which supports asci characters.     |
| [paulirish/git-open](https://github.com/paulirish/git-open)             | [git-open-helper.rb](./Formula/git-open-helper.rb)       | `git-open` script which is more robust.                  |
| [pop-os/cosmic-icons](https://github.com/pop-os/cosmic-icons)           | [cosmic-icons-theme.rb](./Formula/cosmic-icons-theme.rb) | COSMIC icons theme by [System76](https://system76.com/). |

## Casks

| Source                                                | Cask                                                           | Description                                                                                                                                                      |
| ----------------------------------------------------- | -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Apple Fonts](https://developer.apple.com/fonts/)     | [font-sf-mono-nerd-font.rb](./Casks/font-sf-mono-nerd-font.rb) | Dynamically patch fonts using [`podman`](https://podman.io/) container running <https://github.com/ryanoasis/nerd-fonts>. Generates Apple SF Mono patched fonts. |
| [vkhitrin/cosmicding](https://github.com/vkhitrin/cosmicding/) | [cosmicding.rb](./Casks/cosmicding.rb)                         | linkding companion app. |

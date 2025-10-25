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

| Source                                                                      | Formula                                                  | Description                                                                                                                             |
| --------------------------------------------------------------------------- | -------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| [dbohdan/initool](https://github.com/dbohdan/initool)                       | [initool.rb](./Formula/initool.rb)                       | CLI to Parse INI files.                                                                                                                 |
| [tecolicom/App-ansicolumn](https://github.com/tecolicom/App-ansicolumn)     | [ansicolumn.rb](./Formula/ansicolumn.rb)                 | `column` alternative which supports asci characters.                                                                                    |
| [paulirish/git-open](https://github.com/paulirish/git-open)                 | [git-open-helper.rb](./Formula/git-open-helper.rb)       | `git-open` script which is more robust.                                                                                                 |
| [pop-os/cosmic-icons](https://github.com/pop-os/cosmic-icons)               | [cosmic-icons-theme.rb](./Formula/cosmic-icons-theme.rb) | COSMIC icons theme by [System76](https://system76.com/).                                                                                |
| [helmfile/helmfile](https://github.com/helmfile/helmfile)                   | [helmfile@0171.rb](./Formula/helmfile@0171.rb)           | Version locked `helmfile` to `0.171.0`.                                                                                                 |
| [Yakitrak/obsidian-cli](https://github.com/Yakitrak/obsidian-cli)           | [obsidian-cli.rb](./Formula/obsidian-cli.rb)             | `obsidian-cli` from source (HEAD).                                                                                                      |
| [orobardet/gitlab-ci-linter](https://gitlab.com/orobardet/gitlab-ci-linter) | [gitlab-ci-linter.rb](./Formula/gitlab-ci-linter.rb)     | Tool for validating `.gitlab-ci.yml` using Gitlab API.                                                                                  |
| [docker CLI](https://docker.com)                                            | [docker-cli.rb](./Formula/docker-cli.rb)                 | **[Temporary]** Docker CLI binary.                                                                                                      |
| [dankamongmen/notcurses](https://github.com/dankamongmen/notcurses)         | [notcurses-tmux.rb](./Formula/notcurses-tmux.rb)         | **[Temporary]** notcurses with a [patch](https://github.com/dankamongmen/notcurses/issues/2736#issuecomment-2673414042) to support tmux |

## Casks

| Source                                                         | Cask                                                           | Description                                                                                                                                                      |
| -------------------------------------------------------------- | -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Apple Fonts](https://developer.apple.com/fonts/)              | [font-sf-mono-nerd-font.rb](./Casks/font-sf-mono-nerd-font.rb) | Dynamically patch fonts using [`podman`](https://podman.io/) container running <https://github.com/ryanoasis/nerd-fonts>. Generates Apple SF Mono patched fonts. |
| [vkhitrin/cosmicding](https://github.com/vkhitrin/cosmicding/) | [cosmicding.rb](./Casks/cosmicding.rb)                         | linkding companion app.                                                                                                                                          |
| [jamf/Notifier](https://github.com/jamf/Notifier)              | [notifier.rb](./Casks/notifier.rb)                             | Swift project which can post macOS alert or banner notifications.                                                                                                |

## Migrated Formulae's

| Repository                                                        | Migrated Tap     | Formula                                                                                     | Description                                           |
| ----------------------------------------------------------------- | ---------------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| [socktainer/socktainer](https://github.com/socktainer/socktainer) | `socktainer/tap` | [socktainer.rb](https://github.com/socktainer/homebrew-tap/blob/main/Formula/socktainer.rb) | Docker-compatible REST API on top of Apple container. |

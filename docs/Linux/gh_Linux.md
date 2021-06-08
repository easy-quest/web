# Installing gh on Linux and FreeBSD

Packages downloaded from [https://cli.github.com](https://cli.github.com/) or from https://github.com/cli/cli/releases are considered official binaries. We focus on popular Linux distros and the following CPU architectures: `i386`, `amd64`, `arm64`, `armhf`.

Other sources for installation are community-maintained and thus might lag behind our release schedule.

If none of our official binaries, packages, repositories, nor community sources work for you, we recommend using our `Makefile` to build `gh` from source. It's quick and easy.

## Official sources

### Debian, Ubuntu Linux (apt)

![warning](https://github.githubassets.com/images/icons/emoji/unicode/26a0.png) This will only work for the [architectures we officially support](https://github.com/cli/cli/blob/trunk/.goreleaser.yml#L27).

The below should work for any debian-based distribution. You can change `stable` to a specific codename [we support](https://github.com/cli/cli/blob/trunk/.github/workflows/releases.yml#L83) if that is your preference.

Install:

```sh
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install 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
```

**Note**: If you get *"gpg: failed to start the dirmngr '/usr/bin/dirmngr': No such file or directory"* error, try installing the `dirmngr` package. Run `sudo apt-get install dirmngr` and repeat the steps above.

Upgrade:

```sh
sudo apt update
sudo apt install gh
```

### 
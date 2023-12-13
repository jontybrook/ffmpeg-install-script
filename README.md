# FFmpeg Static Install Script

## TL;DR

This script installs the latest static build of FFmpeg (including ffprobe) on Ubuntu systems. 'Static' means that all libraries are compiled into the binary files, so no additional libraries are required. This makes it easy to install and use FFmpeg on any Ubuntu system.

> The script installs FFmpeg from [John Van Sickle's FFmpeg Builds](https://johnvansickle.com/ffmpeg/) - Special thanks to John for providing these builds. If you find this useful, please consider [donating to John](https://johnvansickle.com/ffmpeg/) to support his work.

### Quick Start

These one-liners will download and run the script, installing the latest static build of FFmpeg on your system. Note that any existing FFmpeg installations will be removed (omit the '--force' option to be prompted before removing existing installations).

#### One-line Install - Master Build (Recommended)

Install the latest 'master' FFmpeg build (from the [FFmpeg git master branch](https://github.com/FFmpeg/FFmpeg)):

```bash
wget -O - https://raw.githubusercontent.com/jontybrook/ffmpeg-install-script/main/install-ffmpeg-static.sh | bash -s -- --force
```

#### One-line Install - (Release Build)

Install the latest 'stable' (release) FFmpeg build:

```bash
wget -O - https://raw.githubusercontent.com/jontybrook/ffmpeg-install-script/main/install-ffmpeg-static.sh | bash -s -- --stable --force
```

## Overview

This script automates the installation of the latest static nightly build of FFmpeg on Ubuntu systems. Specifically designed for Ubuntu versions 16.04 and above on amd64 architecture, it should also work with other Linux distributions.

_DISCLAIMER - Be careful when running scripts downloaded from the internet. Always review them before executing them on your system._

## Features

- Automatically installs the latest FFmpeg static build.
- Supports multiple architectures: amd64, i686, armhf, and arm64.
- Checks and removes existing FFmpeg installations if needed.
- Copies ffmpeg and ffprobe binaries to `/usr/local/bin`.
- Vverifies downloaded files using md5 checksums.
- Tested on Ubuntu 18.04, 20.04, 22.04

### Motivation

The ffmpeg builds provided in Ubuntu's apt repository are old and out of date. This script was written to install ffmpeg in Docker container builds, but is perfectly suitable for use on any Ubuntu system.

## Prerequisites

- Ubuntu 16.04 or later (or compatible Linux distribution, any distro which uses the apt package manager should work).
- wget and md5sum installed (these are installed automatically if not present).
- User must have sudo privileges.
- Internet connection.

## Usage

Either use the quick start method above, or follow these steps:

1. Download the script or clone the repository containing it.
2. Make the script executable: `chmod +x install-ffmpeg-static.sh`.
3. Run the script: `./install-ffmpeg-static.sh`.
   - Use the `--force` option to forcibly remove existing FFmpeg installations.
   - Use the `--release` option to install the latest release build (rather than the latest master build).

## Important Notes

- The script installs `wget`, `md5sum`, and `nscd` as dependencies.
- Statically linking glibc in FFmpeg results in the loss of DNS resolution, which is fixed by installing `nscd`.
- The script will prompt for confirmation before removing any existing FFmpeg installations unless the `--force` option is used.

## Known Limitations

- The script is designed primarily for Ubuntu and might require modifications for other Linux distributions.
- Only supports specific architectures (amd64, i686, armhf, and arm64).

## Author

Developed by [me@jontyb.co.uk](mailto:me@jontyb.co.uk).

## Disclaimer

This script is provided "as is", without warranty of any kind. Users should run it at their own risk. Always review scripts downloaded from the internet before executing them on your system.

## License

MIT License

Copyright (c) 2023 Jonty Brook

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

#!/bin/bash

# This script will install the latest static nightly build of ffmpeg on Ubuntu 
echo "************************************************"
echo "************************************************"
echo "**** FFMPEG STATIC INSTALL SCRIPT"
echo "**** This script installs latest ffmpeg git master build from https://johnvansickle.com/ffmpeg/"
echo "**** See: https://github.com/jontybrook/ffmpeg-install-script"
echo "**** Author: me@jontyb.co.uk"
echo "************************************************"
echo "************************************************"
echo "Starting ffmpeg static install script..."

# If --stable is passed as an argument, install the latest release build of ffmpeg
# otherwise install the latest static 'git master' build of ffmpeg
$buildVersion = "git" # default to git master build
if [[ $1 == "--stable" ]]; then
    $buildVersion = "release"
    echo "Installing the latest stable build of ffmpeg"
fi

# Install dependencies needed to run this script
echo "Installing wget and md5sum (needed to run this script)"
sudo apt-get install wget md5sum

# Delete the /tmp/ffmpeg-install directory if it exists
echo "Deleting /tmp/ffmpeg-install directory if it exists"
rm -rf /tmp/ffmpeg-install

# create and cd into /tmp/ffmpeg-install
echo "Creating and navigating to /tmp/ffmpeg-install directory"
mkdir -p /tmp/ffmpeg-install
cd /tmp/ffmpeg-install

# Find the architecture of the system
echo "Finding the architecture of the system"
# Get the architecture using uname
arch=$(uname -m)

# Map the uname output to your required format
$architecture = ""
case $arch in
    x86_64)
        echo "Detected amd64 architecture. The appropriate ffmpeg build will be downloaded"
        $architecture = "amd64"
        ;;
    i686 | i386)
        echo "Detected i686 architecture. The appropriate ffmpeg build will be downloaded"
        $architecture = "i686"
        ;;
    armv6l | armv7l)
        echo "Detected armhf architecture. The appropriate ffmpeg build will be downloaded"
        $architecture = "armhf"
        ;;
    aarch64)
        echo "Detected arm64 architecture. The appropriate ffmpeg build will be downloaded"
        ;;
    *)
        echo "!!!!!!!!!!!!"
        echo "FFMPEG INSTALL FAILED: Unknown architecture: $arch"
        echo "This script only works on amd64, i686, armhf and arm64 architectures"
        echo "The script will now exit"
        echo "!!!!!!!!!!!!"
        echo "FFMPEG INSTALL FAILED: Unknown architecture: $arch" >&2
        exit 1
        ;;
esac

# Download the latest static nightly build of ffmpeg
echo "Downloading the latest static nightly build of ffmpeg"
wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-$architecture-static.tar.xz

# Download the md5 checksum file
echo "Downloading the md5 checksum file..."
wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-$architecture-static.tar.xz.md5

# Verify the checksum
echo "Verifying the checksum of the downloaded file.."
md5sum -c ffmpeg-git-amd64-static.tar.xz.md5

# Unpack the build
echo "Unpacking the build.."
tar xvf ffmpeg-git-amd64-static.tar.xz

# Find the directory name of the unpacked build (it changes with each nightly build) and cd into it. 
# The format is ffmpeg-git-YYYYMMDD-amd64-static
echo "Navigating to the unpacked build directory"
cd ffmpeg-git-*/

# Cat out the readme so we can log it during builds that use this script
echo "Displaying the contents of readme.txt"
cat readme.txt

# ! Important note - From readme.txt in version ffmpeg-git-20231128-amd64-static...
#  "A limitation of statically linking glibc is the loss of DNS resolution. Installing
#  nscd through your package manager will fix this."

# Install nscd 
echo "Installing nscd"
sudo apt-get install nscd

# Check if FFmpeg is installed using apt
if dpkg -s ffmpeg &>/dev/null; then
    echo "FFmpeg is already installed using apt"
    if [[ $1 == "--force" ]]; then
        echo "Removing ffmpeg..."
        sudo apt-get remove ffmpeg
    else
        read -p "Do you want to remove it? (y/n): " answer
        if [[ $answer == "y" ]]; then
            echo "Removing ffmpeg..."
            sudo apt-get remove ffmpeg
        fi
    fi
fi

# Check if ffmpeg is installed via some other method
if hash ffmpeg 2>/dev/null; then
    echo "ffmpeg is already installed at $(which ffmpeg)"
    if [[ $1 == "--force" ]]; then
        echo "Removing ffmpeg..."
        sudo rm $(which ffmpeg)
    else
        read -p "Do you want to remove it? (y/n): " answer
        if [[ $answer == "y" ]]; then
            echo "Removing ffmpeg..."
            sudo rm $(which ffmpeg)
        fi
    fi
fi


# Copy the ffmpeg and ffprobe binaries to /usr/local/bin
echo "Copying ffmpeg and ffprobe binaries to /usr/local/bin"
sudo cp ffmpeg ffprobe /usr/local/bin

# Check the version of ffmpeg
echo "Checking the version of ffmpeg"
ffmpeg -version

echo "************************************************"
echo "** Finished installing ffmpeg static build to /usr/local/bin"
echo "************************************************"

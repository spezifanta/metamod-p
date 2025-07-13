#!/usr/bin/env bash

# MetaMod-P Development Environment Setup Script
# Sets up Ubuntu 22.04 with toolchain for building MetaMod-P

set -e

echo "Setting up MetaMod-P development environment..."

# Enable i386 architecture for 32-bit support
dpkg --add-architecture i386
apt-get update

# Install essential build tools
apt-get install -y \
    build-essential \
    make \
    gcc \
    g++ \
    gcc-multilib \
    g++-multilib \
    libc6-dev:i386 \
    libgcc-s1:i386 \
    lib32stdc++6 \
    lib32z1-dev

# Install MinGW for Windows cross-compilation
apt-get install -y \
    mingw-w64 \
    gcc-mingw-w64-i686 \
    g++-mingw-w64-i686 \
    binutils-mingw-w64-i686

# Install additional development tools
apt-get install -y \
    git \
    vim \
    curl \
    file \
    strace \
    gdb

# Clean up
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "Verifying toolchain installation..."

# Verify GCC installation
gcc --version
gcc -m32 --version

# Verify MinGW installation
i686-w64-mingw32-gcc --version

# Verify 32-bit compilation capability
echo 'int main(){return 0;}' > test.c
gcc -m32 test.c -o test32 && echo "✓ 32-bit compilation works"
i686-w64-mingw32-gcc test.c -o test.exe && echo "✓ Windows cross-compilation works"
rm -f test.c test32 test.exe

echo "Setup complete! You can now build MetaMod-P with:"
echo "  make          # Build all components (DEBUG)"
echo "  make OPT=opt  # Build with optimizations (RELEASE)"
echo "  make clean    # Clean build artifacts"

# Set working directory
cd /workspace

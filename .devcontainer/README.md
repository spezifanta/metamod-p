# MetaMod-P DevContainer

This DevContainer provides a complete development environment for building MetaMod-P.

## Environment Details

- **Base Image**: Ubuntu 22.04 
- **Architecture**: 32-bit compilation support (i386)
- **Compilers**: 
  - GCC with multilib (32-bit support)
  - MinGW-w64 for Windows cross-compilation
- **Standards**: C99, C++98 (as required by the project)

## Usage

1. Open the project in VS Code
2. VS Code will prompt to "Reopen in Container" - click it
3. Wait for the container to build and setup to complete
4. Build the project:
   ```bash
   make          # Build all components
   make clean    # Clean build artifacts
   ```

## What's Included

- **Build Tools**: make, gcc, g++, multilib support
- **Cross-Compilation**: MinGW for Windows targets
- **32-bit Libraries**: libc6-dev:i386, libgcc-s1:i386, lib32stdc++6
- **Development Tools**: git, gdb, vim, nano
- **VS Code Extensions**: C/C++ tools, Makefile support

## Project Structure

- `metamod/` - Core MetaMod library
- `*_plugin/` - Various plugin implementations
- `hlsdk/` - Half-Life SDK headers
- `tools/` - Build utilities

The build system automatically detects your platform and builds appropriate targets (Linux .so files, Windows .dll files).

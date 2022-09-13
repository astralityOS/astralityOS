#!/bin/bash
# Main script that will call all of the other scripts

ROOT=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd -P) # Get directory of current script

source "$ROOT/config" # Source the configuration file for build
source "$ROOT/Scripts/Kernel/mkernel.sh" # Source the kernel fetch/compilation script

fetchkernel # Download kernel
buildkernel # Compile kernel


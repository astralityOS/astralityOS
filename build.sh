#!/bin/bash
# Main script that will call all of the other scripts

ROOT=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd -P) # Get directory of current script

function verifyEssentialFiles() {

    FILES=("$fetchKernelScriptPath" "$rootfsScriptPath" "$DEVICECONFIGPATH" "$BUILDDIR")
    for i in "${FILES[@]}"; do
        if [ -f "$i" ]; then
            true
        else
            echo "FATAL: Essential file not found!"
            exit 1
        fi
    done
}

CONFIGPATH="${ROOT}/config"

if [ -f "$CONFIGPATH" ]; then
    source "$CONFIGPATH" # Inherit variables defined in config
else
    echo "FATAL: Config not found!"
    exit 1
fi

fetchKernelScriptPath="${ROOT}/Scripts/Kernel/fetchkernel.sh"
rootfsScriptPath="${ROOT}/Scripts/Filesystem/mkrootfs.sh"
DEVICECONFIGPATH="$ROOT/Devices/$TARGET_VENDOR/$TARGET_NAME.device"
BUILDDIR="$ROOT/Devices/$TARGET_VENDOR"

verifyEssentialFiles

function build_kernel(){
    
    # Execute the kernel fetch script with the arguments of the device file and the directory root (probably not needed)
    /bin/bash "$fetchKernelScriptPath" "$ROOT/Devices/$TARGET_VENDOR/$TARGET_NAME.device" "$ROOT" "$CONFIGPATH"

}

function build_rootfs() {
    /bin/bash "$rootfsScriptPath" "$ROOT" "$CONFIGPATH" "$DEVICECONFIGPATH" "$BUILDDIR"
}

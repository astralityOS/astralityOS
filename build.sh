#!/bin/bash
# Main script that will call all of the other scripts

ROOT=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd -P) # Get directory of current script
CONFIGPATH="${ROOT}/config"

# Make sure config exists
if test -f "$CONFIGPATH"; then
    source "$CONFIGPATH" # Inherit variables defined in config
else 
    echo "Config File Not Found, Exiting!"
    exit 0
fi

DEVICECONFIGPATH="$ROOT/Devices/$TARGET_VENDOR/$TARGET_NAME.device"
BUILDDIR="$ROOT/Devices/$TARGET_VENDOR"
fetchKernelScriptPath="${ROOT}/Scripts/Kernel/fetchkernel.sh"
rootfsScriptPath="${ROOT}/Scripts/Filesystem/mkrootfs.sh"


# Make sure device config exists

if test -f "$DEVICECONFIGPATH"; then
    echo "found device config"
else 
    echo "Device Config File Not Found, Exiting!"
    exit 0
fi

# Make sure kernel fetch script exists, and if so, execute it
if test -f "$fetchKernelScriptPath"; then
    # Execute the kernel fetch script with the arguments of the device file and the directory root (probably not needed)
    /bin/bash "$fetchKernelScriptPath" "$ROOT/Devices/$TARGET_VENDOR/$TARGET_NAME.device" "$ROOT" "$CONFIGPATH"
else 
    echo "Kernel Fetch Script Not Found! Exiting!"
    exit 0
fi

# Make sure rootfs script exists, and if so, execute it
if test -f "$rootfsScriptPath"; then
    # Execute the kernel fetch script with the arguments of the device file and the directory root (probably not needed)
    /bin/bash "$rootfsScriptPath" "$ROOT" "$CONFIGPATH" "$DEVICECONFIGPATH" "$BUILDDIR"
else 
    echo "RootFS Script Not Found! Exiting!"
    exit 0
fi

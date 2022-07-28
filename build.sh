#!/bin/bash
# Main script that will call all of the other scripts

ABSPATH=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd -P) # Get directory of current script
CONFIGPATH="${ABSPATH}/config"
fetchKernelScriptPath="${ABSPATH}/Scripts/Kernel/fetchkernel.sh"

# Make sure config exists

if test -f "$CONFIGPATH"; then
    source "$CONFIGPATH" # Inherit variables defined in config
else 
    echo "Config File Not Found, Exiting!"
    exit 0
fi

# Make sure device config exists

if test -f "$ABSPATH/Devices/$TARGET_VENDOR/$TARGET_DEVICE.device"; then
    echo "found device config"
else 
    echo "Device Config File Not Found, Exiting!"
    exit 0
fi

# Make sure kernel fetch script exists, and if so, execute it
if test -f "$fetchKernelScriptPath"; then
    # Execute the kernel fetch script with the arguments of the device file and the directory root (probably not needed)
    /bin/bash "$fetchKernelScriptPath" "$ABSPATH/Devices/$TARGET_VENDOR/$TARGET_DEVICE.device" "$ABSPATH"
else 
    echo "Kernel Fetch Script Not Found! Exiting!"
    exit 0
fi

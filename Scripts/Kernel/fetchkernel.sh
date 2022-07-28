#The device config should specifiy the kernel, defconfig, etc

ABSPATH=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd -P) # Get directory of current script
source "${ABSPATH}/../../config" # Inherit variables defined in config




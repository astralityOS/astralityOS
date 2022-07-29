#The device config should specifiy the kernel, defconfig, etc

source $3 # Source the config file provided in args
source $1 # Source the device file provided in args


cd "$2" # Make sure we're in the root dir

rm -rf "Build/$TARGET_VENDOR/$TARGET_NAME/"
mkdir -p "Build/$TARGET_VENDOR/$TARGET_NAME/Kernel"
cd "Build/$TARGET_VENDOR/$TARGET_NAME/Kernel"

git clone "$kernel_repo" "--depth=1"
cd "$2/Build/$TARGET_VENDOR/$TARGET_NAME/Kernel/linux" # todo figure out how to CD in to the repos name 
make "ARCH=$arch" "CROSS_COMPILE=$cross_compiler" "$kernel_defconfig" "-j8"
make "ARCH=$arch" "CROSS_COMPILE=$cross_compiler" "$kernel_image" "modules dtbs -j8"

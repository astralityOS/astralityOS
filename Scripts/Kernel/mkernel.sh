#The device config should specify the kernel, defconfig, etc

cores=$(nproc)

function fetchkernel()
{
    rm -rf "$ROOT/Build/$TARGET_VENDOR/$TARGET_NAME/"
    mkdir -p "$ROOT/Build/$TARGET_VENDOR/$TARGET_NAME/Kernel"
    cd "$ROOT/Build/$TARGET_VENDOR/$TARGET_NAME/Kernel"

    git clone "$kernel_repo" "--depth=1"
    
}

function buildkernel()
{
    cd "$ROOT/Build/$TARGET_VENDOR/$TARGET_NAME/Kernel/linux" # todo figure out how to CD in to the repos name 
    make "ARCH=$arch" "CROSS_COMPILE=$cross_compiler" "$kernel_defconfig" "-j$cores"
    make "ARCH=$arch" "CROSS_COMPILE=$cross_compiler" "$kernel_image" "modules dtbs" "-j$cores"
}

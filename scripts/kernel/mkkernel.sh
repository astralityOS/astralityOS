echo "cloning kernel"

#rm -r $builddir/kernel
#cleaning failed attempts

mkdir $builddir/kernel_source
mkdir $builddir/kernel_out

if [ -f $builddir/kernel_source/Makefile ]; then #perhaps check for something else?
    echo -e "kernel source already exits"
else
    git clone --depth 1 $kernel $builddir/kernel_source || error "error cloning kernel"
fi

if [[ $cross == *"1"* ]]; then
    amake="make ARCH=$arch CROSS_COMPILE=$crosscompiler -j$(nproc) -C $builddir/kernel_source O=$builddir/kernel_out"
else
    amake="make -j$(nproc) -C $builddir/kernel_source O=$builddir/kernel_out"
fi

if [ -f $builddir/kernel_out/.tmp ]; then #TODO: check for kernel image insead of tmp
    echo -e "kernel already exits"
    return 0
else
    echo "generating config"
    
    $amake $defconfig

    $amake menuconfig #make this an option if this becomes public
    
    echo "building kernel"
    
    $amake || error "error compiling kernel, please check output"
fi

touch $builddir/kernel_out/.tmp

echo "kernel is done"

u-dma-buf kernel module debian package
====================================================================================

Overview
------------------------------------------------------------------------------------

### Introduction

This is a repository for making udmabuf kernel module debian package.

Udmabuf is a Linux device driver that allocates contiguous memory blocks in the kernel space as DMA buffers and makes them available from the user space.

For details of udmabuf, please refer to following URL.

  * https://github.com/ikwzm/udmabuf

Build Debian Package
------------------------------------------------------------------------------------

### Download repository

```console
shell$ git clone --recursive --depth=1 -b v4.4.2 git://github.com/ikwzm/u-dma-buf-kmod-dpkg
shell$ cd u-dma-buf-kmod-dpkg
```

### Cross Compile

#### Parameters

| Parameter Name | Description              | Default Value                                                    |
|----------------|--------------------------|------------------------------------------------------------------|
| kernel_release | Kernel Release Name      | $(shell uname -r)                                                |
| arch           | Architecture Name        | $(shell uname -m \| sed -e s/arm.\*/arm/ -e s/aarch64.\*/arm64/) |
| deb_arch       | Debian Architecture Name | $(shell dpkg --print-architecture)                               |
| kernel_src_dir | Kernel Source Directory  | /lib/modules/$(kernel_release)/build                             |


```console
shell$ sudo debian/rules arch=arm deb_arch=armhf kernel_release=6.1.22-armv7-fpga kernel_src_dir=/usr/src/linux-6.1.22-armv7-fpga binary
    :
    :
    :
shell$ file ../u-dma-buf-6.1.22-armv7-fpga_4.4.2-0_armhf.deb 
../u-dma-buf-6.1.22-armv7-fpga_4.4.2-0_armhf.deb: Debian binary package (format 2.0)
shell$ file ../u-dma-buf-mgr-6.1.22-armv7-fpga_4.4.2-0_armhf.deb 
../u-dma-buf-mgr-6.1.22-armv7-fpga_4.4.2-0_armhf.deb: Debian binary package (format 2.0)
```

### Self Compile

```console
shell$ sudo debian/rules binary
    :
    :
    :
shell$ file ../u-dma-buf-6.1.22-armv7-fpga_4.4.2-0_armhf.deb 
../u-dma-buf-6.1.22-armv7-fpga_4.4.2-0_armhf.deb: Debian binary package (format 2.0)
shell$ file ../u-dma-buf-mgr-6.1.22-armv7-fpga_4.4.2-0_armhf.deb 
../u-dma-buf-mgr-6.1.22-armv7-fpga_4.4.2-0_armhf.deb: Debian binary package (format 2.0)
```


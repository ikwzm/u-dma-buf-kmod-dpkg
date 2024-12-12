prefix         ?= 
curr_dir       ?= $(shell pwd)
kernel_release ?= $(shell uname -r)
arch           ?= $(shell uname -m | sed $(subarch_script))
lib_dir        ?= $(prefix)/lib/modules/$(kernel_release)/ikwzm
kernel_src_dir ?= /lib/modules/$(kernel_release)/build

config_udmabuf += CONFIG_U_DMA_BUF_IN_KERNEL_FUNCTIONS=y
module_symvers ?= KBUILD_EXTRA_SYMBOLS=$(curr_dir)/u-dma-buf/Module.symvers
subarch_script := -e s/i.86/x86/ -e s/x86_64/x86/ \
		  -e s/sun4u/sparc64/ \
		  -e s/arm.*/arm/ -e s/sa110/arm/ \
		  -e s/s390x/s390/ \
		  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
		  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
		  -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/

.PHONY: all install

all:
	cd ./u-dma-buf     ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) $(config_udmabuf) all   ; cd $(curr_dir)
	cd ./u-dma-buf-mgr ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) $(module_symvers) all   ; cd $(curr_dir)

clean:
	cd ./u-dma-buf     ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) $(config_udmabuf) clean ; cd $(curr_dir)
	cd ./u-dma-buf-mgr ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) $(module_symvers) clean ; cd $(curr_dir)

install:
	install -d $(lib_dir)
	install -m 0644 u-dma-buf/u-dma-buf.ko $(lib_dir)
	install -m 0644 u-dma-buf-mgr/u-dma-buf-mgr.ko $(lib_dir)

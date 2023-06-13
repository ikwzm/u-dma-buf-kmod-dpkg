prefix         ?= 
curr_dir       ?= $(shell pwd)
kernel_release ?= $(shell uname -r)
arch           ?= $(shell uname -m | sed -e s/arm.*/arm/ -e s/aarch64.*/arm64/)
lib_dir        ?= $(prefix)/lib/modules/$(kernel_release)/ikwzm
kernel_src_dir ?= /lib/modules/$(kernel_release)/build

module_symvers ?= KBUILD_EXTRA_SYMBOLS=$(curr_dir)/u-dma-buf/Module.symvers

.PHONY: all install

all:
	cd ./u-dma-buf     ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir)                   all   ; cd $(curr_dir)
	cd ./u-dma-buf-mgr ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) $(module_symvers) all   ; cd $(curr_dir)

clean:
	cd ./u-dma-buf     ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir)                   clean ; cd $(curr_dir)
	cd ./u-dma-buf-mgr ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) $(module_symvers) clean ; cd $(curr_dir)

install:
	install -d $(lib_dir)
	install -m 0644 u-dma-buf/u-dma-buf.ko $(lib_dir)
	install -m 0644 u-dma-buf-mgr/u-dma-buf-mgr.ko $(lib_dir)

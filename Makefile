prefix         ?= 
curr_dir       ?= $(shell pwd)
kernel_release ?= $(shell uname -r)
arch           ?= $(shell uname -m | sed -e s/arm.*/arm/ -e s/aarch64.*/arm64/)
lib_dir        ?= $(prefix)/lib/modules/$(kernel_release)/ikwzm
kernel_src_dir ?= /lib/modules/$(kernel_release)/build

config_list    ?= CONFIG_U_DMA_BUF_MGR=m

.PHONY: all install

all:
	cd ./u-dma-buf ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) $(config_list) all   ; cd $(curr_dir)

clean:
	cd ./u-dma-buf ; $(MAKE) ARCH=$(arch) KERNEL_SRC_DIR=$(kernel_src_dir) $(config_list) clean ; cd $(curr_dir)

install-u-dma-buf: all
	install -d $(lib_dir)
	install -m 0644 u-dma-buf/u-dma-buf.ko $(lib_dir)

install-u-dma-buf-mgr: all
	install -d $(lib_dir)
	install -m 0644 u-dma-buf/u-dma-buf-mgr.ko $(lib_dir)

install: install-u-dma-buf install-u-dma-buf-mgr

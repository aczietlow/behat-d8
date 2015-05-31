VAGRANT_MACHINE_PATH := .vagrant/machines/default
VAGRANT_MACHINE_PATH_VMWARE := $(VAGRANT_MACHINE_PATH)/vmware_fusion
VAGRANT_MACHINE_VMWARE_LOCATION = $(dir $(shell cat $(VAGRANT_MACHINE_PATH_VMWARE)/id))

VMWARE_BIN := /Applications/VMware\ Fusion.app/Contents/Library
VMWARE_VDISKMANAGER := $(VMWARE_BIN)/vmware-vdiskmanager

MAKER_BOX_NAME ?= ubuntu-default
MAKER_BOX_VERSION := $(shell cat VERSION)

.PHONY: all clean vmware virtualbox

all: clean vmware virtualbox

clean:
	vagrant halt -f
	vagrant destroy -f || true
	rm -f build/*.box

vmware:
	vagrant up --provider=vmware_fusion
	vagrant halt
	# We have to run the export in a separate process because Make evauluates all variables before executing,
	# therefore the .vagrant/machines/default/vmware_fusion/id is not yet available until after the above
	# command is executed.
	# See: http://stackoverflow.com/questions/9081841/makefile-assign-command-output-to-variable
	make vmware-export

vmware-export:
	$(VMWARE_BIN)/vmware-vdiskmanager -d $(VAGRANT_MACHINE_VMWARE_LOCATION)disk.vmdk
	$(VMWARE_BIN)/vmware-vdiskmanager -k $(VAGRANT_MACHINE_VMWARE_LOCATION)disk.vmdk
	rm $(VAGRANT_MACHINE_VMWARE_LOCATION)vmware.log
	tar czvf build/$(MAKER_BOX_NAME)-vmware-$(MAKER_BOX_VERSION).box -C $(VAGRANT_MACHINE_VMWARE_LOCATION) .

virtualbox:
	vagrant up --provider=virtualbox
	vagrant halt
	vagrant package --output build/$(MAKER_BOX_NAME)-virtualbox-$(MAKER_BOX_VERSION).box

print-%:
	@echo '$*=$($*)'
	@echo '  origin = $(origin $*)'
	@echo '  flavor = $(flavor $*)'
	@echo '   value = $(value  $*)'

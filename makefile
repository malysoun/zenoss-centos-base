#
# RPM builder for Zenoss base depenencies
#

NAME    ?= zenoss-centos-deps
IMAGENAME = zenoss-centos-base
VERSION ?= 1.1.4_dev
ITERATION ?= 1
PLATFORM = x86_64
RPM =  $(NAME)-$(VERSION)-$(ITERATION).$(PLATFORM).rpm

default: build

# Clean staged files and produced packages
.PHONY: clean
clean: 
	rm -f Dockerfile && (cd rpm && make clean)

.PHONY: mrclean
mrclean: clean

# Make an RPM
rpm/pkgroot/$(RPM):
	cd rpm && make rpm VERSION=$(VERSION) NAME=$(NAME) ITERATION=$(ITERATION) PLATFORM=$(PLATFORM) RPM=$(RPM)

Dockerfile: 
	sed -e 's/%RPM%/$(RPM)/g' Dockerfile.in > Dockerfile


# Make image for building RPM
build: rpm/pkgroot/$(RPM) Dockerfile
	docker build -t $(IMAGENAME):$(VERSION) .

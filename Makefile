JAR_NAME := payload.jar

MAKEFILE_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
BDJSDK_HOME  ?= $(MAKEFILE_DIR)/../../../../
JAVA8_HOME    ?= $(BDJSDK_HOME)/host/jdk8
JAVAC        := $(JAVA8_HOME)/bin/javac
JAR          := $(JAVA8_HOME)/bin/jar

export JAVA8_HOME

CLASSPATH     := $(BDJSDK_HOME)/target/lib/enhanced-stubs.zip:$(BDJSDK_HOME)/target/lib/bdjstack.jar:$(BDJSDK_HOME)/target/lib/pbp.jar:../../discdir/BDMV/JAR/00000.jar
SOURCES       := $(wildcard src/org/homebrew/*.java)
JFLAGS        := -Xlint:-options -source 1.4 -target 1.4

all: $(JAR_NAME)

# Create JAR with manifest
$(JAR_NAME): $(SOURCES) Manifest.txt
	$(JAVAC) $(JFLAGS) -cp $(CLASSPATH) $(SOURCES)
	mkdir -p build
	rsync -a bin/ build/
	rsync -a --exclude='*.java' --exclude='*.bak' src/ build/
	rsync -a ps5_autoload_elf/ps5_autoload.elf build/ps5_autoload.elf
	rsync -a ps5_killdiscplayer_elf/ps5_killdiscplayer.elf build/ps5_killdiscplayer.elf
	$(JAR) cfm $@ Manifest.txt -C build/ .
	cp -f $(JAR_NAME) ../../$(JAR_NAME)

clean:
	rm -rf build src/org/homebrew/*.class $(JAR_NAME)

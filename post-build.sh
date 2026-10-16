#!/bin/sh

set -ex

# Create the fwup ops script for handling disk operations at runtime
# (revert, prevent-revert, factory-reset)
mkdir -p $TARGET_DIR/usr/share/fwup

$HOST_DIR/usr/bin/fwup -c \
  -f $NERVES_DEFCONFIG_DIR/fwup-ops.conf \
  -o $TARGET_DIR/usr/share/fwup/ops.fw

ln -sf ops.fw $TARGET_DIR/usr/share/fwup/revert.fw

# Copy the fwup includes to the images dir
cp -rf $NERVES_DEFCONFIG_DIR/fwup_include $BINARIES_DIR

# Pre-format the application partition. On a real device nerves_runtime
# formats it on the first boot and mounts it without the sync options from
# erlinit.config; in the browser that first session is the one that matters,
# and only writes the guest has flushed survive the tab closing. Shipping a
# ready-made f2fs image means erlinit mounts it (sync,dirsync) from the very
# first boot. The size must match APP_PART_COUNT in fwup-common.conf.
APP_PART_COUNT=$(sed -n 's/^define(APP_PART_COUNT, *\([0-9]*\)).*/\1/p' $NERVES_DEFCONFIG_DIR/fwup_include/fwup-common.conf)
rm -f $BINARIES_DIR/appfs.img
truncate -s $((APP_PART_COUNT * 512)) $BINARIES_DIR/appfs.img
$HOST_DIR/sbin/mkfs.f2fs -f -q -l appdata $BINARIES_DIR/appfs.img

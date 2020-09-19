#!/bin/bash

# CLONE_DIR and TARGET_DIR are set in the Dockerfile
cp $CLONE_DIR/target/release/alacritty $TARGET_DIR
cp $CLONE_DIR/extra/alacritty.info $TARGET_DIR 
cp $CLONE_DIR/extra/logo/alacritty-term.svg $TARGET_DIR
cp $CLONE_DIR/extra/linux/Alacritty.desktop $TARGET_DIR
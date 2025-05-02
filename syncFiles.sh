#!/bin/bash

# source and destination paths
SOURCE="$HOME/.config/"
DEST="$HOME//Documents/GitHub/arch-susurmi/.config/"

# Run rsync with options:
# -a : archive mode (preserves symlinks, permissions, etc.)
# -v : verbose output
# -h : human-readable numbers
# --delete : delete files from destination that are no longer in the source directory
rsync -avh --delete "$SOURCE" "$DEST"

echo "Backup complete: $SOURCE -> $DEST"

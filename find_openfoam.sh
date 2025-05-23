#!/bin/bash

echo "Searching for OpenFOAM installations..."
echo "======================================="

# Common OpenFOAM installation paths
SEARCH_PATHS=(
    "/opt/openfoam*"
    "/usr/lib/openfoam*"
    "/home/*/OpenFOAM*"
    "/usr/local/openfoam*"
    "$HOME/OpenFOAM*"
)

for path_pattern in "${SEARCH_PATHS[@]}"; do
    for path in $path_pattern; do
        if [ -d "$path" ]; then
            echo "Found: $path"
            if [ -f "$path/etc/bashrc" ]; then
                echo "  -> Has bashrc: $path/etc/bashrc"
            fi
        fi
    done
done

echo ""
echo "Checking for blockMesh command..."
which blockMesh 2>/dev/null && echo "blockMesh found in PATH" || echo "blockMesh NOT found in PATH"

echo ""
echo "Checking environment variables..."
echo "WM_PROJECT_DIR: ${WM_PROJECT_DIR:-NOT SET}"
echo "FOAM_RUN: ${FOAM_RUN:-NOT SET}"
echo "WM_OPTIONS: ${WM_OPTIONS:-NOT SET}"

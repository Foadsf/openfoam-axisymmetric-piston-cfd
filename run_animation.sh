#!/bin/bash

set -e

CASE_DIR="/home/foad/openfoam_cases/axisymmetric_piston_mwe"

echo "========================================"
echo "OpenFOAM Transient Animation Simulation"
echo "========================================"

cd "$CASE_DIR"

# Set OpenFOAM environment
export WM_PROJECT_DIR="/usr/share/openfoam"
export FOAM_RUN="$HOME/openfoam_cases"
export WM_OPTIONS="linux64GccDPInt32Opt"

echo "✓ OpenFOAM environment ready"

# Clean previous runs (but preserve 0 directory)
echo "🧹 Cleaning previous runs..."
rm -rf constant/polyMesh processor* *.foam *.log *.mp4 2>/dev/null || true
find . -name "[0-9]*" ! -name "0" -delete 2>/dev/null || true
find . -name "[0-9]*.[0-9]*" -delete 2>/dev/null || true

# Generate mesh
echo "🔧 Generating mesh..."
blockMesh > blockMesh.log 2>&1

# Check mesh
echo "🔍 Checking mesh..."
checkMesh > checkMesh.log 2>&1

# Run transient simulation
echo "🚀 Running transient simulation with icoFoam..."
icoFoam > icoFoam.log 2>&1

# Create .foam file
touch case.foam

echo ""
echo "✅ Transient simulation completed!"
echo ""
TIME_DIRS=$(ls -1d [0-9]* [0-9]*.[0-9]* 2>/dev/null | wc -l)
echo "📊 Time directories created: $TIME_DIRS"
echo "🎬 Ready for animation creation"

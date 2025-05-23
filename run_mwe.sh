#!/bin/bash

# MWE OpenFOAM Axisymmetric Piston-Cylinder Simulation
# Complete automated run script

set -e  # Exit on any error

CASE_DIR="/home/foad/openfoam_cases/axisymmetric_piston_mwe"

echo "========================================"
echo "OpenFOAM Axisymmetric Piston-Cylinder MWE"
echo "========================================"

# Check if we're in the right directory
if [[ ! "$(pwd)" == "$CASE_DIR" ]]; then
    echo "Changing to case directory: $CASE_DIR"
    cd "$CASE_DIR"
fi

# Set OpenFOAM environment variables for package installation
export WM_PROJECT_DIR="/usr/share/openfoam"
export FOAM_RUN="$HOME/openfoam_cases"
export WM_OPTIONS="linux64GccDPInt32Opt"

# Verify OpenFOAM is available
if ! command -v blockMesh >/dev/null 2>&1; then
    echo "❌ blockMesh command not found. Please install OpenFOAM."
    exit 1
fi

echo "✓ OpenFOAM environment ready"

# Clean previous runs
echo "🧹 Cleaning previous runs..."
if [ -d "constant/polyMesh" ]; then
    rm -rf constant/polyMesh
fi
if [ -d "processor*" ]; then
    rm -rf processor*
fi
find . -name "*.foam" -delete 2>/dev/null || true
find . -type d -name "[0-9]*" ! -name "0" -exec rm -rf {} + 2>/dev/null || true

# Generate mesh
echo "🔧 Generating mesh..."
if ! blockMesh > blockMesh.log 2>&1; then
    echo "❌ Mesh generation failed. Check blockMesh.log"
    exit 1
fi

# Check mesh quality
echo "🔍 Checking mesh quality..."
if ! checkMesh > checkMesh.log 2>&1; then
    echo "⚠️  Mesh quality check failed. Check checkMesh.log"
    echo "Continuing with simulation..."
else
    echo "✓ Mesh quality OK"
fi

# Run simulation
echo "🚀 Running simulation..."
if ! simpleFoam > simpleFoam.log 2>&1; then
    echo "❌ Simulation failed. Check simpleFoam.log"
    exit 1
fi

# Check convergence
echo "📊 Checking convergence..."
FINAL_RESIDUALS=$(tail -20 simpleFoam.log | grep "smoothSolver\|GAMG" | tail -4)
echo "Final residuals:"
echo "$FINAL_RESIDUALS" | sed 's/^/  /'

# Create .foam file for ParaView
touch case.foam

echo ""
echo "✅ Simulation completed successfully!"
echo ""
echo "📈 Results summary:"
echo "=================="
if [ -f "constant/polyMesh/boundary" ]; then
    CELL_COUNT=$(grep -E "nCells" checkMesh.log | awk '{print $2}' || echo "N/A")
    echo "  Cells: $CELL_COUNT"
fi
ITERATIONS=$(grep "Time = " simpleFoam.log | tail -1 | awk '{print $3}' || echo "N/A")
echo "  Iterations: $ITERATIONS"
echo "  Runtime: $(grep "ExecutionTime" simpleFoam.log | tail -1 | awk '{print $3, $4}' || echo "N/A")"

echo ""
echo "📁 Output files:"
echo "  • case.foam (ParaView)"
echo "  • blockMesh.log"
echo "  • checkMesh.log" 
echo "  • simpleFoam.log"
echo ""
echo "🎯 Next steps:"
echo "  • View results: paraview case.foam"
echo "  • Check logs if needed"

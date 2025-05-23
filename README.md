# OpenFOAM Axisymmetric Piston-Cylinder CFD

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

Minimal working example for axisymmetric piston-cylinder CFD simulations in OpenFOAM using blockMesh with transient animation capabilities.

## Overview

This repository provides a complete, working example of creating axisymmetric piston-cylinder geometries in OpenFOAM using `blockMesh`. The case demonstrates proper wedge boundary conditions, mesh generation, steady-state and transient flow simulations, and automated animation creation.

## Features

- ✅ **Working axisymmetric geometry** - 5° wedge angle with proper boundary conditions
- ✅ **Automated setup** - One-script execution from mesh to results
- ✅ **Quality validated** - Mesh passes OpenFOAM quality checks
- ✅ **Transient simulation** - Time-varying flow with animation support
- ✅ **ParaView automation** - Batch animation generation
- ✅ **Minimal dependencies** - Uses standard OpenFOAM installation
- ✅ **Educational** - Well-commented code for learning

## Quick Start

### Steady-State Simulation

```bash
# Clone the repository
git clone https://github.com/your-username/openfoam-axisymmetric-piston-cfd.git
cd openfoam-axisymmetric-piston-cfd

# Run steady-state simulation
chmod +x run_mwe.sh
./run_mwe.sh

# View results in ParaView
paraview case.foam
```

### Transient Animation

```bash
# Run transient simulation for animation
chmod +x run_animation.sh
./run_animation.sh

# Generate animation (Windows with ParaView)
# From PowerShell in case directory:
& "C:\Program Files\ParaView 5.13.1\bin\pvbatch.exe" animation.py
```

## Geometry

The case models a simplified piston-cylinder system with:
- **Cylinder radius**: 10 mm
- **Piston radius**: 8 mm  
- **Cylinder length**: 50 mm
- **Piston position**: 20 mm from inlet
- **Piston length**: 10 mm
- **Wedge angle**: 5° (axisymmetric)

## Requirements

- **OpenFOAM** (tested with v1912, should work with v5+)
- **Linux/WSL environment** for simulation
- **ParaView** for visualization (Windows version supported via WSL path)
- **Git** for cloning repository

## File Structure

```
├── system/
│   ├── blockMeshDict      # Mesh definition with hardcoded coordinates
│   ├── controlDict        # Simulation control (steady/transient modes)
│   ├── fvSchemes          # Numerical schemes 
│   └── fvSolution         # Solver settings (SIMPLE/PISO)
├── constant/
│   ├── transportProperties # Fluid properties (air)
│   └── turbulenceProperties # Laminar model
├── 0/
│   ├── p                  # Pressure field with wedge boundaries
│   └── U                  # Velocity field with time-varying inlet
├── run_mwe.sh             # Steady-state simulation script
├── run_animation.sh       # Transient simulation script
├── animation.py           # ParaView batch animation script
└── README.md              # This file
```

## Usage

### Steady-State Flow

The `run_mwe.sh` script performs:
1. Sets up OpenFOAM environment variables
2. Cleans previous runs (preserving initial conditions)
3. Generates mesh with `blockMesh`
4. Checks mesh quality with `checkMesh`
5. Runs steady simulation with `simpleFoam`
6. Creates ParaView file for visualization

### Transient Animation

The `run_animation.sh` script performs:
1. Same setup as steady-state
2. Runs transient simulation with `icoFoam`
3. Creates time directories every 0.02s
4. Uses time-varying inlet velocity boundary condition

The `animation.py` script:
- Loads OpenFOAM data in ParaView
- Sets up velocity magnitude coloring
- Configures camera for axisymmetric view
- Exports MP4 animation (25 FPS)

## Simulation Parameters

### Steady-State
- **Solver**: `simpleFoam`
- **Turbulence**: Laminar
- **Inlet**: 1 m/s uniform velocity
- **Outlet**: Fixed pressure (0 Pa)
- **Iterations**: 100

### Transient Animation
- **Solver**: `icoFoam` (PISO algorithm)
- **Duration**: 1 second
- **Time step**: 0.001s (for stability)
- **Output**: Every 0.01s (100 FPS data)
- **Inlet**: Time-varying velocity (0 → 0.5 → 0 m/s)

## Customization

### Geometry Parameters
Key parameters in `system/blockMeshDict`:
- `cr`: Cylinder radius [mm]
- `pr`: Piston radius [mm]
- `cl`: Cylinder length [mm]
- `px`: Piston position [mm]
- `pl`: Piston length [mm]
- `ms`: Mesh resolution

### Boundary Conditions
Modify `0/U` and `0/p` for different flow conditions:
- Inlet velocity profiles
- Pressure boundary conditions
- Wall movement (for piston motion)

### Animation Settings
Adjust `animation.py` for different visualizations:
- Color schemes (`uLUT.ApplyPreset`)
- Camera angles
- Frame rate and duration
- Output format (MP4, AVI, PNG sequence)

## Troubleshooting

### Common Issues

**Mesh generation fails:**
- Check OpenFOAM environment variables
- Verify `WM_OPTIONS` is set correctly
- Ensure proper file permissions

**Simulation doesn't start:**
- Verify `0/p` and `0/U` files exist
- Check `fvSolution` has required solver sections
- For transient: ensure PISO section is present

**Animation shows no data:**
- Confirm time directories were created
- Check simulation completed successfully
- Verify ParaView can access WSL filesystem

**Numerical instability:**
- Reduce time step in `controlDict`
- Lower inlet velocities in `0/U`
- Check Courant number in simulation log

### Log Files
- `blockMesh.log` - Mesh generation details
- `checkMesh.log` - Mesh quality report
- `simpleFoam.log` or `icoFoam.log` - Simulation progress
- Check final residuals and Courant numbers

## WSL + Windows ParaView Setup

This setup assumes:
- OpenFOAM running in WSL (Ubuntu 22.04)
- ParaView installed on Windows
- Access via `\\wsl.localhost\Ubuntu-22.04\...` path

Example ParaView command from Windows PowerShell:
```powershell
& "C:\Program Files\ParaView 5.13.1\bin\paraview.exe" \\wsl.localhost\Ubuntu-22.04\home\user\openfoam_cases\case\case.foam
```

## Performance Notes

- **Mesh size**: 860 cells (suitable for demonstration)
- **Steady simulation**: ~30 seconds on typical hardware
- **Transient simulation**: ~1-2 minutes for 1000 time steps
- **Animation generation**: ~10-30 seconds depending on frames

## Citation

If you use this work in your research, please cite:

```bibtex
@phdthesis{farimani2025,
  author    = {Foad S. Farimani},
  title     = {Doctoral Dissertation},
  school    = {University of Twente},
  year      = {2025},
  address   = {Enschede, The Netherlands},
  isbn      = {978-90-365-6554-7},
  doi       = {10.3990/1.9789036565547},
  url       = {https://doi.org/10.3990/1.9789036565547}
}
```

## License

This work is licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests for:
- Additional boundary condition examples
- Improved mesh refinement strategies
- Alternative solver configurations
- Enhanced visualization scripts

## Acknowledgments

- Developed as part of doctoral research at the University of Twente
- Based on discussions from [CFD Online](https://www.cfd-online.com/Forums/openfoam-meshing/205599-creating-axisymmetric-piston-cylinder-blockmeshdict.html) and [Stack Overflow](https://stackoverflow.com/questions/51976558/axisymmetric-blockmeshdict-foam-fatal-error-wedge-centre-plane-does-not-al)
- Special thanks to the OpenFOAM community for troubleshooting assistance

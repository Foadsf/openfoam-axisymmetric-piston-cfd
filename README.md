# OpenFOAM Axisymmetric Piston-Cylinder CFD

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

Minimal working example for axisymmetric piston-cylinder CFD simulations in OpenFOAM using blockMesh.

## Overview

This repository provides a complete, working example of creating axisymmetric piston-cylinder geometries in OpenFOAM using `blockMesh`. The case demonstrates proper wedge boundary conditions, mesh generation, and steady-state incompressible flow simulation.

## Features

- ✅ **Working axisymmetric geometry** - 5° wedge angle with proper boundary conditions
- ✅ **Automated setup** - One-script execution from mesh to results
- ✅ **Quality validated** - Mesh passes OpenFOAM quality checks
- ✅ **Minimal dependencies** - Uses standard OpenFOAM installation
- ✅ **Educational** - Well-commented code for learning

## Quick Start

```bash
# Clone the repository
git clone https://github.com/Foadsf/openfoam-axisymmetric-piston-cfd.git
cd openfoam-axisymmetric-piston-cfd

# Run the complete simulation
chmod +x run_mwe.sh
./run_mwe.sh

# View results in ParaView
paraview case.foam
```

## Geometry

The case models a simplified piston-cylinder system with:
- Cylinder radius: 10 mm
- Piston radius: 8 mm  
- Cylinder length: 50 mm
- Piston position: 20 mm from inlet
- Piston length: 10 mm

## Requirements

- OpenFOAM (tested with v1912, should work with v5+)
- Linux/WSL environment
- ParaView (optional, for visualization)

## File Structure

```
├── system/
│   ├── blockMeshDict      # Mesh definition
│   ├── controlDict        # Simulation control
│   ├── fvSchemes          # Numerical schemes
│   └── fvSolution         # Solver settings
├── constant/
│   ├── transportProperties # Fluid properties
│   └── turbulenceProperties # Turbulence model
├── 0/
│   ├── p                  # Pressure field
│   └── U                  # Velocity field
└── run_mwe.sh             # Automated run script
```

## Usage

The `run_mwe.sh` script performs all steps automatically:
1. Sets up OpenFOAM environment
2. Cleans previous runs
3. Generates mesh with `blockMesh`
4. Checks mesh quality with `checkMesh`
5. Runs simulation with `simpleFoam`
6. Creates ParaView file

All detailed output is logged to separate files for debugging.

## Customization

Key parameters in `system/blockMeshDict`:
- `cr`: Cylinder radius
- `pr`: Piston radius
- `cl`: Cylinder length
- `px`: Piston position
- `pl`: Piston length
- `ms`: Mesh resolution

## Troubleshooting

If you encounter issues:
1. Check log files: `blockMesh.log`, `checkMesh.log`, `simpleFoam.log`
2. Verify OpenFOAM installation: `which blockMesh`
3. Ensure proper environment variables are set

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

Contributions are welcome! Please feel free to submit issues or pull requests.

## Acknowledgments

Developed as part of doctoral research at the University of Twente.

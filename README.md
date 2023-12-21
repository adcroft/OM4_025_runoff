# OM4_025_runoff

Invokes the regridding of river runoff for the OM4 0.25 degree configuration.

- Updated to work with JRAv1.5 since Adcroft et al., 2018

## Usage

You will need a python environment with numpy and numba, e.g.
```bash
conda create -q -y -n runoff python=3.11 numpy netcdf4 numba scipy
conda activate runoff
```

For JRA data, you will need the pad_JRA process to have complete. You can shortcut by symlinking the data here.

To run, type
```bash
make
```

To regrid the rovers used with the CORE forcing
```
make core
```

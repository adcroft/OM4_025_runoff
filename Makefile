TARGS = runoff.daitren.clim.1440x1080.v20180328.nc \
        runoff.daitren.iaf.1440x1080.v20180328.nc
DEPS = ocean_hgrid.nc ocean_mask.nc runoff.daitren.clim.v2011.02.10.nc runoff.daitren.iaf.20120419.nc

all: $(TARGS) hash.md5
	md5sum -c hash.md5

ocean_hgrid.nc ocean_mask.nc:
	wget -nv ftp://ftp.gfdl.noaa.gov/perm/Alistair.Adcroft/MOM6-testing/OM4_025/$@
	md5sum -c $@.md5
runoff.daitren.clim.v2011.02.10.nc:
	wget -nv ftp://data1.gfdl.noaa.gov/1/users/Niki.Zadeh/COREv2/data_IAF/CORRECTED/calendar_years/runoff.daitren.clim.10FEB2011.nc -O $@
	md5sum -c $@.md5
runoff.daitren.iaf.20120419.nc:
	wget -nv ftp://data1.gfdl.noaa.gov/1/users/Niki.Zadeh/COREv2/data_1948_2007/CORRECTED/calendar_years/runoff.daitren.iaf.20120419.nc
	md5sum -c $@.md5

runoff.daitren.clim.1440x1080.v20180328.nc: runoff.daitren.clim.v2011.02.10.nc ocean_hgrid.nc ocean_mask.nc
	./regrid_runoff/regrid_runoff.py --fast_pickle ocean_hgrid.nc ocean_mask.nc runoff.daitren.clim.v2011.02.10.nc --fms --fmst $@
runoff.daitren.iaf.1440x1080.v20180328.nc: runoff.daitren.iaf.20120419.nc ocean_hgrid.nc ocean_mask.nc
	./regrid_runoff/regrid_runoff.py --fast_pickle ocean_hgrid.nc ocean_mask.nc runoff.daitren.iaf.20120419.nc --fms -n 720 --fmst $@

hash.md5: | $(TARGS)
	md5sum $(TARGS) > $@

clean:
	rm -f $(TARGS) $(DEPS) pickle.*

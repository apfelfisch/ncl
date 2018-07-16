load "/usr/share/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/share/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/share/ncarg/nclscripts/csm/contributed.ncl"
load "/usr/share/ncarg/nclscripts/csm/shea_util.ncl"

load "/scratch/local1/tbruecher/git/ncl/libs/climba_plot.ncl"

begin
 

; constants
MyFillValue=-9e+33




opt=True
opt@fn="/scratch/local1/tbruecher/carbon_foci/FOCI1.7-SW060_jsbach_jsbach_mean_2000-2010.nc"


covers=get_coverfraction (opt)
plot_coverfraction_abs (covers, "pdf","foci_cover.pdf","2000-2010", "coverfraction in foci", "left", "global")

printVarSummary (covers)

end



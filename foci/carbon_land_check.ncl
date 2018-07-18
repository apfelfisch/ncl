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



data=True
data@fnbaresoil="/scratch/local1/tbruecher/carbon_foci/baresoilFrac_t63_tbounds_mean.nc"
data@fnforestfrac="/scratch/local1/tbruecher/carbon_foci/forest_frac_t63_tbounds_mean.nc"

forestfile=addfile(data@fnforestfrac,"r")
forestfrac=forestfile->treeFrac

baresoilfile=addfile(data@fnbaresoil,"r")
baresoilfrac=baresoilfile->baresoilFrac

;printVarSummary (barefrac)
;printVarSummary (forestfrac)

;printVarSummary (covers)


plot_coverfraction_abs (covers, "pdf","foci_cover_all.pdf","2000-2010", "coverfraction in foci", "left", "global")


covers(2,:,:)=baresoilfrac/100.
covers(3,:,:)=forestfrac/100.

covers(4,:,:)=covers(0,:,:)-covers(2,:,:)
covers(5,:,:)=covers(1,:,:)-covers(3,:,:)




plot_coverfraction_selection (covers, (/0,1,2,3,4,5/),(/"b","g","b","g","bd","gd"/),\
                              (/"foci baresoil frac","foci forest frac","data baresoil frac","data forest frac", "data baresoil diff", "data forest diff"/),\
                              "pdf","foci_cover_validation","2000-2010_vali", "coverfraction in foci", "left", "global")


end



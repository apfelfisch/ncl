load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"


load "/Volumes/work/m300107/scripts/plot/ncl/libs/climba.ncl"


begin
    ; cpools
    cpools=get_cpools ("/Volumes/wrkshr2/m300107/data/experiments/climba/climba_Tra8-0k/climba_Tra8-0k_veg_0000-0099.nc")
    plot_cpools_abs(cpools,"pdf","8K","Tra8-0k_cpools_8k","abs. cpools: ")
    cpools=get_cpools ("/Volumes/wrkshr2/m300107/data/experiments/climba/climba_Tra8-0k/climba_Tra8-0k_veg_7900-7999.nc")
    plot_cpools_abs(cpools,"pdf","0K","Tra8-0k_cpools_0k","abs. cpools: ")


    cpools=get_cpools_diff("/Volumes/wrkshr2/m300107/data/experiments/climba/climba_Tra8-0k/climba_Tra8-0k_veg_0000-0099.nc","/Volumes/wrkshr2/m300107/data/experiments/climba/climba_Tra8-0k/climba_Tra8-0k_veg_7900-7999.nc")
    plot_cpools_diff(cpools,"pdf","8K-0K","Tra8-0k_cpools_8k-0k","change in cpools: ")

    ;coverfraction
    covers=get_coverfraction("Volumes/wrkshr2/m300107/data/experiments/climba/climba_Tra8-0k/climba_Tra8-0k_jsbach_0000-0099.nc")
	plot_coverfraction_abs(covers,"pdf","8K","Tra8-0k_cover_8k","cover fraction:")
    covers=get_coverfraction("/Volumes/wrkshr2/m300107/data/experiments/climba/climba_Tra8-0k/climba_Tra8-0k_jsbach_7900-7999.nc")
    plot_coverfraction_abs(covers,"pdf","0K","Tra8-0k_cover_0k","cover fraction:")
	covers=get_coverfraction_diff("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_0001-0009_jsbach.nc","/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_7990-7999_jsbach.nc")
	plot_coverfraction_diff(covers,"pdf","8K-0K","Tra8-0k_cover_8k-0k","change in cover fraction: ")



		; 
		; pools=get_cpools ("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_7990-7999_veg.nc")
		; plot_cpools_abs(pools,"pdf","0K","test_pools","absolute values for cpools: ")
		;         
		;       covers=get_coverfraction("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_7990-7999_jsbach.nc")
		;       plot_coverfraction_abs(covers,"pdf","0K","test_cover_abs","cover fraction:")
		;        
		;     
		; fire=get_fire("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_7990-7999_veg.nc")
		; plot_fire_abs(fire,"pdf","0K","test_fire","burned area: ")
		; 
;		 cpools=get_cpools_diff("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_0001-0009_veg.nc","/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_7990-7999_veg.nc")
;		 plot_cpools_diff(cpools,"pdf","8K-0K","test_diff_pools","change in cpools: ")
;		 
;		covers=get_coverfraction_diff("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_0001-0009_jsbach.nc","/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_7990-7999_jsbach.nc")
;		printVarSummary(covers)
;		plot_coverfraction_diff(covers,"pdf","8K-0K","test_diff_cover","change in cover fraction: ")
		; 
		; 

;		prec=get_precipitation("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/climate.nc","kg/m**2s-mm/yr");
;		printVarSummary(prec)
		
;		plot_precipitation_abs (prec,"pdf","0K","test_precipitation","my panel title")

; tmin=get_tmin("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/climate.nc")
; printVarSummary(tmin)
; 
; covers=get_coverfraction("/Volumes/work/m300107/scripts/plot/ncl/climba/TS/input/climba_Tra8-0k_7990-7999_jsbach.nc")
; grass=covers(1,:,:)
; forest=covers(4,:,:)
; 
; climate (prec,tmin,grass,forest,"pdf","0K","test_climate","my panel title")
;     
    
end
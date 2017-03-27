load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

    wks_type = "pdf"
    wks                 = gsn_open_wks(wks_type ,"pdf/pages/pages_carbonpools_climba_abs_fullforcing_V2")
    
    
;    gsn_merge_colormaps(wks,"hotcolr_19lev","precip4_diff_19lev")
;    gsn_define_colormap(wks,"OceanLakeLandSnow")



	    gsn_merge_colormaps(wks,"brown","OceanLakeLandSnow")
	;   gsn_define_colormap(wks,"OceanLakeLandSnow")
	    gsn_draw_colormap(wks)
	
	
    gsn_draw_colormap(wks)
    gsnMaximize            = True
    resabs                 = True
    resdiff = True 

    resabs@cnFillOn        = True            ; color Fill 
    resabs@cnFillMode      = "CellFill"       ; Raster Mode
    resabs@cnLinesOn       = False             ; Turn off contour lines
    resabs@gsnFrame        = False 
    resabs@gsnDraw         = False
 
    resdiff@cnFillOn       = True               ; color Fill 
    resdiff@cnFillMode     = "CellFill"
    resdiff@cnLinesOn      = False             ; Turn off contour lines
    resdiff@gsnFrame       = False 
    resdiff@gsnDraw         = False
    
    resdiff@cnFillDrawOrder       = "PostDraw"
    resdiff@mpProjection="Mollweide"
    resdiff@mpLandFillColor = "Gray"
    resdiff@mpOceanFillColor = "skyblue2"

	  resdiff@mpPerimOn         = False             ; turn off box around plot
	  resdiff@mpGridLatSpacingF = 30.               ; spacing for lat lines
	  resdiff@mpGridLonSpacingF = 30.               ; spacing for lon lines
	  resdiff@mpFillOn          = True

	  resdiff@cnFillOn          = True              ; color plot desired
	  resdiff@cnLineLabelsOn    = False             ; turn off contour lines
	  resdiff@txFontHeightF     = 0.015 

	  resdiff@vpXF            = 0.1                 ; make plot bigger
	  resdiff@vpYF            = 0.9         
	  resdiff@vpWidthF        = 0.8
	  resdiff@vpHeightF       = 0.8




    resabs@cnFillDrawOrder       = "PostDraw"
    resabs@mpProjection="Mollweide"
    resabs@mpLandFillColor = "Gray"
    resabs@mpOceanFillColor = "skyblue2"

	resabs@mpPerimOn         = False             ; turn off box around plot
	  resabs@mpGridLatSpacingF = 30.               ; spacing for lat lines
	  resabs@mpGridLonSpacingF = 30.               ; spacing for lon lines
	  resabs@mpFillOn          = True

	  resabs@cnFillOn          = True              ; color plot desired
	  resabs@cnLineLabelsOn    = False             ; turn off contour lines
	  resabs@txFontHeightF     = 0.015 

	  resabs@vpXF            = 0.1                 ; make plot bigger
	  resabs@vpYF            = 0.9         
	  resabs@vpWidthF        = 0.8
	  resabs@vpHeightF       = 0.8

    resabs@tmXBOn=False
    resabs@tmXTOn=False
    resabs@tmYROn=False
    resabs@tmYLOn=False

		resabs@lbAutoManage = False
    resabs@lbLabelFontHeightF = 0.015

    resdiff@tmXBOn=False
    resdiff@tmXTOn=False
    resdiff@tmYROn=False
    resdiff@tmYLOn=False

    plot=new(40,graphic)
    
    resdiff@cnLevelSelectionMode      = "ExplicitLevels" 
    resabs@cnLevelSelectionMode       = "ExplicitLevels" 

    resdiff@mpLandFillColor = -1
    resabs@mpLandFillColor = -1

    resabs@cnLevels = (/0.05,0.10,0.50,1,5.,10,20,30,40,50/)
    resdiff@cnLevels= (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)

    resabs@cnFillColors = (/2,3,4,5,6,7,8,9,10,11,12/)

    ;resdiff@cnFillColors=(/13,12,11,10,9,8,-1, 7,6,5,4,3,2/)
    resabs@pmLabelBarWidthF = 0.8
    resdiff@pmLabelBarWidthF = 0.8

    resdiff@lbLabelAngleF=-90
resabs@gsnRightString= "[kg/m2]"


;##0K 
    filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
    data2d=addfile(filename2d, "r")
    total0K2d=data2d->box_Cpools_total(0,:,:)
;    soil0K2d=data2d->box_Cpools_soil(0,:,:)
;    green0K2d=data2d->box_Cpools_green(0,:,:)
    
    
    filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Csums.nc"
    data1d=addfile(filename1d, "r")
    total0K1d=data1d->box_Cpools_total(0,0,0)
;    soil0K1d=data1d->box_Cpools_soil(0,0,0)
;    green0K1d=data1d->box_Cpools_green(0,0,0)



    resabs@gsnRightString= "[kg/m2]"
    resabs@gsnLeftString = "cpools total, 0K; "+total0K1d+" Gt C"
    plot(1) = gsn_csm_contour_map(wks,total0K2d,resabs)

;    resabs@gsnLeftString = "cpools soil, 0K; "+soil0K1d+" Gt C"
;    plot(1) = gsn_csm_contour_map_ce(wks,soil0K2d,resabs)
;    resabs@gsnLeftString = "cpools green, 0K; "+green0K1d+" Gt C"
;    plot(2) = gsn_csm_contour_map_ce(wks,green0K2d,resabs)

; 
; ;## 8K
    filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0023_9450-01-01_veg_tm_Cfields_2d.nc"
    data2d=addfile(filename2d, "r")
    total8K2d=data2d->box_Cpools_total(0,:,:)
 ;   soil8K2d=data2d->box_Cpools_soil(0,:,:)
 ;   green8K2d=data2d->box_Cpools_green(0,:,:)
    
    
    filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0023_9450-01-01_veg_tm_Csums.nc"
    data1d=addfile(filename1d, "r")
    total8K1d=data1d->box_Cpools_total(0,0,0)
    soil8K1d=data1d->box_Cpools_soil(0,0,0)
    green8K1d=data1d->box_Cpools_green(0,0,0)



    resabs@gsnRightString= "[kg/m2]"
    resabs@gsnLeftString = "cpools total, 8K; "+total8K1d+" Gt C"
    plot(2) = gsn_csm_contour_map(wks,total8K2d,resabs)
;    resabs@gsnLeftString = "cpools soil, 8K; "+soil8K1d+" Gt C"
;    plot(4) = gsn_csm_contour_map_ce(wks,soil8K2d,resabs)
;    resabs@gsnLeftString = "cpools green, 8K; "+green8K1d+" Gt C"
;    plot(5) = gsn_csm_contour_map_ce(wks,green8K2d,resabs)



; 
;## 126K
    filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0024_8500-01-01_veg_tm_Cfields_2d.nc"
    data2d=addfile(filename2d, "r")
    total126K2d=data2d->box_Cpools_total(0,:,:)
 ;   soil8K2d=data2d->box_Cpools_soil(0,:,:)
 ;   green8K2d=data2d->box_Cpools_green(0,:,:)
    
    
    filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0024_8500-01-01_veg_tm_Csums.nc"
    data1d=addfile(filename1d, "r")
    total126K1d=data1d->box_Cpools_total(0,0,0)
    ;soil126K1d=data1d->box_Cpools_soil(0,0,0)
    ;green126K1d=data1d->box_Cpools_green(0,0,0)



    resabs@gsnRightString= "[kg/m2]"
    resabs@gsnLeftString = "cpools total, 126K; "+total126K1d+" Gt C"
    plot(3) = gsn_csm_contour_map(wks,total126K2d,resabs)
;    resabs@gsnLeftString = "cpools soil, 8K; "+soil8K1d+" Gt C"
;    plot(4) = gsn_csm_contour_map_ce(wks,soil8K2d,resabs)
;    resabs@gsnLeftString = "cpools green, 8K; "+green8K1d+" Gt C"
;    plot(5) = gsn_csm_contour_map_ce(wks,green8K2d,resabs)


; ;##### plotting panels

    resP                 = True
    resP@gsnMaximize     = True
    resP@gsnPanelRowSpec = True
    resP@gsnPanelCenter  = True
    resP@gsnPanelFigureStrings = (/"g)","h)","i)"/)
    ;resP@gsnPanelScalePlotIndex = 3

    resP@txString        = "0K 8K 126K [kg/m2]"
    print("test")
    gsn_panel(wks,plot(1:3),(/1,1,1/),resP)


;    resP@txString        = "8K [kg/m2]"
;    gsn_panel(wks,plot(1:3),(/1,1,1/),resP)


;    resP@txString        = "anomalies 8K and 126K [kg/m2]"
;    gsn_panel(wks,plot(4:5),(/1,1/),resP)


    ;frame (wks)


end


load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

    wks_type = "pdf"
    wks                 = gsn_open_wks(wks_type ,"pdf/pages/coverfraction_climba_pages_desert_abs_V2")
    
    
    gsn_define_colormap(wks,"OceanLakeLandSnow")
	

    ;gsn_draw_colormap(wks)
    gsnPaperOrientation="landscape"
    
    gsnMaximize = True
    resabsdes   = True
    resabscover = True
    
    resdiffdes   = True 
    resdiffcover = True
 

    ;resabsdes@gsnRightString= "[]"
    resabsdes@cnFillOn        = True            ; color Fill 
    resabsdes@cnFillMode      = "CellFill"      ; Raster Mode
    resabsdes@cnLinesOn       =  False          ; Turn off contour lines
    resabsdes@gsnFrame        = False 
    resabsdes@gsnDraw         = False
    resabsdes@cnFillDrawOrder       = "PostDraw"
    resabsdes@mpProjection="Mollweide"
 
    resabsdes@cnLevelSelectionMode       = "ExplicitLevels" 
    resabsdes@mpLandFillColor = "Gray"
    resabsdes@mpOceanFillColor = "skyblue2"

    resabsdes@pmLabelBarWidthF = 0.8


	resabsdes@mpPerimOn         = False             ; turn off box around plot
	  resabsdes@mpGridLatSpacingF = 30.               ; spacing for lat lines
	  resabsdes@mpGridLonSpacingF = 30.               ; spacing for lon lines
	  resabsdes@mpFillOn          = True

	  resabsdes@cnFillOn          = True              ; color plot desired
	  resabsdes@cnLineLabelsOn    = False             ; turn off contour lines
	  resabsdes@txFontHeightF     = 0.015 

	  resabsdes@vpXF            = 0.1                 ; make plot bigger
	  resabsdes@vpYF            = 0.9         
	  resabsdes@vpWidthF        = 0.8
	  resabsdes@vpHeightF       = 0.8
	
	
	resabsdes@lbAutoManage = False
    resabsdes@lbLabelFontHeightF = 0.015



    resabscover=resabsdes
    resdiffdes=resabsdes
    resdiffcover=resabsdes
    



    plot=new(40,graphic)
    
    resabsdes@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5/) ; 13 level

    
    resabsdes@cnFillColors = (/90,100,110,120,130,140,150,160,170,180,190,200,210,220/) ; 14 colors
;    resdiffcover@cnFillColors= (/207,191,175,159,143,127,-1,79,63,47,31,15,4/)



;     -1 :       Date  Time    Name         Level    Size    Miss :     Minimum        Mean     Maximum
;      1 : 0001-01-31 00:00:00 cover_type       1    4608       0 :      0.0000     0.56228      2.0000
;      2 : 0001-01-31 00:00:00 cover_type       2    4608       0 :      0.0000      1.0059      3.0000
;      3 : 0001-01-31 00:00:00 cover_type       3    4608       0 :      0.0000      1.3411      4.0000
;      4 : 0001-01-31 00:00:00 cover_type       4    4608       0 :      0.0000      1.6764      5.0000
;      5 : 0001-01-31 00:00:00 cover_type       5    4608       0 :      0.0000      3.3529      10.000
;      6 : 0001-01-31 00:00:00 cover_type       6    4608       0 :      0.0000      3.6882      11.000
;      7 : 0001-01-31 00:00:00 cover_type       7    4608       0 :      0.0000      4.0234      12.000
;      8 : 0001-01-31 00:00:00 cover_type       8    4608       0 :      0.0000      4.3587      13.000
;      9 : 0001-01-31 00:00:00 cover_type       9    4608       0 :      0.0000      5.0293      15.000
;     10 : 0001-01-31 00:00:00 cover_type      10    4608       0 :      0.0000      5.3646      16.000
;     11 : 0001-01-31 00:00:00 cover_type      11    4608       0 :      0.0000      6.7361      21.000
; 
; #  1: Glacier                     
; #  2: Tropical evergreen trees                     
; #  3: Tropical deciduous trees                     
; #  4: Extra-tropical evergreen trees                     
; #  5: Extra-tropical deciduous trees                     
; #  6: Temperate broadleaf evergreen trees                     
; #  7: Temperate broadleaf deciduous trees                     
; #  8: Coniferous evergreen trees                     
; #  9: Coniferous deciduous trees                     
; # 10: Raingreen shrubs                     
; # 11: Deciduous shrubs                     
; # 12: C3 grass                     
; # 13: C4 grass                     
; # 14: Pasture                     
; # 15: C3 pasture                     
; # 16: C4 pasture                     
; # 17: Tundra                     
; # 18: Swamp                     
; # 19: Crops                     
; # 20: C3 crop                     
; # 21: C4 crop
; 
; #Trees
; 1->2   Tropical evergreen trees
; 2->3   Tropical deciduous trees
; 3->4   Extra-tropical evergreen trees
; 4->5   Extra-tropical deciduous trees
; #Shrubs
; 5->10  Raingreen shrubs
; 6->11  Deciduous shrubs
; #grass
; 7->12  C3 grass
; 8->13  C4 Grass
; #pasture
; 9->15  C3 pasture
; 10->16 C4 Pasture
; 11->21 C4 CROP




;##0K 
    filename="/Volumes/work/m300107/experiments/jsbach_climber_0017_3500-01-01_jsbach.nc"
    data=addfile(filename, "r")

    cover_fract=data->cover_fract(0,:,:,:)
    veg_ratio_max=data->veg_ratio_max(0,:,:)
    veg_fract_correction=data->veg_fract_correction(0,:,:,:)

    des0K=1.-veg_ratio_max
    copy_VarMeta(veg_ratio_max,des0K)
    tree0K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(0:3,:,:),0)
    copy_VarMeta(veg_ratio_max,tree0K)
    ;shrubs0K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(4:5,:,:),0)
    ;copy_VarMeta(veg_ratio_max,shrubs0K)
    ;grass0K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
    ;copy_VarMeta(veg_ratio_max,grass0K)


    resabsdes@gsnLeftString = "0K desert fraction []"
    plot(1) = gsn_csm_contour_map(wks,des0K,resabsdes)
    ;resabscover@gsnLeftString = "0K forest fraction []"
    ;plot(1) = gsn_csm_contour_map(wks,tree0K,resabscover)
    ;resabscover@gsnLeftString = "shrubs fraction []"
    ;plot(2) = gsn_csm_contour_map_ce(wks,shrubs0K,resabscover)
    ;resabscover@gsnLeftString = "grass fraction []"
    ;plot(3) = gsn_csm_contour_map_ce(wks,grass0K,resabscover)


;just C3,C4,C3C4
      ;grass0KC3=veg_ratio_max*cover_fract(6,:,:)
      ;copy_VarMeta(veg_ratio_max,grass0KC3)
      ;grass0KC4=veg_ratio_max*cover_fract(7,:,:)
      ;copy_VarMeta(veg_ratio_max,grass0KC4)
      ;grass0KC3C4=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
      ;copy_VarMeta(veg_ratio_max,grass0KC3C4)


      ;resabscover@gsnLeftString = "0K grass fraction C3 []"
      ;plot(12) = gsn_csm_contour_map_ce(wks,grass0KC3,resabscover)
      ;resabscover@gsnLeftString = "0K grass fraction C4 []"
      ;plot(13) = gsn_csm_contour_map_ce(wks,grass0KC4,resabscover)
      ;resabscover@gsnLeftString = "0K grass fraction C3C4 []"
      ;plot(14) = gsn_csm_contour_map_ce(wks,grass0KC3C4,resabscover)



;##8K 
    filename="/Volumes/work/m300107/experiments/jsbach_climber_0023_9450-01-01_jsbach.nc"
    data=addfile(filename, "r")

    cover_fract=data->cover_fract(0,:,:,:)
    veg_ratio_max=data->veg_ratio_max(0,:,:)
    veg_fract_correction=data->veg_fract_correction(0,:,:,:)

    des8K=1.-veg_ratio_max
    copy_VarMeta(veg_ratio_max,des8K)
    tree8K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(0:3,:,:),0)
    copy_VarMeta(veg_ratio_max,tree8K)
    ;shrubs8K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(4:5,:,:),0)
    ;copy_VarMeta(veg_ratio_max,shrubs8K)
    ;grass8K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
    ;copy_VarMeta(veg_ratio_max,grass8K)

    resabsdes@gsnLeftString = "8K desert fraction []"
    plot(2) = gsn_csm_contour_map(wks,des8K,resabsdes)
    ;resabscover@gsnLeftString = "8K forest fraction []"
    ;plot(2) = gsn_csm_contour_map(wks,tree8K,resabscover)
    ;resabscover@gsnLeftString = "shrubs fraction []"
    ;plot(6) = gsn_csm_contour_map_ce(wks,shrubs8K,resabscover)
    ;resabscover@gsnLeftString = "grass fraction []"
    ;plot(7) = gsn_csm_contour_map_ce(wks,grass8K,resabscover)


;just C3,C4,C3C4
    ; grass8KC3=veg_ratio_max*cover_fract(6,:,:)
    ;     copy_VarMeta(veg_ratio_max,grass8KC3)
    ;     grass8KC4=veg_ratio_max*cover_fract(7,:,:)
    ;     copy_VarMeta(veg_ratio_max,grass8KC4)
    ;     grass8KC3C4=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
    ;     copy_VarMeta(veg_ratio_max,grass8KC3C4)
    ; 
    
    ; resabscover@gsnLeftString = "8K grass fraction C3 []"
    ;     plot(12) = gsn_csm_contour_map_ce(wks,grass8KC3,resabscover)
    ;     resabscover@gsnLeftString = "8K grass fraction C4 []"
    ;     plot(13) = gsn_csm_contour_map_ce(wks,grass8KC4,resabscover)
    ;     resabscover@gsnLeftString = "8K grass fraction C3C4 []"
    ;     plot(14) = gsn_csm_contour_map_ce(wks,grass8KC3C4,resabscover)
    ; 
    

;##8K-0K 
;     filename="/Volumes/work/m300107/experiments/jsbach_climber_0022_9950-01-01_jsbach_tm_ano.nc"
;     data=addfile(filename, "r")
; 
;     cover_fract=data->cover_fract(0,:,:,:)
;     veg_ratio_max=data->veg_ratio_max(0,:,:)
;     veg_fract_correction=data->veg_fract_correction(0,:,:,:)
; 
;     des8K0K=des8K-des0K
;     copy_VarMeta(veg_ratio_max,des8K0K)
;     tree8K0K=tree8K-tree0K
;     copy_VarMeta(veg_ratio_max,tree8K0K)
;     ; shrubs8K0K=shrubs8K-shrubs0K 
;     ;     copy_VarMeta(veg_ratio_max,shrubs8K0K)
;     ;     grass8K0K=grass8K-grass0K 
;     ;     copy_VarMeta(veg_ratio_max,grass8K0K)
;     
;     resdiffdes@gsnLeftString = "abs. change in desert fraction 8K-0K"
;     plot(8) = gsn_csm_contour_map_ce(wks,des8K0K,resdiffdes)
;     resdiffcover@gsnLeftString = "abs. change in tree fraction 8K-0K"
;     plot(9) = gsn_csm_contour_map_ce(wks,tree8K0K,resdiffcover)
;     ; resdiffcover@gsnLeftString = "abs. change in shrubs fraction 8K-0K"
;     ;     plot(10) = gsn_csm_contour_map_ce(wks,shrubs8K0K,resdiffcover)
;     ;     resdiffcover@gsnLeftString = "abs. change in grass fraction 8K-0K"
;     ;     plot(11) = gsn_csm_contour_map_ce(wks,grass8K0K,resdiffcover)
;     
; ;just C3,C4,C3C4
;     ; grass8K0KC3=veg_ratio_max*cover_fract(6,:,:)
;     ;     copy_VarMeta(veg_ratio_max,grass8K0KC3)
;     ;     grass8K0KC4=veg_ratio_max*cover_fract(7,:,:)
;     ;     copy_VarMeta(veg_ratio_max,grass8K0KC4)
;     ;     grass8K0KC3C4=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
;     ;     copy_VarMeta(veg_ratio_max,grass8K0KC3C4)
;     
; 
;     ; resabscover@gsnLeftString = "8K-0K grass fraction C3 []"
;     ;     plot(15) = gsn_csm_contour_map_ce(wks,grass8K0KC3,resdiffcover)
;     ;     resabscover@gsnLeftString = "8K-0K grass fraction C4 []"
;     ;     plot(16) = gsn_csm_contour_map_ce(wks,grass8K0KC4,resdiffcover)
;     ;     resabscover@gsnLeftString = "8K-0K grass fraction C3C4 []"
;     ;     plot(17) = gsn_csm_contour_map_ce(wks,grass8K0KC3C4,resdiffcover)
    
       
	;##126K
	    filename="/Volumes/work/m300107/experiments/jsbach_climber_0024_8500-01-01_jsbach.nc"
	    data=addfile(filename, "r")

	    cover_fract=data->cover_fract(0,:,:,:)
	    veg_ratio_max=data->veg_ratio_max(0,:,:)
	    veg_fract_correction=data->veg_fract_correction(0,:,:,:)

	    des126K=1.-veg_ratio_max
	    copy_VarMeta(veg_ratio_max,des126K)
	    tree126K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(0:3,:,:),0)
	    copy_VarMeta(veg_ratio_max,tree126K)
	    ; shrubs8K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(4:5,:,:),0)
	    ; 	    copy_VarMeta(veg_ratio_max,shrubs8K)
	    ; 	    grass8K=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
	    ; 	    copy_VarMeta(veg_ratio_max,grass8K)
	    
	    resabsdes@gsnLeftString = "126K desert fraction []"
	    plot(3) = gsn_csm_contour_map(wks,des126K,resabsdes)
	    ;resabscover@gsnLeftString = "126K forest fraction []"
	    ;plot(3) = gsn_csm_contour_map(wks,tree126K,resabscover)
	    ; resabscover@gsnLeftString = "shrubs fraction []"
	    ; 	    plot(6) = gsn_csm_contour_map_ce(wks,shrubs8K,resabscover)
	    ; 	    resabscover@gsnLeftString = "grass fraction []"
	    ; 	    plot(7) = gsn_csm_contour_map_ce(wks,grass8K,resabscover)
	    

	;just C3,C4,C3C4
	    ; grass8KC3=veg_ratio_max*cover_fract(6,:,:)
	    ; 	    copy_VarMeta(veg_ratio_max,grass8KC3)
	    ; 	    grass8KC4=veg_ratio_max*cover_fract(7,:,:)
	    ; 	    copy_VarMeta(veg_ratio_max,grass8KC4)
	    ; 	    grass8KC3C4=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
	    ; 	    copy_VarMeta(veg_ratio_max,grass8KC3C4)
	    

	    ; resabscover@gsnLeftString = "8K grass fraction C3 []"
	    ; 	    plot(12) = gsn_csm_contour_map_ce(wks,grass8KC3,resabscover)
	    ; 	    resabscover@gsnLeftString = "8K grass fraction C4 []"
	    ; 	    plot(13) = gsn_csm_contour_map_ce(wks,grass8KC4,resabscover)
	    ; 	    resabscover@gsnLeftString = "8K grass fraction C3C4 []"
	    ; 	    plot(14) = gsn_csm_contour_map_ce(wks,grass8KC3C4,resabscover)
	    


	;##126K-0K 
	;     filename="/Volumes/work/m300107/experiments/jsbach_climber_0024_7950-01-01_jsbach_tm_ano.nc"
	;     data=addfile(filename, "r")
	; 
	;     cover_fract=data->cover_fract(0,:,:,:)
	;     veg_ratio_max=data->veg_ratio_max(0,:,:)
	;     veg_fract_correction=data->veg_fract_correction(0,:,:,:)
	; 
	;     des126K0K=des126K-des0K
	;     copy_VarMeta(veg_ratio_max,des126K0K)
	;     tree126K0K=tree126K-tree0K
	;     copy_VarMeta(veg_ratio_max,tree126K0K)
	;     ; shrubs8K0K=shrubs8K-shrubs0K 
	;     ; 	    copy_VarMeta(veg_ratio_max,shrubs8K0K)
	;     ; 	    grass8K0K=grass8K-grass0K 
	;     ; 	    copy_VarMeta(veg_ratio_max,grass8K0K)
	;     
	;     resdiffdes@gsnLeftString = "abs. change in desert fraction 126K-0K"
	;     plot(8) = gsn_csm_contour_map_ce(wks,des126K0K,resdiffdes)
	;     resdiffcover@gsnLeftString = "abs. change in tree fraction 126K-0K"
	;     plot(9) = gsn_csm_contour_map_ce(wks,tree126K0K,resdiffcover)
	;     ; resdiffcover@gsnLeftString = "abs. change in shrubs fraction 8K-0K"
	;     ; 	    plot(10) = gsn_csm_contour_map_ce(wks,shrubs8K0K,resdiffcover)
	;     ; 	    resdiffcover@gsnLeftString = "abs. change in grass fraction 8K-0K"
	;     ; 	    plot(11) = gsn_csm_contour_map_ce(wks,grass8K0K,resdiffcover)
	;     
	; ;just C3,C4,C3C4
	;     ; grass8K0KC3=veg_ratio_max*cover_fract(6,:,:)
	;     ; 	    copy_VarMeta(veg_ratio_max,grass8K0KC3)
	;     ; 	    grass8K0KC4=veg_ratio_max*cover_fract(7,:,:)
	;     ; 	    copy_VarMeta(veg_ratio_max,grass8K0KC4)
	;     ; 	    grass8K0KC3C4=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
	;     ; 	    copy_VarMeta(veg_ratio_max,grass8K0KC3C4)
	;     ; 
	;     ; 
	;     ; 	    resabscover@gsnLeftString = "8K-0K grass fraction C3 []"
	;     ; 	    plot(15) = gsn_csm_contour_map_ce(wks,grass8K0KC3,resdiffcover)
	;     ; 	    resabscover@gsnLeftString = "8K-0K grass fraction C4 []"
	;     ; 	    plot(16) = gsn_csm_contour_map_ce(wks,grass8K0KC4,resdiffcover)
	;     ; 	    resabscover@gsnLeftString = "8K-0K grass fraction C3C4 []"
	;     ; 	    plot(17) = gsn_csm_contour_map_ce(wks,grass8K0KC3C4,resdiffcover)
	;     ; 	
	
	;##### plotting panels



    resP                 = True
    resP@gsnMaximize     = True
    resP@gsnPanelRowSpec = True
    resP@gsnPanelCenter  = True
    resP@gsnPanelFigureStrings = (/"d)","e)","f)"/)
    ;resP@gsnPanelScalePlotIndex = 3

    resP@txString        = "desert fraction"
    gsn_panel(wks,plot(1:3),(/1,1,1/),resP)
    ;resP@txString        = "cover fraction 8K"
    ;gsn_panel(wks,plot(4:7),(/2,2/),resP)


    ;resP@txString        = "absolut changes 8K-0K"
    ;gsn_panel(wks,plot(8:11),(/2,2/),resP)


;;C3C4 C3 C4
;   resP@txString        = "C3 and C4 and C3+C4 0K 8K"
;   gsn_panel(wks,plot(12:17),(/2,2,2/),resP)

    ;frame (wks)


end


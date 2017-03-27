load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

    wks_type = "png"
    wks                 = gsn_open_wks(wks_type ,"pdf/tra8-0k_carbonpools_climba_abs")
    
    gsn_define_colormap(wks,"brown")
;    gsn_merge_colormaps(wks,"brown","OceanLakeLandSnow")
;    gsn_draw_colormap(wks)
	
    gsnMaximize            = True
    resabs                 = True
    resdiff = True 

    resabs@cnFillOn        = True            ; color Fill 
    resabs@cnFillMode      = "CellFill"       ; Raster Mode
    resabs@cnLinesOn       = False             ; Turn off contour lines
    resabs@gsnFrame        = True
    resabs@gsnDraw         = True
 
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

    plot=new(80,graphic)
    
    resdiff@cnLevelSelectionMode      = "ExplicitLevels" 
    resabs@cnLevelSelectionMode       = "ExplicitLevels" 

    resdiff@mpLandFillColor = -1
    resabs@mpLandFillColor = -1


    
    resdiff@cnLevels= (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)

    resabs@cnFillColors = (/2,3,4,5,6,7,8,9,10,11,12/)

    ;resdiff@cnFillColors=(/13,12,11,10,9,8,-1, 7,6,5,4,3,2/)
    resabs@pmLabelBarWidthF = 0.8
    resdiff@pmLabelBarWidthF = 0.8

    resdiff@lbLabelAngleF=-90
    resabs@gsnRightString= "[kg/m2]"



    resabstotal=resabs
    resabstotal@cnLevels = (/0.05,0.10,0.50,1,5.,10,20,30,40,50/)
    
    resabssoil=resabs
    resabssoil@cnLevels = (/0.05,0.10,0.50,1,5.,10,20,30,40,50/)
    
    
    resabsgreen=resabs
    resabsgreen@cnLevels = (/0.05,0.10,0.50,1,5.,10,20,30,40,50/)

    


    path="~/Desktop/climba/cpools/"


; files for absolute values
; all cent
        filename2d_all=path+"climba_Tra8-0k_carbon_00-59_Cfields_2d_tm.nc"
        filename1d_all=path+"climba_Tra8-0k_carbon_00-59_Csums_tm.nc"

        data_all_2d=addfile(filename2d_all, "r")
        data_all_1d=addfile(filename1d_all, "r")
     
        total_all_2d=data_all_2d->box_Cpools_total(:,:,:)
        soil_all_2d=data_all_2d->box_Cpools_soil(:,:,:)
        green_all_2d=data_all_2d->box_Cpools_green(:,:,:)
        total_all_1d=data_all_1d->box_Cpools_total(:,0,0)
        soil_all_1d=data_all_1d->box_Cpools_soil(:,0,0)
        green_all_1d=data_all_1d->box_Cpools_green(:,0,0)

; 8K cent
      filename2d_8k=path+"climba_Tra8-0k_carbon_00_Cfields_2d_tm.nc"
      filename1d_8k=path+"climba_Tra8-0k_carbon_00_Csums_tm.nc"

      data_8k_2d=addfile(filename2d_8k, "r")
      data_8k_1d=addfile(filename1d_8k, "r")

      total_8k_2d=data_8k_2d->box_Cpools_total(0,:,:)
      soil_8k_2d=data_8k_2d->box_Cpools_soil(0,:,:)
      green_8k_2d=data_8k_2d->box_Cpools_green(0,:,:)
      total_8k_1d=data_8k_1d->box_Cpools_total(0,0,0)
      soil_8k_1d=data_8k_1d->box_Cpools_soil(0,0,0)
      green_8k_1d=data_8k_1d->box_Cpools_green(0,0,0)

;5K 
       filename2d_5k=path+"climba_Tra8-0k_carbon_30-39_Cfields_2d_tm.nc"
       filename1d_5k=path+"climba_Tra8-0k_carbon_30-39_Csums_tm.nc"

       data_5k_2d=addfile(filename2d_5k, "r")
       data_5k_1d=addfile(filename1d_5k, "r")

       total_5k_2d=data_5k_2d->box_Cpools_total(0,:,:)
       soil_5k_2d=data_5k_2d->box_Cpools_soil(0,:,:)
       green_5k_2d=data_5k_2d->box_Cpools_green(0,:,:)
       total_5k_1d=data_5k_1d->box_Cpools_total(0,0,0)
       soil_5k_1d=data_5k_1d->box_Cpools_soil(0,0,0)
       green_5k_1d=data_5k_1d->box_Cpools_green(0,0,0)


 ;2K 
        filename2d_2k=path+"climba_Tra8-0k_carbon_59_Cfields_2d_tm.nc"
        filename1d_2k=path+"climba_Tra8-0k_carbon_59_Csums_tm.nc"

        data_2k_2d=addfile(filename2d_2k, "r")
        data_2k_1d=addfile(filename1d_2k, "r")

        total_2k_2d=data_2k_2d->box_Cpools_total(0,:,:)
        soil_2k_2d=data_2k_2d->box_Cpools_soil(0,:,:)
        green_2k_2d=data_2k_2d->box_Cpools_green(0,:,:)
        total_2k_1d=data_2k_1d->box_Cpools_total(0,0,0)
        soil_2k_1d=data_2k_1d->box_Cpools_soil(0,0,0)
        green_2k_1d=data_2k_1d->box_Cpools_green(0,0,0)


; files for anomlies to 8k
; files for anomlies to 3k


      printVarSummary(total_all_1d)
      total_all_2d@_FillValue = -9.e+33
      total_8k_2d@_FillValue = -9.e+33
      total_5k_2d@_FillValue = -9.e+33
      total_2k_2d@_FillValue = -9.e+33

      
      green_all_2d@_FillValue = -9.e+33
      green_8k_2d@_FillValue = -9.e+33
      green_5k_2d@_FillValue = -9.e+33
      green_2k_2d@_FillValue = -9.e+33
   
      soil_all_2d@_FillValue = -9.e+33
      soil_8k_2d@_FillValue = -9.e+33
      soil_5k_2d@_FillValue = -9.e+33
      soil_2k_2d@_FillValue = -9.e+33
      
      
      
      
      
; plot time series
     ; do icent=0,59
     ;    print("plotting "+icent)
     ;    resabs@gsnRightString= "[kg/m2]"
     ;    year=-8000+icent*100
     ;    resabs@gsnLeftString = "cpools total: "+year+"    "+total_all_1d(icent)+" Gt C"
     ;    plot(icent) = gsn_csm_contour_map(wks,total_all_2d(icent,:,:),resabstotal)
     ; 
     ;  end do
     ;  

 
 ; TOTAL
      icent=60
      print("plotting 8k")
      resabstotal@gsnRightString= "[kg/m2]"
      year=-8000
      resabstotal@gsnLeftString = "cpools total: "+year+"    "+total_8k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,total_8k_2d(:,:),resabstotal)
      
      
      icent=icent+1
      print("plotting 5k")
      resabstotal@gsnRightString= "[kg/m2]"
      year=-5000
      resabstotal@gsnLeftString = "cpools total: "+year+"    "+total_5k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,total_5k_2d(:,:),resabstotal)
      

      icent=icent+1
      print("plotting 2k")
      resabstotal@gsnRightString= "[kg/m2]"
      year=-2000
      resabstotal@gsnLeftString = "cpools total: "+year+"    "+total_2k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,total_2k_2d(:,:),resabstotal)




; GREEN
icent=icent+1
      print("plotting 8k")
      resabsgreen@gsnRightString= "[kg/m2]"
      year=-8000
      resabsgreen@gsnLeftString = "green total: "+year+"    "+green_8k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,green_8k_2d(:,:),resabsgreen)
      
      
      icent=icent+1
      print("plotting 5k")
      resabsgreen@gsnRightString= "[kg/m2]"
      year=-5000
      resabsgreen@gsnLeftString = "green total: "+year+"    "+green_5k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,green_5k_2d(:,:),resabsgreen)
      
      icent=icent+1
      print("plotting 2k")
      resabsgreen@gsnRightString= "[kg/m2]"
      year=-2000
      resabsgreen@gsnLeftString = "green total: "+year+"    "+green_2k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,green_2k_2d(:,:),resabsgreen)
      
; SOIL      
      icent=icent+1
      print("plotting 8k")
      resabssoil@gsnRightString= "[kg/m2]"
      year=-8000
      resabssoil@gsnLeftString = "soil total: "+year+"    "+soil_8k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,soil_8k_2d(:,:),resabssoil)
      
      
      icent=icent+1
      print("plotting 5k")
      resabssoil@gsnRightString= "[kg/m2]"
      year=-5000
      resabssoil@gsnLeftString = "soil total: "+year+"    "+soil_5k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,soil_5k_2d(:,:),resabssoil)
      
      icent=icent+1
      print("plotting 2k")
      resabssoil@gsnRightString= "[kg/m2]"
      year=-2000
      resabssoil@gsnLeftString = "soil total: "+year+"    "+soil_2k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,soil_2k_2d(:,:),resabssoil)






; ;##### plotting panels

;    resP                 = True
;    resP@gsnMaximize     = True
;    resP@gsnPanelRowSpec = True
;    resP@gsnPanelCenter  = True
;    resP@gsnPanelFigureStrings = (/"g)","h)","i)"/)
    ;resP@gsnPanelScalePlotIndex = 3

;    resP@txString        = "0K 8K 126K [kg/m2]"
;    gsn_panel(wks,plot(1:3),(/1,1,1/),resP)


;    resP@txString        = "8K [kg/m2]"
;    gsn_panel(wks,plot(1:3),(/1,1,1/),resP)


;    resP@txString        = "anomalies 8K and 126K [kg/m2]"
;    gsn_panel(wks,plot(4:5),(/1,1/),resP)


    ;frame (wks)


end


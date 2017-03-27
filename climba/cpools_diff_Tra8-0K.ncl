load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

    wks_type = "pdf"
    wks                 = gsn_open_wks(wks_type ,"pdf/tra8-0k_carbonpools_climba_difftimeslice")
    
     gsn_define_colormap(wks,"BrownBlue12")
	
    gsnMaximize            = True
    resdiff = True 


 
    resdiff@cnFillOn       = True               ; color Fill 
    resdiff@cnFillMode     = "CellFill"
    resdiff@cnLinesOn      = False             ; Turn off contour lines
    resdiff@gsnFrame       = True 
    resdiff@gsnDraw         = True
    
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

	  resdiff@lbAutoManage = False
     resdiff@lbLabelFontHeightF = 0.015

    resdiff@tmXBOn=False
    resdiff@tmXTOn=False
    resdiff@tmYROn=False
    resdiff@tmYLOn=False

    plot=new(80,graphic)
    
    resdiff@cnLevelSelectionMode      = "ExplicitLevels" 
    resdiff@mpLandFillColor = -1

    
    resdiff@cnLevels= (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)
    resdiff@cnFillColors=(/13,12,11,10,9,8,-1, 7,6,5,4,3,2/)

    resdiff@pmLabelBarWidthF = 0.8

    resdiff@lbLabelAngleF=-90

    resdiff@gsnRightString= "[kg/m2]"



    resdifftotal=resdiff
    resdifftotal@cnLevels = (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)
    
     resdiffsoil=resdiff
     resdiffsoil@cnLevels = (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)
     
     
     resdiffgreen=resdiff
     resdiffgreen@cnLevels = (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)
 
    


    path="~/Desktop/climba/cpools/"


; files for differences 
; all cent
        filename2d_all=path+"climba_Tra8-0k_carbon_00-59_Cfields_2d_tm_ano0000.nc"
        filename1d_all=path+"climba_Tra8-0k_carbon_00-59_Csums_tm_ano0000.nc"

        data_all_2d=addfile(filename2d_all, "r")
        data_all_1d=addfile(filename1d_all, "r")
     
        total_all_2d=data_all_2d->box_Cpools_total(:,:,:)
        soil_all_2d=data_all_2d->box_Cpools_soil(:,:,:)
        green_all_2d=data_all_2d->box_Cpools_green(:,:,:)
        total_all_1d=data_all_1d->box_Cpools_total(:,0,0)
        soil_all_1d=data_all_1d->box_Cpools_soil(:,0,0)
        green_all_1d=data_all_1d->box_Cpools_green(:,0,0)


; 2k-8K
       filename2d_8k=path+"climba_Tra8-0k_carbon_2K-8K_Cfields_tm.nc"
       filename1d_8k=path+"climba_Tra8-0k_carbon_2K-8K_Csums_tm.nc"
 
       data_8k_2d=addfile(filename2d_8k, "r")
       data_8k_1d=addfile(filename1d_8k, "r")
 
       total_8k_2d=data_8k_2d->box_Cpools_total(0,:,:)
       soil_8k_2d=data_8k_2d->box_Cpools_soil(0,:,:)
       green_8k_2d=data_8k_2d->box_Cpools_green(0,:,:)
       total_8k_1d=data_8k_1d->box_Cpools_total(0,0,0)
       soil_8k_1d=data_8k_1d->box_Cpools_soil(0,0,0)
       green_8k_1d=data_8k_1d->box_Cpools_green(0,0,0)
 
;2k-5K 
        filename2d_5k=path+"climba_Tra8-0k_carbon_2K-5K_Cfields_tm.nc"
        filename1d_5k=path+"climba_Tra8-0k_carbon_2K-5K_Csums_tm.nc"
 
        data_5k_2d=addfile(filename2d_5k, "r")
        data_5k_1d=addfile(filename1d_5k, "r")
 
        total_5k_2d=data_5k_2d->box_Cpools_total(0,:,:)
        soil_5k_2d=data_5k_2d->box_Cpools_soil(0,:,:)
        green_5k_2d=data_5k_2d->box_Cpools_green(0,:,:)
        total_5k_1d=data_5k_1d->box_Cpools_total(0,0,0)
        soil_5k_1d=data_5k_1d->box_Cpools_soil(0,0,0)
        green_5k_1d=data_5k_1d->box_Cpools_green(0,0,0)




; files for anomlies to 8k
; files for anomlies to 3k


      printVarSummary(total_all_1d)
      total_all_2d@_FillValue = -9.e+33
       total_8k_2d@_FillValue = -9.e+33
       total_5k_2d@_FillValue = -9.e+33

      
      green_all_2d@_FillValue = -9.e+33
       green_8k_2d@_FillValue = -9.e+33
       green_5k_2d@_FillValue = -9.e+33
   
      soil_all_2d@_FillValue = -9.e+33
       soil_8k_2d@_FillValue = -9.e+33
       soil_5k_2d@_FillValue = -9.e+33
      
      
      
      
      
; plot time series
     ; do icent=0,59
     ;    print("plotting "+icent)
     ;    resdiff@gsnRightString= "[kg/m2]"
     ;    year=-8000+icent*100
     ;    resdiff@gsnLeftString = "cpools total: "+year+"    "+total_all_1d(icent)+" Gt C"
     ;    plot(icent) = gsn_csm_contour_map(wks,total_all_2d(icent,:,:),resdifftotal)
     ; 
     ;  end do
      
     icent=59
 
 ; TOTAL
 ; 2k-8k
      icent=icent+1
      print("plotting 2K-8k")
      resdifftotal@gsnRightString= "[kg/m2]"
      year="2K-8K"
      resdifftotal@gsnLeftString = "cpools total: "+year+"    "+total_8k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,total_8k_2d(:,:),resdifftotal)

; 2k-5k
      icent=icent+1
      print("plotting 2K-5k")
      resdifftotal@gsnRightString= "[kg/m2]"
      year="2K-5K"
      resdifftotal@gsnLeftString = "cpools total: "+year+"    "+total_5k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,total_5k_2d(:,:),resdifftotal)
      
      



; GREEN
 ; 2k-8k
      icent=icent+1
      print("plotting 2K-8k")
      resdiffgreen@gsnRightString= "[kg/m2]"
      year="2K-8K"
      resdiffgreen@gsnLeftString = "cpools green: "+year+"    "+green_8k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,green_8k_2d(:,:),resdiffgreen)

; 2k-5k
      icent=icent+1
      print("plotting 2K-5k")
      resdiffgreen@gsnRightString= "[kg/m2]"
      year="2K-5K"
      resdiffgreen@gsnLeftString = "cpools green: "+year+"    "+green_5k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,green_5k_2d(:,:),resdiffgreen)




; Soil
 ; 2k-8k
      icent=icent+1
      print("plotting 2K-8k")
      resdiffsoil@gsnRightString= "[kg/m2]"
      year="2K-8K"
      resdiffsoil@gsnLeftString = "cpools soil: "+year+"    "+soil_8k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,soil_8k_2d(:,:),resdiffsoil)

; 2k-5k
      icent=icent+1
      print("plotting 2K-5k")
      resdiffsoil@gsnRightString= "[kg/m2]"
      year="2K-5K"
      resdiffsoil@gsnLeftString = "cpools soil: "+year+"    "+soil_5k_1d+" Gt C"
      plot(icent) = gsn_csm_contour_map(wks,soil_5k_2d(:,:),resdiffsoil)
      



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


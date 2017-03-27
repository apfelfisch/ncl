load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "/Volumes/work/m300107/scripts/plot/ncl/libs/climba.ncl"


begin



; input data
; 0k
   vegstream_0k=
   jsbachstream_0k=
   landstream_0k=
; 8k
vegstream_8k=
jsbachstream_8k=
landstream_8k=

; 126k
vegstream_126k=
jsbachstream_126k=
landstream_126k=




; general settings for all plots
      wks_type = "pdf"
      gsnMaximize            = True

      res=True 
      res@cnFillOn        = True            ; color Fill 
      res@cnFillMode      = "CellFill"       ; Raster Mode
      res@cnLinesOn       = False             ; Turn off contour lines
      res@gsnFrame        = False 
      res@gsnDraw          = False

      res@cnFillDrawOrder  = "PostDraw"
      res@mpProjection     ="Mollweide"
      res@mpLandFillColor  = "Gray"
      res@mpOceanFillColor = "skyblue2"


      res@mpPerimOn         = False             ; turn off box around plot
      res@mpGridLatSpacingF = 30.               ; spacing for lat lines
      res@mpGridLonSpacingF = 30.               ; spacing for lon lines
 	  
      res@mpFillOn          = True

      res@cnFillOn          = True              ; color plot desired
      res@cnLineLabelsOn    = False             ; turn off contour lines
      res@txFontHeightF     = 0.015 

      res@vpXF            = 0.1                 ; make plot bigger
      res@vpYF            = 0.9         
      res@vpWidthF        = 0.8
      res@vpHeightF       = 0.8

      res@tmXBOn=False
      res@tmXTOn=False
      res@tmYROn=False
      res@tmYLOn=False

      res@cnLevelSelectionMode      = "ExplicitLevels" 
      res@mpLandFillColor = -1
      res@lbAutoManage = False
      res@lbLabelFontHeightF = 0.015

      res@pmLabelBarWidthF = 0.8
      res@lbLabelAngleF=-90


      ; for panels
      resP = True
      resP@gsnMaximize     = True
      resP@gsnPanelRowSpec = True
      resP@gsnPanelCenter  = True
      ;resP@gsnPanelFigureStrings = (/"g)","h)","i)"/)
      ;resP@gsnPanelScalePlotIndex = 3

      




      ;;; cpools
      
      res_cpoolsabs=res
      res_cpoolsdiff=res
      wks_cpoolsabs                  = gsn_open_wks(wks_type ,"pdf/cpools_abs_timeslices")
      wks_cpoolsdiff                 = gsn_open_wks(wks_type ,"pdf/cpools_diff_timeslices")

      gsn_define_colormap(wks_cpoolsabs,"brown")
      gsn_define_colormap(wks_cpoolsdiff,"BrownBlue12")
      
      gsn_draw_colormap(wks_cpoolsabs)
      gsn_draw_colormap(wks_cpoolsdiff)

      plotcpoolsabs=new(10,graphic)
      res_cpoolsabs@cnLevels = (/0.05,0.10,0.50,1,2.5,5.,10,15,25,50/)
      res_cpoolsabs@cnFillColors = (/2,3,4,5,6,7,8,9,10,11,12/)
      res_cpoolsabs@gsnRightString= "[kg/m2]"



      plotcpoolsdiff=new(10,graphic)
      res_cpoolsdiff@cnLevels= (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)
      res_cpoolsdiff@cnFillColors=(/13,12,11,10,9,8,-1,7,6,5,4,3,2/)
      res_cpoolsdiff@gsnRightString= "[kg/m2]"
      


      ; reading data
      ;##0k 
      filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      data2d=addfile(filename2d, "r")
      data1d=addfile(filename1d, "r")
      total0k2d=data2d->box_Cpools_total(0,:,:)
      soil0k2d=data2d->box_Cpools_soil(0,:,:)
      green0k2d=data2d->box_Cpools_green(0,:,:)
      total0k1d=data1d->box_Cpools_total(0,0,0)
      soil0k1d=data1d->box_Cpools_soil(0,0,0)
      green0k1d=data1d->box_Cpools_green(0,0,0)

      ;##8k 
      filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      data2d=addfile(filename2d, "r")
      data1d=addfile(filename1d, "r")
      total8k2d=data2d->box_Cpools_total(0,:,:)
      soil8k2d=data2d->box_Cpools_soil(0,:,:)
      green8k2d=data2d->box_Cpools_green(0,:,:)
      total8k1d=data1d->box_Cpools_total(0,0,0)
      soil8k1d=data1d->box_Cpools_soil(0,0,0)
      green8k1d=data1d->box_Cpools_green(0,0,0)

      ;##126k 
      filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      data2d=addfile(filename2d, "r")
      data1d=addfile(filename1d, "r")
      total126k2d=data2d->box_Cpools_total(0,:,:)
      soil126k2d=data2d->box_Cpools_soil(0,:,:)
      green126k2d=data2d->box_Cpools_green(0,:,:)
      total126k1d=data1d->box_Cpools_total(0,0,0)
      soil126k1d=data1d->box_Cpools_soil(0,0,0)
      green126k1d=data1d->box_Cpools_green(0,0,0)


      
      ;calculate differences
      ; 126k-0k
      total126k0k2d=total126k2d-total0k2d
      soil126k0k2d=soil126k2d-soil0k2d
      green126k0k2d=green126k2d-green0k2d
      total126k0k1d=total126k1d-total0k1d
      soil126k0k1d=soil126k1d-soil0k1d
      green126k0k1d=green126k1d-green0k1d
      
      ; 8k-0k
      total8k0k2d=total8k2d-total0k2d
      soil8k0k2d=soil8k2d-soil0k2d
      green8k0k2d=green8k2d-green0k2d
      total8k0k1d=total8k1d-total0k1d
      soil8k0k1d=soil8k1d-soil0k1d
      green8k0k1d=green8k1d-green0k1d
      
      ; 126k-8k
      total126k8k2d=total126k2d-total8k2d
      soil126k8k2d=soil126k2d-soil8k2d
      green126k8k2d=green126k2d-green8k2d
      total126k8k1d=total126k1d-total8k1d
      soil126k8k1d=soil126k1d-soil8k1d
      green126k8k1d=green126k1d-green8k1d
      
      
      ; plotten
      ; absolute values
      ; total
      res_cpoolsabs@gsnLeftString = "cpools total, 0k; "+total0k1d+" Gt C"
      plotcpoolsabs(0) = gsn_csm_contour_map(wks_cpoolsabs,total0k2d,res_cpoolsabs)
      res_cpoolsabs@gsnLeftString = "cpools total, 8k; "+total8k1d+" Gt C"
      plotcpoolsabs(1) = gsn_csm_contour_map(wks_cpoolsabs,total8k2d,res_cpoolsabs)
      res_cpoolsabs@gsnLeftString = "cpools total, 126k; "+total126k1d+" Gt C"
      plotcpoolsabs(2) = gsn_csm_contour_map(wks_cpoolsabs,total126k2d,res_cpoolsabs)
      ; soil
      res_cpoolsabs@gsnLeftString = "cpools soil, 0k; "+soil0k1d+" Gt C"
      plotcpoolsabs(3) = gsn_csm_contour_map(wks_cpoolsabs,soil0k2d,res_cpoolsabs)
      res_cpoolsabs@gsnLeftString = "cpools soil, 8k; "+soil8k1d+" Gt C"
      plotcpoolsabs(4) = gsn_csm_contour_map(wks_cpoolsabs,soil8k2d,res_cpoolsabs)
      res_cpoolsabs@gsnLeftString = "cpools soil, 126k; "+soil126k1d+" Gt C"
      plotcpoolsabs(5) = gsn_csm_contour_map(wks_cpoolsabs,soil126k2d,res_cpoolsabs)
      ; green
      res_cpoolsabs@gsnLeftString = "cpools green, 0k; "+green0k1d+" Gt C"
      plotcpoolsabs(6) = gsn_csm_contour_map(wks_cpoolsabs,green0k2d,res_cpoolsabs)
      res_cpoolsabs@gsnLeftString = "cpools green, 8k; "+green8k1d+" Gt C"
      plotcpoolsabs(7) = gsn_csm_contour_map(wks_cpoolsabs,green8k2d,res_cpoolsabs)
      res_cpoolsabs@gsnLeftString = "cpools green, 126k; "+green126k1d+" Gt C"
      plotcpoolsabs(8) = gsn_csm_contour_map(wks_cpoolsabs,green126k2d,res_cpoolsabs)

      ;panels
      res_cpoolsabsP=resP
      res_cpoolsabsP@txString        = "absolute values for cpools total 0k 8k 126k [kg/m2]"
      gsn_panel(wks_cpoolsabs,plotcpoolsabs(0:2),(/1,1,1/),res_cpoolsabsP)
      res_cpoolsabsP@txString        = "absolute values for cpools soil 0k 8k 126k [kg/m2]"
      gsn_panel(wks_cpoolsabs,plotcpoolsabs(3:5),(/1,1,1/),res_cpoolsabsP)
      res_cpoolsabsP@txString        = "absolute values for cpools green 0k 8k 126k [kg/m2]"
      gsn_panel(wks_cpoolsabs,plotcpoolsabs(6:8),(/1,1,1/),res_cpoolsabsP)



      ; differences values
      ; total
      res_cpoolsdiff@gsnLeftString = "cpools total, 126k-0k; "+total126k0k1d+" Gt C"
      res_cpoolsdiff(0) = gsn_csm_contour_map(wks_cpoolsdiff,total126k0k2d,res_cpoolsdiff)
      res_cpoolsdiff@gsnLeftString = "cpools total, 8k-0k; "+total8k0k1d+" Gt C"
      res_cpoolsdiff(1) = gsn_csm_contour_map(wks_cpoolsdiff,total8k-0k2d,res_cpoolsdiff)
      res_cpoolsdiff@gsnLeftString = "cpools total, 126k-8k; "+total126k8k1d+" Gt C"
      res_cpoolsdiff(2) = gsn_csm_contour_map(wks_cpoolsdiff,total126k8k2d,res_cpoolsdiff)
      ; soil
      res_cpoolsdiff@gsnLeftString = "cpools soil, 126k-0k; "+soil126k0k1d+" Gt C"
      res_cpoolsdiff(0) = gsn_csm_contour_map(wks_cpoolsdiff,soil126k0k2d,res_cpoolsdiff)
      res_cpoolsdiff@gsnLeftString = "cpools soil, 8k-0k; "+soil8k0k1d+" Gt C"
      res_cpoolsdiff(1) = gsn_csm_contour_map(wks_cpoolsdiff,soil8k0k2d,res_cpoolsdiff)
      res_cpoolsdiff@gsnLeftString = "cpools soil, 126k-8k; "+soil126k8k1d+" Gt C"
      res_cpoolsdiff(2) = gsn_csm_contour_map(wks_cpoolsdiff,soil126k8k2d,res_cpoolsdiff)
      ; green
      res_cpoolsdiff@gsnLeftString = "cpools green, 126k-0k; "+green126k0k1d+" Gt C"
      res_cpoolsdiff(0) = gsn_csm_contour_map(wks_cpoolsdiff,green126k0k2d,res_cpoolsdiff)
      res_cpoolsdiff@gsnLeftString = "cpools green, 8k-0k; "+green8k0k1d+" Gt C"
      res_cpoolsdiff(1) = gsn_csm_contour_map(wks_cpoolsdiff,green8k0k2d,res_cpoolsdiff)
      res_cpoolsdiff@gsnLeftString = "cpools green, 126k-8k; "+green126k8k1d+" Gt C"
      res_cpoolsdiff(2) = gsn_csm_contour_map(wks_cpoolsdiff,green126k8k2d,res_cpoolsdiff)
      
      ;panels
      res_cpoolsdiffP=resP
      res_cpoolsdiffP@txString        = "differences for cpools total 126k-0k 8k-0k 126k-8k [kg/m2]"
      gsn_panel(wks_cpoolsdiff,res_cpoolsdiff(0:2),(/1,1,1/),res_cpoolsdiffP)
      res_cpoolsdiffP@txString        = "differences for cpools soil 0k 8k 126k [kg/m2]"
      gsn_panel(wks_cpoolsdiff,res_cpoolsdiff(3:5),(/1,1,1/),res_cpoolsdiffP)
      res_cpoolsdiffP@txString        = "differences for cpools green 0k 8k 126k [kg/m2]"
      gsn_panel(wks_cpoolsdiff,res_cpoolsdiff(6:8),(/1,1,1/),res_cpoolsdiffP)







      ; =================================================================================================================================================
      ; plotting fire
      res_fireabs=res
      res_firediff=res
      wks_fireabs                  = gsn_open_wks(wks_type ,"pdf/fire_abs_timeslices")
      wks_firediff                 = gsn_open_wks(wks_type ,"pdf/fire_diff_timeslices")

      gsn_define_colormap(wks_fireabs,"WhiteYellowOrangeRed")
      gsn_define_colormap(wks_firediff,"temp_diff_18lev")
      
      gsn_draw_colormap(wks_firesabs)
      gsn_draw_colormap(wks_firediff)

      plotfiresabs=new(10,graphic)
      res_fireabs@cnLevels = (/0.01,0.025,0.05,0.075,0.1,0.125,0.15,0.175,0.2//)
      res_fireabs@cnFillColors = (/2,3,4,5,6,7,8,9,10,11,12/)
      res_fireabs@gsnRightString= "[M ha]"



      plotfirediff=new(10,graphic)
      res_firediff@cnLevels= (/-0.1,-0.075,-0.05,-0.025,-0.005,0.005,0.025,0.05,0.075,0.1/)
      res_firediff@cnFillColors=(/13,12,11,10,9,8,-1,7,6,5,4,3,2/)
      res_firediff@gsnRightString= "[M ha]"
      


      ; reading data
      ;##0k 
      filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      data2d=addfile(filename2d, "r")
      data1d=addfile(filename1d, "r")
      fire0k2d=data2d->box_burned_acc(0,:,:)
      fire0k1d=data1d->box_burned_acc(0,0,0)

      ;##8k 
      filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      data2d=addfile(filename2d, "r")
      data1d=addfile(filename1d, "r")
      fire8k2d=data2d->box_burned_acc(0,:,:)
      fire8k1d=data1d->box_burned_acc(0,0,0)

      ;##126k 
      filename2d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      filename1d="/Volumes/work/m300107/experiments/output/jsbach_climber_0017_3500-01-01_veg_tm_Cfields_2d.nc"
      data2d=addfile(filename2d, "r")
      data1d=addfile(filename1d, "r")
      fire126k2d=data2d->box_burned_acc(0,:,:)
      fire126k1d=data1d->box_burned_acc(0,0,0)


      
      ;calculate differences
      ; 126k-0k
      fire126k0k2d=fire126k2d-fire0k2d
      fire126k0k1d=fire126k1d-fire0k1d
      
      ; 8k-0k
      fire8k0k2d=fire8k2d-fire0k2d
      fire8k0k1d=fire8k1d-fire0k1d
      
      ; 126k-8k
      fire126k8k2d=fire126k2d-fire8k2d
      fire126k8k1d=fire126k1d-fire8k1d
      
      
      ; plotten
      ; absolute values
      ; fire
      res_fireabs@gsnLeftString = "burned area, 0k; "+fire0k1d+" M ha"
      plotfireabs(0) = gsn_csm_contour_map(wks_fireabs,fire0k2d,res_fireabs)
      res_fireabs@gsnLeftString = "burned area, 8k; "+fire8k1d+" M ha"
      plotfireabs(1) = gsn_csm_contour_map(wks_fireabs,fire8k2d,res_fireabs)
      res_cpoolsabs@gsnLeftString = "burned area, 126k; "+fire126k1d+" M ha"
      plotfireabs(2) = gsn_csm_contour_map(wks_fireabs,fire126k2d,res_fireabs)

      ;panels
      res_fireabsP=resP
      res_fireabsP@txString        = "absolute values for burned area 0k 8k 126k [kg/m2]"
      gsn_panel(wks_cpoolsabs,plotcpoolsabs(0:2),(/1,1,1/),res_fireabsP)



      ; differences values
      ; total
      res_firediff@gsnLeftString = "cburned area, 126k-0k; "+fire126k0k1d+" M ha"
      plotfirediff(0) = gsn_csm_contour_map(wks_firediff,fire126k0k2d,res_firediff)
      res_firediff@gsnLeftString = "burned area, 8k-0k; "+fire8k0k1d+" M ha"
      plotfirediff(1) = gsn_csm_contour_map(wks_firediff,fire8k0k2d,res_firediff)
      res_firediff@gsnLeftString = "burned area, 126k-8k; "+fire126k8k1d+" M ha"
      plotfirediff(2) = gsn_csm_contour_map(wks_firediff,fire126k8k2d,res_firediff)
      
      ;panels
      res_firediffP=resP
      res_firediffP@txString        = "differences for burned area 126k-0k 8k-0k 126k-8k [M ha]"
      gsn_panel(wks_firediff,plotfirediff(0:2),(/1,1,1/),res_firediffP)
      
      
      
      
      
      ; =================================================================================================================================================
      ; plotting woody fraction
      res_woodyabs=res
      res_woodydiff=res
      res_shrubsabs=res
      res_shrubsdiff=res
      res_grassabs=res
      res_grassdiff=res
      res_desabs=res
      res_desdiff=res

      wks_woodyabs                  = gsn_open_wks(wks_type ,"pdf/woody_abs_timeslices")
      wks_woodydiff                 = gsn_open_wks(wks_type ,"pdf/woody_diff_timeslices")
      wks_shrubsabs                 = gsn_open_wks(wks_type ,"pdf/shrubs_abs_timeslices")
      wks_shrubsdiff                = gsn_open_wks(wks_type ,"pdf/shrubs_diff_timeslices")
      wks_grassyabs                 = gsn_open_wks(wks_type ,"pdf/grass_abs_timeslices")
      wks_grassdiff                 = gsn_open_wks(wks_type ,"pdf/grass_diff_timeslices")
      wks_desabs                    = gsn_open_wks(wks_type ,"pdf/des_abs_timeslices")
      wks_desdiff                   = gsn_open_wks(wks_type ,"pdf/des_diff_timeslices")


      gsn_define_colormap(wks_woodyabs,"WhiteGreen")
      gsn_define_colormap(wks_woodydiff,"GreenMagenta16")
      gsn_define_colormap(wks_shrubsabs,"WhiteGreen")
      gsn_define_colormap(wks_shrubsdiff,"GreenMagenta16")
      gsn_define_colormap(wks_grassabs,"WhiteGreen")
      gsn_define_colormap(wks_grassdiff,"GreenMagenta16")
      gsn_define_colormap(wks_desabs,"WhiteGreen")
      gsn_define_colormap(wks_desdiff,"GreenMagenta16")
      
      gsn_draw_colormap(wks_woodyabs)
      gsn_draw_colormap(wks_woodydiff)
      gsn_draw_colormap(wks_shrubsabs)
      gsn_draw_colormap(wks_shrubsdiff)
      gsn_draw_colormap(wks_grassabs)
      gsn_draw_colormap(wks_grassdiff)
      gsn_draw_colormap(wks_desabs)
      gsn_draw_colormap(wks_desdiff)



;        gsn_define_colormap(wks,"OceanLakeLandSnow") 
;      resabsdes@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5/) ; 13 level


;      resabsdes@cnFillColors = (/90,100,110,120,130,140,150,160,170,180,190,200,210,220/) ; 14 colors



;      resdiffdes@cnLevels= (/-0.3,-0.25,-0.20,-0.15,-0.10,-0.05,0.05,0.1,0.15,0.20,0.25,0.30/)
;      resdiffdes@cnFillColors = (/2,3,4,5,6,7,9,11,12,13,14,15,16,17/) ; 14 colors


;gsn_define_colormap(wks,"WhiteGreen")
; resabscover@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5/) ; 13 level


; forest diff
;gsn_define_colormap(wks,"GreenMagenta16")
;resdiffcover@cnLevels= (/-0.3,-0.25,-0.20,-0.15,-0.10,-0.05,0.05,0.1,0.15,0.20,0.25,0.30/)
;resdiffcover@cnFillColors = (/16,15,14,13,12,11,9,7,6,5,4,3,2/) ; 14 colors



      plotwoodyabs=new(10,graphic)
      res_woodyabs@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5/) ; 13 level
      res_woodyabs@cnFillColors = (//207,191,175,159,143,127,95,79,63,47,31,15//)
      res_woodyabs@gsnRightString= "[ ]"

      plotwoodydiff=new(10,graphic)
      res_woodydiff@cnLevels= (/-0.3,-0.25,-0.20,-0.15,-0.10,-0.05,0.05,0.1,0.15,0.20,0.25,0.30/)
      res_woodydiff@cnFillColors=(/207,191,175,159,143,127,-1,79,63,47,31,15,4/)
      res_woodydiff@gsnRightString= "[ ]"
      
      plotshrubssabs=new(10,graphic)
      res_shrubsabs@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5/) ; 13 level
      res_shrubsabs@cnFillColors = (//207,191,175,159,143,127,95,79,63,47,31,15//)
      res_shrubsabs@gsnRightString= "[ ]"

      plotshrubsdiff=new(10,graphic)
      res_shrubsdiff@cnLevels= (/-0.3,-0.25,-0.20,-0.15,-0.10,-0.05,0.05,0.1,0.15,0.20,0.25,0.30/)
      res_shrubsdiff@cnFillColors=(/207,191,175,159,143,127,-1,79,63,47,31,15,4/)
      res_shrubsdiff@gsnRightString= "[ ]"

      plotgrasssabs=new(10,graphic)
      res_grassabs@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5/) ; 13 level
      res_grassabs@cnFillColors = (//207,191,175,159,143,127,95,79,63,47,31,15//)
      res_grassabs@gsnRightString= "[ ]"

      plotgrassdiff=new(10,graphic)
      res_grassdiff@cnLevels= (/-0.3,-0.25,-0.20,-0.15,-0.10,-0.05,0.05,0.1,0.15,0.20,0.25,0.30/)
      res_grassdiff@cnFillColors=(/207,191,175,159,143,127,-1,79,63,47,31,15,4/)
      res_grassdiff@gsnRightString= "[ ]"

      plotdesabs=new(10,graphic)
      res_desabs@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.4,0.5,0.6,0.7,0.8,0.9/) ; 13 level
      res_desabs@cnFillColors = (/15,31,47,63,79,95,111,127,143,159,175,191,207,223/)
      res_desabs@gsnRightString= "[ ]"

      plotdesdiff=new(10,graphic)
      res_desdiff@cnLevels= (/-0.3,-0.25,-0.20,-0.15,-0.10,-0.05,0.05,0.1,0.15,0.20,0.25,0.30/)
      res_desdiff@cnFillColors=(/4,15,31,47,63,79,-1,127,143,159,175,191,207,223/)
      res_desdiff@gsnRightString= "[ ]"


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


      ; reading data
      ;##0k 
      filename2d="/Volumes/work/m300107/experiments/jsbach_climber_0017_2950-01-01_jsbach_tm.nc"
      cover_fract0k=data->cover_fract(0,:,:,:)
      veg_ratio_max0k=data->veg_ratio_max(0,:,:)
      veg_fract_correction0k=data->veg_fract_correction(0,:,:,:)
      des0k=1.-veg_ratio_max0k
      copy_VarMeta(veg_ratio_max0k,des0k)
      woody0k=veg_ratio_max0k*dim_sum_n_Wrap(cover_fract0k(0:5,:,:),0)
      copy_VarMeta(veg_ratio_max0k,woody0k)
      shrubs0k=veg_ratio_max0k*dim_sum_n_Wrap(cover_fract0k(4:5,:,:),0)
      copy_VarMeta(veg_ratio_max0k,shrubs0k)
      grass0k=veg_ratio_max0k*dim_sum_n_Wrap(cover_fract0k(6:7,:,:),0)
      copy_VarMeta(veg_ratio_max0k,grass0k)

      ;##8k 
      filename2d="/Volumes/work/m300107/experiments/jsbach_climber_0017_2950-01-01_jsbach_tm.nc"
      cover_fract8k=data->cover_fract(0,:,:,:)
      veg_ratio_max8k=data->veg_ratio_max(0,:,:)
      veg_fract_correction8k=data->veg_fract_correction(0,:,:,:)
      des0k=1.-veg_ratio_max8k
      copy_VarMeta(veg_ratio_max8k,des8k)
      woody8k=veg_ratio_max8k*dim_sum_n_Wrap(cover_fract8k(0:5,:,:),0)
      copy_VarMeta(veg_ratio_max8k,woody8k)
      shrubs8k=veg_ratio_max8k*dim_sum_n_Wrap(cover_fract8k(4:5,:,:),0)
      copy_VarMeta(veg_ratio_max8k,shrubs8k)
      grass8k=veg_ratio_max8k*dim_sum_n_Wrap(cover_fract8k(6:7,:,:),0)
      copy_VarMeta(veg_ratio_max8k,grass8k)

      ;##126k 
      filename2d="/Volumes/work/m300107/experiments/jsbach_climber_0017_2950-01-01_jsbach_tm.nc"
      cover_fract126k=data->cover_fract(0,:,:,:)
      veg_ratio_max126k=data->veg_ratio_max(0,:,:)
      veg_fract_correction126k=data->veg_fract_correction(0,:,:,:)
      des126k=1.-veg_ratio_max126k
      copy_VarMeta(veg_ratio_max126k,des126k)
      woody126k=veg_ratio_max126k*dim_sum_n_Wrap(cover_fract126k(0:5,:,:),0)
      copy_VarMeta(veg_ratio_max126k,woody126k)
      shrubs126k=veg_ratio_max126k*dim_sum_n_Wrap(cover_fract126k(4:5,:,:),0)
      copy_VarMeta(veg_ratio_max126k,shrubs126k)
      grass126k=veg_ratio_max126k*dim_sum_n_Wrap(cover_fract126k(6:7,:,:),0)
      copy_VarMeta(veg_ratio_max126k,grass126k)


      ;calculate differences
      ; 126k-0k
      des126k0k   =des126k    - des0k
      woody126k0k =woody126k  - woody0k
      shrubs126k0k=shrubs126k - shrubs0k
      grass126k0k =grass126k  - grass0k

      ; 8k-0k
      des8k0k    = des126k   - des0k
      woody8k0k  = woody126k - woody0k
      shrubs8k0k = shrubs126k- shrubs0k
      grass8k0k  = grass126k - grass0k

      ; 126k-8k
      des126k8k    = des126k    - des8k
      woody126k8k  = woody126k  - woody8k
      shrubs126k8k = shrubs126k - shrubs8k
      grass126k8k  = grass126k  - grass8k


      ; plotten
      ; absolute values
      ; desert fraction
      res_desabs@gsnLeftString = "0k desert fraction []"
      plotdesabs(0) = gsn_csm_contour_map_ce(wks,des0k,res_desabs)
      res_desabs@gsnLeftString = "8k desert fraction []"
      plotdesabs(1) = gsn_csm_contour_map_ce(wks,des8k,res_desabs)
      res_desabs@gsnLeftString = "126k desert fraction []"
      plotdesabs(2) = gsn_csm_contour_map_ce(wks,des126k,res_desabs)

      ; woody fraction
      res_woodyabs@gsnLeftString = "0k woody fraction []"
      plotwoodyabs(0) = gsn_csm_contour_map_ce(wks,woody0k,res_woodyabs)
      res_woodyabs@gsnLeftString = "8k woody fraction []"
      plotwoodyabs(1) = gsn_csm_contour_map_ce(wks,woody8k,res_woodyabs)
      res_woodyabs@gsnLeftString = "126k woody fraction []"
      plotwoodyabs(2) = gsn_csm_contour_map_ce(wks,woody126k,res_woodyabs)

      ; shrubs fraction
      res_shrubsabs@gsnLeftString = "0k shrubs fraction []"
      plotshrubsabs(0) = gsn_csm_contour_map_ce(wks,shrubs0k,res_shrubsabs)
      res_shrubsabs@gsnLeftString = "8k shrubs fraction []"
      plotshrubsabs(1) = gsn_csm_contour_map_ce(wks,shrubs8k,res_shrubsabs)
      res_shrubsabs@gsnLeftString = "126k shrubs fraction []"
      plotshrubsabs(2) = gsn_csm_contour_map_ce(wks,shrubs126k,res_shrubsabs)

      ; grass fraction
      res_grassabs@gsnLeftString = "0k grass fraction []"
      plotgrassabs(0) = gsn_csm_contour_map_ce(wks,grass0k,res_grassabs)
      res_grassabs@gsnLeftString = "8k grass fraction []"
      plotgrassabs(1) = gsn_csm_contour_map_ce(wks,grass8k,res_grassabs)
      res_grassabs@gsnLeftString = "126k grass fraction []"
      plotgrassabs(2) = gsn_csm_contour_map_ce(wks,grass126k,res_grassabs)


      ;panels
      res_desabsP=resP
      res_desabsP@txString           = "absolute values for desert fraction 0k 8k 126k [ ]"
      gsn_panel(wks_desabs,plotdesabs(0:2),(/1,1,1/),res_desabsP)
      
      res_woodyabsP=resP
      res_woodyabsP@txString         = "absolute values for woody fraction 0k 8k 126k [ ]"
      gsn_panel(wks_woodyabs,plotwoodyabs(0:2),(/1,1,1/),res_woodyabsP)

      res_shrubsabsP=resP
      res_shrubsabsP@txString        = "absolute values for shrubs fraction 0k 8k 126k [ ]"
      gsn_panel(wks_shrubsabs,plotshrubsabs(0:2),(/1,1,1/),res_shrubsabsP)

      res_grassabsP=resP
      res_shrubsabsP@txString        = "absolute values for grass fraction 0k 8k 126k [ ]"
      gsn_panel(wks_grassabs,plotgrassabs(0:2),(/1,1,1/),res_grassabsP)



      ; differences
      ; desert fraction
      res_desdiff@gsnLeftString = "126k-0k desert fraction []"
      plotdesdiff(0) = gsn_csm_contour_map_ce(wks,des126k0k,res_desdiff)
      res_desdiff@gsnLeftString = "8k-0k desert fraction []"
      plotdesdiff(1) = gsn_csm_contour_map_ce(wks,des8k0k,res_desdiff)
      res_desdiff@gsnLeftString = "126k-8k desert fraction []"
      plotdesdiff(2) = gsn_csm_contour_map_ce(wks,des126k8k,res_desdiff)

      ; woody fraction
      res_woodydiff@gsnLeftString = "126k-0k woody fraction []"
      plotwoodydiff(0) = gsn_csm_contour_map_ce(wks,woody126k0k,res_woodydiff)
      res_woodydiff@gsnLeftString = "8k-0k woody fraction []"
      plotwoodydiff(1) = gsn_csm_contour_map_ce(wks,woody8k0k,res_woodydiff)
      res_woodydiff@gsnLeftString = "126k-8k woody fraction []"
      plotwoodydiff(2) = gsn_csm_contour_map_ce(wks,woody126k8k,res_woodydiff)

      ; shrubs fraction
      res_shrubsdiff@gsnLeftString = "126k-0k shrubs fraction []"
      plotshrubsdiff(0) = gsn_csm_contour_map_ce(wks,shrubs126k0k,res_shrubsdiff)
      res_shrubsdiff@gsnLeftString = "8k-0k shrubs fraction []"
      plotshrubsdiff(1) = gsn_csm_contour_map_ce(wks,shrubs8k0k,res_shrubsdiff)
      res_shrubsdiff@gsnLeftString = "126k-8k shrubs fraction []"
      plotshrubsdiff(2) = gsn_csm_contour_map_ce(wks,shrubs126k8k,res_shrubsdiff)

      ; grass fraction
      res_grassdiff@gsnLeftString = "126k-0k grass fraction []"
      plotgrassdiff(0) = gsn_csm_contour_map_ce(wks,grass126k0k,res_grassdiff)
      res_grassdiff@gsnLeftString = "8k-0k grass fraction []"
      plotgrassdiff(1) = gsn_csm_contour_map_ce(wks,grass8k0k,res_grassdiff)
      res_grassdiff@gsnLeftString = "126k-8k grass fraction []"
      plotgrassdiff(2) = gsn_csm_contour_map_ce(wks,grass126k8k,res_grassdiff)



      ;panels
      res_desdiffP=resP
      res_desdiffP@txString           = "differences for desert fraction 126k-0k 8k-0k 126k-8k [ ]"
      gsn_panel(wks_desdiff,plotdesdiff(0:2),(/1,1,1/),res_desdiffP)
      
      res_woodydiffP=resP
      res_woodydiffP@txString         = "differences for woody fraction 126k-0k 8k-0k 126k-8k [ ]"
      gsn_panel(wks_woodydiff,plotwoodydiff(0:2),(/1,1,1/),res_woodydiffP)

      res_shrubsdiffP=resP
      res_shrubsdiffP@txString        = "differences for shrubs fraction 126k-0k 8k-0k 126k-8k [ ]"
      gsn_panel(wks_shrubsdiff,plotshrubsdiff(0:2),(/1,1,1/),res_shrubsdiffP)

      res_grassdiffP=resP
      res_shrubsdiffP@txString        = "differences for grass fraction 126k-0k 8k-0k 126k-8k [ ]"
      gsn_panel(wks_grassdiff,plotgrassdiff(0:2),(/1,1,1/),res_grassdiffP)



;just C3,C4,C3C4
      ;grass0kC3=veg_ratio_max*cover_fract(6,:,:)
      ;copy_VarMeta(veg_ratio_max,grass0kC3)
      ;grass0kC4=veg_ratio_max*cover_fract(7,:,:)
      ;copy_VarMeta(veg_ratio_max,grass0kC4)
      ;grass0kC3C4=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)
      ;copy_VarMeta(veg_ratio_max,grass0kC3C4)


      ;resabscover@gsnLeftString = "0k grass fraction C3 []"
      ;plot(12) = gsn_csm_contour_map_ce(wks,grass0kC3,resabscover)
      ;resabscover@gsnLeftString = "0k grass fraction C4 []"
      ;plot(13) = gsn_csm_contour_map_ce(wks,grass0kC4,resabscover)
      ;resabscover@gsnLeftString = "0k grass fraction C3C4 []"
      ;plot(14) = gsn_csm_contour_map_ce(wks,grass0kC3C4,resabscover)





end


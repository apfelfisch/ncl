;*********************************************
; time_lat_2.ncl
;*********************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"


begin
 f  = addfile ("climba_Tra8-0k_climate_ano_00-59_seasmean_DJF.nc" , "r"); add file
 ts = f->ts
;*************************
; plotting parameters
;*************************
 wks   = gsn_open_wks ("pdf", "time_lat" )  ; open workstation 
 gsn_define_colormap(wks,"ViBlGrWhYeOrRe")  ; choose color map


 res                  = True                ; plot mods desired
 res@tiMainString     = "color example"     ; title
 res@tmXBLabelStride  = 2                   ; tick mark label stride
 res@tiYAxisString    = "time"              ; y axis title

 res@cnFillOn         = True                ; color on
 res@lbLabelStride    = 2                   ; every other label
 res@lbOrientation    = "Vertical"          ; vertical label bar
 res@cnLinesOn        = False               ; turn off contour lines
 res@gsnSpreadColors  = True                ; use full range of color map
 res@cnLevelSpacingF  = 0.1                   ; contour spacing

 plot = gsn_csm_time_lat(wks, ts(:,0,:,0), res ) 

end

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

; ------------------------------------------
; Script     : methane.ncl
; Created on : Jun 24, 2013 3:11:57 PM
; Author     : m300107
; ------------------------------------------
; Description:
;   Purpose of the script follows.
; ------------------------------------------


procedure do_ch4_2d_diff (fn,title,pdf: string)
local res, ch4fn, ch4
begin
    ch4fn=addfile(fn,"r")
    ch4=ch4fn->avg_agg_ch4_emission(0,0,:,:)


    wks = gsn_open_wks("pdf" ,pdf)             ; open a ps file
    gsn_define_colormap(wks,"BrownBlue12")             ; choose colormap
    res            = True                         ; plot mods desired
    res@gsnPolar   = "NH"                         ; specify the hemisphere
    res@mpMinLatF  = 35                           ; minimum lat to plot
    res@mpFillOn   = False
    res@cnLinesOn         = False
    res@cnFillOn          = True                  ; color fill
    res@cnFillMode        = "CellFill"
    ;res@cnLevels=fspan(4,60,4)/10. 
    res@tiMainString=title
    ;res@cnFillColors = ispan(2,12,1)
    res@gsnRightString= "[g (CH4) m-2 yr-1]"
    res@cnLevelSelectionMode = "ExplicitLevels"
    res@cnLevels = (/-0.8,-0.6,-0.4,-0.20,-0.1,-0.05,0.,0.05,0.1,0.2,0.40,0.6,0.8/)    


    plot = gsn_csm_contour_map_polar(wks,ch4,res)
end



procedure do_ch4_2d (fn,title,pdf: string)
local res, ch4fn, ch4
begin
    ch4fn=addfile(fn,"r")
    ch4=ch4fn->avg_agg_ch4_emission(0,0,:,:)


    wks = gsn_open_wks("pdf" ,pdf)             ; open a ps file
    gsn_define_colormap(wks,"precip2_17lev")             ; choose colormap

    res            = True                         ; plot mods desired
    res@gsnPolar   = "NH"                         ; specify the hemisphere
    res@mpMinLatF  = 35                           ; minimum lat to plot
    res@mpFillOn   = False
    res@cnLinesOn         = False
    res@cnFillOn          = True                  ; color fill
    res@cnFillMode        = "CellFill"
    res@cnLevelSelectionMode = "ExplicitLevels"
    res@cnLevels=(/0.4,0.8,1.2,1.6,2.0,2.4,2.8,3.2,3.6,4.0,4.4,4.8,5.2,5.6,6.0/) 
    res@tiMainString=title
    ;res@cnFillColors = ispan(2,12,1)
    res@gsnRightString= "[g (CH4) m-2 yr-1]"
    
    plot = gsn_csm_contour_map_polar(wks,ch4,res)
end


procedure do_ch4_1d (fn,title,pdf: string)
local res, ch4fn, ch4
begin
    ch4fn=addfile(fn,"r")
    ch4=ch4fn->avg_agg_ch4_emission(:,0,0,0)
    printVarSummary(ch4)

    ch4smoothed=runave(ch4, 30,0)
    ntime=dimsizes(ch4)
    printVarSummary(ch4smoothed)

    data=new((/ntime,2/),typeof(ch4),ch4@_FillValue)
    data(:,0)=ch4
    data(:,1)=ch4smoothed
    printVarSummary(data)


    wks = gsn_open_wks("pdf" ,pdf)  
    res=True
    
      
    ;res@pmLegendDisplayMode    = "Always"   ; Display a legend.
    res@pmLegendWidthF         = 0.2        ; Make it smaller
    res@pmLegendHeightF        = 0.1        ; Make it smaller
    res@pmLegendOrthogonalPosF = -0.32      ; Move into to plot
    res@pmLegendParallelPosF   =  0.75      ; Move to right
    res@lgPerimOn              = False      ; No legend perimeter.
    res@lgLabelFontHeightF     = 0.01
    res@tiMainString=title        ; add title
    x=ispan(1,ntime,1)
    res@trYMinF=42.
    res@trYMaxF=57.

    resL=res
    resR=res

;    resR@xyLineThicknessF = 1.               ; make 2nd lines thicker
;    resL@xyLineThicknessF = 0.2               ; make 2nd lines thicker
      
    resR@xyLineColor           = "red"          ; change line color
    resL@xyLineColor           = "black"          ; change line color
    resR@gsnRightString="[Tg CH4/yr-1]"
    

    plot  = gsn_csm_xy2(wks,x,data(:,0),data(:,1),resL,resR) ; create plot

end



begin
    fn="/Volumes/wrkshr2/m300107/data/experiments/methane/holocene/Cbalone.001001-6999_avg_agg_ch4_emission_ym_2d.nc"
    do_ch4_2d(fn, "Holocene annual mean", "holo_ch4_2d")
    fn="/Volumes/wrkshr2/m300107/data/experiments/methane/eemian/Cbalone.001001-1999_avg_agg_ch4_emission_ym_2d.nc"
    do_ch4_2d(fn, "Eemian annual mean", "eemian_ch4_2d")
    fn="/Volumes/wrkshr2/m300107/data/experiments/methane/holocene/Cbalone_avg_agg_ch4_emission_ym_2d.diff.nc"
    do_ch4_2d_diff(fn, "CH4 emissions: 6K-125K", "diff_holo-eemian_ch4_2d")


;    fn="/Volumes/wrkshr2/m300107/data/experiments/methane/eemian/Cbalone.001001-1999_avg_agg_ch4_emission_1d.nc"
;    do_ch4_1d (fn,"Eemian: global annual CH4 emissions","eemian_ch4_1d")
;
;    fn="/Volumes/wrkshr2/m300107/data/experiments/methane/holocene/Cbalone.001001-6999_avg_agg_ch4_emission_1d.nc"
;    do_ch4_1d (fn,"Holocene: global annual CH4 emissions","holocene_ch4_1d")
end
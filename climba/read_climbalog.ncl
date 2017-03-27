load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

   exp=new(8,string)
   exp(0)="climba_Tra8-0k"
   exp(1)="climba_Tra8-0k_12T"
   exp(2)="climba_Tra8-0k_noB"
   exp(3)="climba_Tra8-0k_P"
   exp(4)="climba_Tra8-0k_noL"
   exp(5)="climba_Tra8-0k_K"
   exp(6)="climba_Tra8-0k_S"
   exp(7)="climba_Tra8-0k_noO"

   ncolco2 = 6
   ncolcland = 16
   headcland = 1
   headco2 = 0


   pathin="~/"
   ; get data - loop over all experiments
   ; define filenames
   do iexp=0,7
      stam=exp(iexp)
      co2file="~/forcinglogs/"+stam+".jsbachforcing"
      clandfile="~/forcinglogs/"+stam+".climberforcing"


      ;read full data into string and convert afterwards
      dataco2 = asciiread(co2file,-1,"string")
      ncolumnsco2 = str_fields_count(dataco2(1)," ")
      nlinesco2 = dimsizes(dataco2)
      print(clandfile + " -- number of co2 columns = " + ncolumnsco2)
      print(clandfile + " -- number of co2 lines   = " + nlinesco2)


      datacland = asciiread(clandfile,-1,"string")
      ncolumnscland = str_fields_count(datacland(1)," ")
      nlinescland = dimsizes(datacland)
      print(co2file + " -- number of cland columns = " + ncolumnscland)
      print(clandfile + " -- number of cland lines = " + nlinescland)


      ; Skip first row of "data" because it's just a header line.
      ; Use a space (" ") as a delimiter in str_get_field. The first
      ; field is field=1 (unlike str_get_cols, in which the first column
      ; is column=0).
      ;
      cland = new(nlinescland,float)
      dcland = new(nlinescland,float)
      co2 = new(nlinesco2,float)
      ; printVarSummary(dcland)
      ; printVarSummary(cland)
      ; printVarSummary(co2)
      cland  = stringtofloat(str_get_field(datacland(0::), 16," "))
      dcland = stringtofloat(str_get_field(datacland(0::), 11," "))
      co2 = stringtofloat(str_get_field(dataco2(0::), 6," "))
      
      

      ;  print (dcland)

      delete (cland)
      delete (dcland)
      delete (co2)
   end do 

   ;************************************************
   ; plotting parameters
   ;************************************************
   wks   = gsn_open_wks ("pdf","xy")                  ; open workstation

   res                   = True                      ; plot mods desired
   res@tiMainString      = "TLC"        ; add title
   res@trYMinF = 3000.
   ; note a similiar resource is xyLineThicknessF, which will effect all
   ; the lines in the array.
   res@xyLineThicknesses = (/1.0,2.0/)               ; make 2nd lines thicker

   res@xyLineColors           = (/"blue","red","green","orange","brown","cyan","yellow","black"/)          ; change line color
   res@xyExplicitLegendLabels = (/"1st","12T","noB","P","noL","K","S","noO"/)

   res@pmLegendDisplayMode    = "Always"   ; Display a legend.
   res@pmLegendWidthF         = 0.2        ; Make it smaller
   res@pmLegendHeightF        = 0.1        ; Make it smaller
   res@pmLegendOrthogonalPosF = -0.32      ; Move into to plot
   res@pmLegendParallelPosF   =  0.75      ; Move to right
   res@lgPerimOn              = False      ; No legend perimeter.
   res@lgLabelFontHeightF     = 0.01

   ; just print 1000yr steps
   times=tlc2&time/10000

   ; plot  = gsn_csm_xy (wks,tlc2&time,data,res) ; create plot
   plot  = gsn_csm_xy (wks,times,data,res) ; create plot

;
end
   
   

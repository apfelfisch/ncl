load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

   experiment=new(9,string)
   experiment(0)="climba_Tra8-0k"
   experiment(1)="climba_Tra8-0k_12T"
   experiment(2)="climba_Tra8-0k_noB"
   experiment(3)="climba_Tra8-0k_P"
   experiment(4)="climba_Tra8-0k_noL"
   experiment(5)="climba_Tra8-0k_K"
   experiment(6)="climba_Tra8-0k_S"
   experiment(7)="climba_Tra8-0k_noO"
   experiment(8)="climba_Tra8-0k_V2"

   ncolco2 = 6
   ncolcland = 16
   headcland = 1
   headco2 = 0


   
   arch = systemfunc("uname")
   print(arch)
   if ( arch .eq. "Darwin" )  then
      path="~/Desktop/climba/forcinglogs/"
   else
      path="/work/mj0060/m300107/scripts/climba/Tra8-0k/"+stam+"/scripts/"
   end if
   
   print(arch+" ---- " + path)

   ; get data - loop over all experiments
   ; define filenames

   dataset=new((/4,9,8000/),float)
   
   do iexperiment=0,8
      stam=experiment(iexperiment)


      co2file=path+stam+".jsbachforcing"
      clandfile=path+stam+".climberforcing"
      print(co2file)
      print(clandfile)



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
      
      dataset(0,iexperiment,0:nlinescland-1)=cland(0:nlinescland-1)
      dataset(1,iexperiment,0:nlinescland-1)=dcland(0:nlinescland-1)
      dataset(2,iexperiment,0:nlinesco2-1)=co2(0:nlinesco2-1)
      
      ;  print (dcland)

      delete (cland)
      delete (dcland)
      delete (co2)
      delete (dataco2)
      delete (datacland)
      
   end do 

   ;************************************************
   ; plotting parameters
   ;************************************************
   wks   = gsn_open_wks ("pdf","xy")                  ; open workstation

   res                   = True                      ; plot mods desired
   
      ; note a similiar resource is xyLineThicknessF, which will effect all
      ; the lines in the array.
      res@xyLineThicknesses = (/1.0,2.0/)               ; make 2nd lines thicker
      
      res@xyLineColors           = (/"blue","red","green","orange","brown","cyan","yellow","black","pink"/)          ; change line color
      res@xyExplicitLegendLabels = (/"1st","12T","noB","P","noL","K","S","noO","1stV2"/)
      
      res@pmLegendDisplayMode    = "Always"   ; Display a legend.
      res@pmLegendWidthF         = 0.2        ; Make it smaller
      res@pmLegendHeightF        = 0.1        ; Make it smaller
      res@pmLegendOrthogonalPosF = -0.32      ; Move into to plot
      res@pmLegendParallelPosF   =  0.75      ; Move to right
      res@lgPerimOn              = False      ; No legend perimeter.
      res@lgLabelFontHeightF     = 0.01
   
   ; just print 1000yr steps
   ;times=tlc2&time/10000

   ; plot  = gsn_csm_xy (wks,tlc2&time,data,res) ; create plot
;   plot  = gsn_csm_xy (wks,times,data,res) ; create plot

    rescland=res
    rescland@tiMainString      = ("total land carbon")        ; add title
;    rescland@trYMinF = 3150.
    resdcland=res
    resdcland@tiMainString      = ("yearly fluxes of land C-emissions")        ; add title
    resdcland@trYMinF = -6.
    resdcland@trYMaxF = 6.
    resco2=res
    resco2@tiMainString      = ("CO2")        ; add title

    
    resdco2=res
    resdco2@tiMainString      = ("change in CO2 since 8Ka BP")        ; add title
     
    plot = gsn_csm_y(wks,dataset(0,:,:),rescland)
    plot = gsn_csm_y(wks,dataset(1,:,:),resdcland)
    plot = gsn_csm_y(wks,dataset(2,:,:),resco2)
    dataset(3,:,:)=dataset(2,:,:)-260.41
    plot = gsn_csm_y(wks,dataset(3,:,:),resdco2)
    







;
end
   
   

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

begin

   experiment=new(8,string)
   experiment(0)="climba_Tra8-0k"
   experiment(1)="climba_Tra8-0k_12T"
   experiment(2)="climba_Tra8-0k_noB"
   experiment(3)="climba_Tra8-0k_P"
   experiment(4)="climba_Tra8-0k_noL"
   experiment(5)="climba_Tra8-0k_K"
   experiment(6)="climba_Tra8-0k_S"
   experiment(7)="climba_Tra8-0k_noO"

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

   dataset=new((/3,8,8000/),float)
   
   do iexperiment=0,7
      stam=experiment(iexperiment)

      orbitfile=path+stam+".jsbachforcing"
      print(orbitfile)

      ;read full data into string and convert afterwards
      dataorbit = asciiread(orbitfile,-1,"string")
      ncolumnsorbit = str_fields_count(dataorbit(1)," ")
      nlinesorbit   = dimsizes(dataorbit)
      print(orbitfile + " -- number of orbit columns = " + ncolumnsorbit)
      print(orbitfile + " -- number of orbit lines   = " + nlinesorbit)


      ; Skip first row of "data" because it's just a header line.
      ; Use a space (" ") as a delimiter in str_get_field. The first
      ; field is field=1 (unlike str_get_cols, in which the first column
      ; is column=0).
      ;
      exc = new(nlinesorbit,float)
      per = new(nlinesorbit,float)
      lon = new(nlinesorbit,float)
      ; printVarSummary(dcland)
      ; printVarSummary(cland)
      ; printVarSummary(co2)
      exc = stringtofloat(str_get_field(dataorbit(0::), 3," "))
      obl = stringtofloat(str_get_field(dataorbit(0::), 4," "))
      per = stringtofloat(str_get_field(dataorbit(0::), 5," "))
      
      dataset(0,iexperiment,0:nlinesorbit-1)=exc(0:nlinesorbit-1)
      dataset(1,iexperiment,0:nlinesorbit-1)=obl(0:nlinesorbit-1)
      dataset(2,iexperiment,0:nlinesorbit-1)=per(0:nlinesorbit-1)

      ;  print (dcland)

      delete (exc)
      delete (obl)
      delete (per)
      delete (dataorbit)
      
   end do 

   ;************************************************
   ; plotting parameters
   ;************************************************
   wks   = gsn_open_wks ("pdf","xy")                  ; open workstation

   res                   = True                      ; plot mods desired
   
      ; note a similiar resource is xyLineThicknessF, which will effect all
      ; the lines in the array.
      res@xyLineThicknesses = (/1.0,2.0/)               ; make 2nd lines thicker
      
      res@xyLineColors           = (/"blue","red","green"/)          ; change line color
      res@xyExplicitLegendLabels = (/"exc","obl","per"/)
      
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

    resexc=res
    resexc@tiMainString      = ("excentricity")        ; add title
;    rescland@trYMinF = 3150.
    resobl=res
    resobl@tiMainString      = ("obliquity")        ; add title
;    resdcland@trYMinF = -6.
;    resdcland@trYMaxF = 6.
    resper=res
    resper@tiMainString      = ("perihelion")        ; add title
    
    plot = gsn_csm_y(wks,dataset(0,:,:),resexc)
    plot = gsn_csm_y(wks,dataset(1,:,:),resobl)
    plot = gsn_csm_y(wks,dataset(2,:,:),resper)





;
end
   
   

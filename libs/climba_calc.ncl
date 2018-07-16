load "/usr/share/ncarg/nclscripts/csm/gsn_code.ncl"
load "/usr/share/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/usr/share/ncarg/nclscripts/csm/contributed.ncl"
load "/usr/share/ncarg/nclscripts/csm/shea_util.ncl"


;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
;load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"

LIBPATH="/scratch/local1/tbruecher/git/ncl/libs/"
;LIBPATH="/Users/tbruecher/Documents/scripts/plot/ncl/libs/"


; constants
MyFillValue=-9e+33


undef ("island")
function island(res:string,lon,lat:float)
local bisland
begin
    bisland=True
    return (bisland)
end


undef ("get_lons")
; function get_lons (res:string,lon1,lon2:float)
; begin
;     lat1=10.
;     lat2=20.
;     areafilename=LIBPATH+"area_"+res+".nc"
;     areafile=addfile(areafilename,"r")
;     lon1d=areafile->lon
;     lat1d=areafile->lat
;     nlon=dimsizes(lon1d)
;     nlat=dimsizes(lat1d)
;
;
;
;     lon2d=conform_dims((/nlat,nlon/),lon1d,1)
;     lat2d=conform_dims((/nlat,nlon/),lat1d,0)
;     lon=(/lon1,lon2/)
;     lat=(/lat1,lat2/)
;     yx=getind_latlon2d(lat2d,lon2d,lat,lon)
;
;     if ( yx(0,1) .gt. yx(1,1) ) then
;         x1=dimsizes(ispan(yx(0,1),nlon-1,1))
;         x2=dimsizes(ispan(0,yx(1,1),1))
;         lons=new(x1+x2,integer)
;         lons(0:x1-1)=ispan(yx(0,1),nlon-1,1)
;         lons(x1:x1+x2-1)=ispan(0,yx(1,1),1)
;     else
; 		if ( yx(0,1) .eq. yx(1,1) ) then
; 	        lons=ispan(0,nlon-1,1)
; 	    else
; 	        x1=dimsizes(ispan(yx(0,1),yx(1,1),1))
; 	        lons=new(x1,integer)
; 	        lons(0:x1-1)=ispan(yx(0,1),yx(1,1),1)
; 	    end if
;     end if
; ;    print (lon1d(lons))
; ;    print(lons)
;     return (lons)
; end

function get_lons (res:string,lon1,lon2:float)
begin
    lat1=10.
    lat2=20.
    areafilename=LIBPATH+"area_"+res+".nc"
    areafile=addfile(areafilename,"r")
    lon1d=areafile->lon ;({lon1:lon2})
	print(lon1d)
	printVarSummary(lon1d)


    lat1d=areafile->lat



    nlon=dimsizes(lon1d)
    nlat=dimsizes(lat1d)



    lon2d=conform_dims((/nlat,nlon/),lon1d,1)
    lat2d=conform_dims((/nlat,nlon/),lat1d,0)

	print(lon1+"  "+lon2)
	nm = getind_latlon2d (lat2d,lon2d, (/0,0/), (/lon1,lon2/))
	print(nm)

	lons=ispan(nm(0,1),nm(1,1),1)

;     lon=(/lon1,lon2/)
;     lat=(/lat1,lat2/)
;
;     yx=getind_latlon2d(lat2d,lon2d,lat,lon)
;
;     if ( yx(0,1) .gt. yx(1,1) ) then
;         x1=dimsizes(ispan(yx(0,1),nlon-1,1))
;         x2=dimsizes(ispan(0,yx(1,1),1))
;         lons=new(x1+x2,integer)
;         lons(0:x1-1)=ispan(yx(0,1),nlon-1,1)
;         lons(x1:x1+x2-1)=ispan(0,yx(1,1),1)
;     else
; 		if ( yx(0,1) .eq. yx(1,1) ) then
; 	        lons=ispan(0,nlon-1,1)
; 	    else
; 	        x1=dimsizes(ispan(yx(0,1),yx(1,1),1))
; 	        lons=new(x1,integer)
; 	        lons(0:x1-1)=ispan(yx(0,1),yx(1,1),1)
; 	    end if
;     end if
; ;    print (lon1d(lons))
    print(lons)
    return (lons)
end





undef ("get_slm")
function get_slm(opt:logical)
begin
    fn=LIBPATH+"sea_land_mask_"+opt@res+".nc"
    slmfile=addfile(fn,"r")
    dims=dimsizes(slmfile->slm(0,:,:))
    nlon=dims(1)
    nlat=dims(0)

; full 2d
    tmp_slm=slmfile->slm(0,:,:)

    if (isatt(opt,"lon1") .and. isatt(opt,"lon2") .and. isatt(opt,"lat1")  .and. isatt(opt,"lat2")) then
        if ( opt@lon1 .lt. 0) then
            tmp_slm=lonFlip(tmp_slm)
        end if
        slm=tmp_slm({opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    else
        slm=slmfile->slm(0,:,:)
    end if
    slm@_FillValue=MyFillValue
    if ( opt@land .eq. False ) then
        slm=where(slm .eq. 1,MyFillValue,slm)
    end if
    if ( opt@sea .eq. False ) then
        slm=where(slm .eq. 0,MyFillValue,slm)
    end if
    return (slm)
end




undef ("get_ttest_sig_1d")
function get_ttest_sig_1d (ts1,ts2:numeric)
begin
      ;detrend first
      ;ts1=dtrend(ts1,False)
      ;ts2=dtrend(ts2,False)
      aveX = avg (ts1)
      aveY = avg (ts2)
      varX = variance (ts1)
      varY = variance (ts2)
      sX   = dimsizes (ts1)        ; X and Y can be of
      sY   = dimsizes (ts2)        ; different sizes
      iflag= False               ; population variance similar
      prob = ttest(aveX,varX,sX, aveY,varY,sY, iflag, False)
      return prob
end



undef ("get_ttest_sig_2d")
function get_ttest_sig_2d (x,y:numeric)
begin
      dimXY = dimsizes(x)
      ntime  = dimXY(0)
      nlat  = dimXY(1)
      nlon  = dimXY(2)

      xAve = dim_avg_n_Wrap(x,0)              ; calculate means at each grid point
      yAve = dim_avg_n_Wrap(y,0)              ; calculate means at each grid point
      xVar = dim_variance_n_Wrap(x,0)         ; calculate variances
      yVar = dim_variance_n_Wrap(y,0)



      iflag= False                        ; population variance similar
      prob = ttest(xAve,xVar,ntime,yAve,yVar,ntime, iflag, False)
      return prob
end


undef ("get_ttest_sig_3d")
function get_ttest_sig_3d (ts1,ts2:float)
begin
      ;detrend first
      ;ts1=dtrend_leftdim(ts1,False) ; ts1 3d time lat lon
      ;ts2=dtrend_leftdim(ts2,False)
      ;loop over the first dimension
      dims=dimsizes(ts1)

      ntime=dims(0)
      nlev=dims(1)
      nlat=dims(2)
      nlon=dims(3)

      prob=new((/nlev,nlat,nlon/),float,MyFillValue)
      do ilev=0,nlev-1
         prob(ilev,:,:) = get_ttest_sig_2d(ts1(:,ilev,:,:),ts2(:,ilev,:,:))
      end do
      return prob
end


undef ("convert_prec")
function convert_prec (prec:float,conversion:string)

begin
   if ( conversion .eq. "kg/m**2s-mm/yr" )  then
	   prec=prec * 86400. * 365.25
	   prec@units="mm/yr"
   else if (conversion .eq. "kg/m**2s-mm/month") then
	   prec = prec * 86400. * 365.25/12.
	   prec@units="mm/month"
	else if (conversion .eq. "kg/m**2s-mm/d") then
		prec = prec * 86400.
		prec@units = "mm/d"
	else if (conversion .eq. "" ) then
		print("keep unit of prec: " + prec@units)
	end if
   end if
   end if
   end if
;   printVarSummary (prec)
   return (prec)
end



undef ("get_area")
function get_area (res:string,lon1,lon2,lat1,lat2:float)
local res,areafilename,areafile,area2d
begin
    ; res=T31 T63 ...
    print("areafile: "+res)
    areafilename=LIBPATH+"area_"+res+".nc"
    areafile=addfile(areafilename,"r")
    tmp_area=areafile->cell_area
    if (lon1 .lt. 0 ) then
        tmp_area=lonFlip(tmp_area)
    end if
    area2d = tmp_area({lat1:lat2},{lon1:lon2})
    return area2d
end



undef ("get_area_land")
function get_area_land (res:string,lon1,lon2,lat1,lat2:float)
local res,areafilename,areafile,area2d
begin
    ; res=T31 T63 ...
    areafilename=LIBPATH+"area_land_"+res+".nc"
    areafile=addfile(areafilename,"r")

    tmp_area=areafile->cell_area
    if (lon1 .lt. 0 ) then
        tmp_area=lonFlip(tmp_area)
    end if
    area2d = tmp_area({lat1:lat2},{lon1:lon2})
   return area2d
end




undef ("get_GCD_region")
function get_GCD_region ()
begin
    regionfilename=LIBPATH+"GCD_regionsdef_T31.nc"
    regionfile=addfile(regionfilename,"r")
    regions=regionfile->gcd_region
    return regions
end




;*******************************************************************************
; HISTORY:
;   20-11-12 Tim Bruecher.
;     * General implementation to get carbon-pool data out of veg-stream
;     * taking the veg-stream and calculate carbon pools (total, soil, green) and GPP
;       in 2d and calculate global sums
;*******************************************************************************

undef ("get_cpools")
function get_cpools (opt:logical) ;(fn,res:string,lon1,lon2,lat1,lat2:float)
local boxC_reserve2d,boxC_green2d,boxC_woods2d,box_GPP_yDayMean2d,box_Cpools_total2d,total2d,soil2d,green2d,gpp2d,total1d,soil1d,green1d,gpp1d,dims,nlon,nlat,cpools
begin

    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->box_Cpools_total(:,:,:))
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("time period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

   ;full tmp 4d
   if (opt@time4d .eq. True) then
      tmp_reserve3d=dim_sum_n_Wrap(data->boxC_reserve(fidx:lidx,:,:,:),1)
      tmp_green3d=dim_sum_n_Wrap(data->boxC_green(fidx:lidx,:,:,:),1)
      tmp_woods3d=dim_sum_n_Wrap(data->boxC_woods(fidx:lidx,:,:,:),1)
      tmp_GPP3d=dim_sum_n_Wrap(data->box_GPP_yDayMean(fidx:lidx,:,:,:),1)
      tmp_cpoolst3d=data->box_Cpools_total(fidx:lidx,:,:)
   else
      tmp_reserve3d=dim_sum_n_Wrap(data->boxC_reserve(fidx:lidx,:,:,:),1)
      tmp_green3d=dim_sum_n_Wrap(data->boxC_green(fidx:lidx,:,:,:),1)
      tmp_woods3d=dim_sum_n_Wrap(data->boxC_woods(fidx:lidx,:,:,:),1)
      tmp_GPP3d=dim_sum_n_Wrap(data->box_GPP_yDayMean(fidx:lidx,:,:,:),1)
      tmp_cpoolst3d=data->box_Cpools_total(fidx:lidx,:,:)
   end if


   if (opt@lon1 .lt. 0) then
        tmp_reserve3d=lonFlip(tmp_reserve3d)
        tmp_green3d=lonFlip(tmp_green3d)
        tmp_woods3d=lonFlip(tmp_woods3d)
        tmp_GPP3d=lonFlip(tmp_GPP3d)
        tmp_cpoolst3d=lonFlip(tmp_cpoolst3d)
   end if

   ;full tmp 3d
   tmp_reserve2d=dim_avg_n_Wrap(tmp_reserve3d,0)
   tmp_green2d=dim_avg_n_Wrap(tmp_green3d,0)
   tmp_woods2d=dim_avg_n_Wrap(tmp_woods3d,0)
   tmp_GPP2d=dim_avg_n_Wrap(tmp_GPP3d,0)
   tmp_cpoolst2d=dim_avg_n_Wrap(tmp_cpoolst3d,0)




   boxC_reserve3d     = tmp_reserve3d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   boxC_green3d       = tmp_green3d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   boxC_woods3d       = tmp_woods3d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   box_GPP_yDayMean3d = tmp_GPP3d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   box_Cpools_total3d = tmp_cpoolst3d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})

   boxC_reserve2d     = dim_avg_n_Wrap(boxC_reserve3d,0)
   boxC_green2d       = dim_avg_n_Wrap(boxC_green3d,0)
   boxC_woods2d       = dim_avg_n_Wrap(boxC_woods3d,0)
   box_GPP_yDayMean2d = dim_avg_n_Wrap(box_GPP_yDayMean3d,0)
   box_Cpools_total2d = dim_avg_n_Wrap(box_Cpools_total3d,0)



   delete (dims)
   dims=dimsizes(box_Cpools_total3d)
   ntimes=dims(0)
   nlat=dims(1)
   nlon=dims(2)

   total3d = box_Cpools_total3d
   soil3d  = box_Cpools_total3d-boxC_reserve3d-boxC_green3d-boxC_woods3d
   green3d = boxC_reserve3d+boxC_green3d+boxC_woods3d
   gpp3d   = box_GPP_yDayMean3d


   total2d = box_Cpools_total2d
   soil2d  = box_Cpools_total2d-boxC_reserve2d-boxC_green2d-boxC_woods2d
   green2d = boxC_reserve2d+boxC_green2d+boxC_woods2d
   gpp2d   = box_GPP_yDayMean2d


   area=get_area(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
;1d
   total1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(total2d*area)))
   soil1d  = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(soil2d*area)))
   green1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(green2d*area)))
   gpp1d   = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(gpp2d*area)))*3600*24*365.25


   if (opt@time4d .eq. True) then
      cpools=new((/ntimes,8,nlat,nlon/),float,MyFillValue)
      cpools!0="time"
      cpools!1="cpools"
      cpools!2="lat"
      cpools!3="lon"
      cpools&lat=box_Cpools_total2d&lat
      cpools&lon=box_Cpools_total2d&lon
      cpools&lat@units=box_Cpools_total2d&lat@units
      cpools&lon@units=box_Cpools_total2d&lon@units


      cpools(:,0,:,:)=0.012 * total3d
      cpools(:,1,:,:)=0.012 * soil3d
      cpools(:,2,:,:)=0.012 * green3d
      cpools(:,3,:,:)=0.012 * 3600*24*365.25 * gpp3d
      cpools(:,4,:,:)=doubletofloat(total1d)
      cpools(:,5,:,:)=doubletofloat(soil1d)
      cpools(:,6,:,:)=doubletofloat(green1d)
      cpools(:,7,:,:)=doubletofloat(gpp1d)

   else
      cpools=new((/8,nlat,nlon/),float,MyFillValue)
      cpools!0="cpools"
      cpools!1="lat"
      cpools!2="lon"
      cpools&lat=box_Cpools_total2d&lat
      cpools&lon=box_Cpools_total2d&lon
      cpools&lat@units=box_Cpools_total2d&lat@units
      cpools&lon@units=box_Cpools_total2d&lon@units

      cpools(0,:,:)=0.012 * total2d
      cpools(1,:,:)=0.012 * soil2d
      cpools(2,:,:)=0.012 * green2d
      cpools(3,:,:)=0.012 * 3600*24*365.25 * gpp2d
      cpools(4,:,:)=doubletofloat(total1d)
      cpools(5,:,:)=doubletofloat(soil1d)
      cpools(6,:,:)=doubletofloat(green1d)
      cpools(7,:,:)=doubletofloat(gpp1d)
   end if
   return cpools
end


;undef ("get_cpools_ts")
;function get_cpools_ts (opt:logical) ;(fn,res:string,lon1,lon2,lat1,lat2:float)
;local boxC_reserve2d,boxC_green2d,boxC_woods2d,box_GPP_yDayMean2d,box_Cpools_total2d,total2d,soil2d,green2d,gpp2d,total1d,soil1d,green1d,gpp1d,dims,nlon,nlat,cpools
;begin
;
;    if (opt@fn.eq."") then
;        print("no filename set! EXIT")
;        exit ;;
;    end if
;    data=addfile(opt@fn, "r")
;
;    dims=dimsizes(data->box_Cpools_total(:,:,:))
;    ntimes=dims(0)
;    nlat=dims(1)
;    nlon=dims(2)
;
;    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
;        fidx=opt@fidx
;        lidx=opt@lidx
;        print("averaging period from: "+fidx+" to "+lidx)
;    else
;        print("taking all timesteps")
;        fidx=0
;        lidx=ntimes-1
;    end if
;
;;full tmp 2d
;    tmp_reserve2d=dim_sum_n_Wrap(data->boxC_reserve(fidx:lidx,:,:,:),1)
;    tmp_green2d=dim_sum_n_Wrap(data->boxC_green(fidx:lidx,:,:,:),1)
;    tmp_woods2d=dim_sum_n_Wrap(data->boxC_woods(fidx:lidx,:,:,:),1)
;    tmp_GPP2d=dim_sum_n_Wrap(data->box_GPP_yDayMean(fidx:lidx,:,:,:),1)
;    tmp_cpoolst2d=data->box_Cpools_total(fidx:lidx,:,:)
;    tmp_NPP2d=dim_sum_n_Wrap(data->box_NPP_yDayMean(fidx:lidx,:,:,:) ,1)
;
;
;
;    if (opt@lon1 .lt. 0) then
;        tmp_reserve2d=lonFlip(tmp_reserve2d)
;        tmp_green2d=lonFlip(tmp_green2d)
;        tmp_woods2d=lonFlip(tmp_woods2d)
;        tmp_GPP2d=lonFlip(tmp_GPP2d)
;        tmp_cpoolst2d=lonFlip(tmp_cpoolst2d)
;        tmp_NPP2d=lonFlip(tmp_NPP2d)
;     end if
;
;    boxC_reserve2d     = tmp_reserve2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
;    boxC_green2d       = tmp_green2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
;    boxC_woods2d       = tmp_woods2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
;    box_GPP_yDayMean2d = tmp_GPP2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
;    box_Cpools_total2d = tmp_cpoolst2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
;    box_NPP_yDayMean2d = tmp_NPP2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
;
;
;
;   delete (dims)
;   dims=dimsizes(box_Cpools_total2d)
;   ntime=dims(0)
;   nlat=dims(1)
;   nlon=dims(2)
;
;   total2d = box_Cpools_total2d
;   soil2d  = box_Cpools_total2d-boxC_reserve2d-boxC_green2d-boxC_woods2d
;   green2d = boxC_reserve2d+boxC_green2d+boxC_woods2d
;   gpp2d   = box_GPP_yDayMean2d
;   npp2d   = box_NPP_yDayMean2d
;
;   area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
;   carea=conform_dims((/ntime,nlat,nlon/),area,(/1,2/))
;
;   ;1d
;   total1d = 1e-15*12.011*(dim_sum_n_Wrap(total2d*carea,(/1,2/)))
;   soil1d  = 1e-15*12.011*(dim_sum_n_Wrap(soil2d*carea,(/1,2/)))
;   green1d = 1e-15*12.011*(dim_sum_n_Wrap(green2d*carea,(/1,2/)))
;   gpp1d   = 1e-15*12.011*(dim_sum_n_Wrap(gpp2d*carea,(/1,2/)))*3600*24*365.25
;   npp1d   = 1e-15*12.011*(dim_sum_n_Wrap(npp2d*carea,(/1,2/)))*3600*24*365.25
;
;
;   cpools=new((/5,ntime/),float,MyFillValue)
;   cpools!0="cpools"
;   cpools!1="time"
;   cpools&time=data->time
;   cpools(0,:)=doubletofloat(total1d)
;   cpools(1,:)=doubletofloat(soil1d)
;   cpools(2,:)=doubletofloat(green1d)
;   cpools(3,:)=doubletofloat(gpp1d)
;   cpools(4,:)=doubletofloat(npp1d)
;   return cpools
;end

undef ("get_cpoolsYasso")
function get_cpoolsYasso (opt:logical) ;(fn,res:string,lon1,lon2,lat1,lat2:float)

begin

    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->pseudo_precip_yDay(:,:,:))
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("time period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

   ;full tmp 4d
 ;  if (opt@time4d .eq. True) then
         tmp_boxYC_acid_bg1=dim_sum_n_Wrap(data->boxYC_acid_bg1(fidx:lidx,:,:,:),1)

       	 tmp_boxYC_water_ag1=dim_sum_n_Wrap(data->boxYC_water_ag1(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_water_bg1=dim_sum_n_Wrap(data->boxYC_water_bg1(fidx:lidx,:,:,:),1)

       	 tmp_boxYC_ethanol_ag1=dim_sum_n_Wrap(data->boxYC_ethanol_ag1(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_ethanol_bg1=dim_sum_n_Wrap(data->boxYC_ethanol_bg1(fidx:lidx,:,:,:),1)

       	 tmp_boxYC_nonsoluble_ag1=dim_sum_n_Wrap(data->boxYC_acid_bg1(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_nonsoluble_bg1=dim_sum_n_Wrap(data->boxYC_nonsoluble_bg1(fidx:lidx,:,:,:),1)

       	 tmp_boxYC_humus_1=dim_sum_n_Wrap(data->boxYC_humus_1(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_acid_ag2=dim_sum_n_Wrap(data->boxYC_acid_ag2(fidx:lidx,:,:,:),1)

       	 tmp_boxYC_acid_bg2=dim_sum_n_Wrap(data->boxYC_acid_bg2(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_water_ag2=dim_sum_n_Wrap(data->boxYC_water_ag2(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_water_bg2=dim_sum_n_Wrap(data->boxYC_water_bg2(fidx:lidx,:,:,:),1)

       	 tmp_boxYC_ethanol_ag2=dim_sum_n_Wrap(data->boxYC_ethanol_ag2(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_ethanol_bg2=dim_sum_n_Wrap(data->boxYC_ethanol_bg2(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_nonsoluble_ag2=dim_sum_n_Wrap(data->boxYC_nonsoluble_ag2(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_nonsoluble_bg2=dim_sum_n_Wrap(data->boxYC_nonsoluble_bg2(fidx:lidx,:,:,:),1)
       	 tmp_boxYC_humus_2=dim_sum_n_Wrap(data->boxYC_humus_2(fidx:lidx,:,:,:),1)


         tmp_YC_ag=tmp_boxYC_water_ag1
         tmp_YC_ag=tmp_YC_ag+tmp_boxYC_ethanol_ag1+tmp_boxYC_nonsoluble_ag1+tmp_boxYC_humus_1+tmp_boxYC_acid_ag2+tmp_boxYC_water_ag2+tmp_boxYC_ethanol_ag2+tmp_boxYC_nonsoluble_ag2+tmp_boxYC_humus_2
         tmp_YC_bg=tmp_boxYC_acid_bg1
         tmp_YC_bg=tmp_YC_bg+tmp_boxYC_water_bg1+tmp_boxYC_ethanol_bg1+tmp_boxYC_nonsoluble_bg1+tmp_boxYC_acid_bg2+tmp_boxYC_water_bg2+tmp_boxYC_ethanol_bg2+tmp_boxYC_nonsoluble_bg2

         tmp_YC_total=tmp_YC_ag
         tmp_YC_total=tmp_YC_total+tmp_YC_bg


         printVarSummary (tmp_YC_ag)
         printVarSummary (tmp_YC_bg)
         printVarSummary (tmp_YC_total)


;   else
;      tmp_reserve3d=dim_sum_n_Wrap(data->boxC_reserve(fidx:lidx,:,:,:),1)
;      tmp_green3d=dim_sum_n_Wrap(data->boxC_green(fidx:lidx,:,:,:),1)
;      tmp_woods3d=dim_sum_n_Wrap(data->boxC_woods(fidx:lidx,:,:,:),1)
;      tmp_GPP3d=dim_sum_n_Wrap(data->box_GPP_yDayMean(fidx:lidx,:,:,:),1)
;      tmp_cpoolst3d=data->box_Cpools_total(fidx:lidx,:,:)
;   end if


   if (opt@lon1 .lt. 0) then
       tmp_YC_ag=lonFlip(tmp_YC_ag)
       tmp_YC_bg=lonFlip(tmp_YC_bg)
       tmp_YC_total=lonFlip(tmp_YC_total)


   end if

   ;lon lat, time mean
;   tmp_YC_ag3d=dim_avg_n_Wrap(tmp_YC_ag,0)
;   tmp_YC_bg3d=dim_avg_n_Wrap(tmp_YC_bg,0)
;   tmp_YC_total3d=dim_avg_n_Wrap(tmp_YC_total,0)


   ; area: time lon lat: out of input
   boxC_YC_ag3d   = tmp_YC_ag(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   boxC_YC_bg3d   = tmp_YC_bg(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   boxC_YC_total3d= tmp_YC_total(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   ; lon lat time mean
   boxC_YC_ag2d   = dim_avg_n_Wrap(boxC_YC_ag3d,0)
   boxC_YC_bg2d   = dim_avg_n_Wrap(boxC_YC_bg3d,0)
   boxC_YC_total2d= dim_avg_n_Wrap(boxC_YC_total3d,0)


   delete (dims)
   dims=dimsizes(boxC_YC_total3d)
   ntimes=dims(0)
   nlat=dims(1)
   nlon=dims(2)


   area=get_area(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
   printVarSummary(area)
   printVarSummary(boxC_YC_total2d)
;1d
   total1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(boxC_YC_total2d*area)))
   bg1d  = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(boxC_YC_bg2d*area)))
   ag1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(boxC_YC_ag2d*area)))
  ; gpp1d   = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(gpp2d*area)))*3600*24*365.25


   if (opt@time4d .eq. True) then
      cpools=new((/ntimes,8,nlat,nlon/),float,MyFillValue)
      cpools!0="time"
      cpools!1="cpools"
      cpools!2="lat"
      cpools!3="lon"
      cpools&lat=box_Cpools_total2d&lat
      cpools&lon=box_Cpools_total2d&lon
      cpools&lat@units=box_Cpools_total2d&lat@units
      cpools&lon@units=box_Cpools_total2d&lon@units


      cpools(:,0,:,:)=0.012 * boxC_YC_total3d
      cpools(:,1,:,:)=0.012 * boxC_YC_bg3d
      cpools(:,2,:,:)=0.012 * boxC_YC_ag3d
      ;cpools(:,3,:,:)=0.012 * 3600*24*365.25 * gpp3d
      cpools(:,4,:,:)=doubletofloat(total1d)
      cpools(:,5,:,:)=doubletofloat(bg1d)
      cpools(:,6,:,:)=doubletofloat(ag1d)
      ;cpools(:,7,:,:)=doubletofloat(gpp1d)

   else
      cpools=new((/8,nlat,nlon/),float,MyFillValue)
      cpools!0="cpools"
      cpools!1="lat"
      cpools!2="lon"
      cpools&lat=box_Cpools_total2d&lat
      cpools&lon=box_Cpools_total2d&lon
      cpools&lat@units=box_Cpools_total2d&lat@units
      cpools&lon@units=box_Cpools_total2d&lon@units

      cpools(0,:,:)=0.012 * boxC_YC_total2d
      cpools(1,:,:)=0.012 * boxC_YC_bg2d
      cpools(2,:,:)=0.012 * boxC_YC_ag2d
      ;cpools(3,:,:)=0.012 * 3600*24*365.25 * gpp2d
      cpools(4,:,:)=doubletofloat(total1d)
      cpools(5,:,:)=doubletofloat(bg1d)
      cpools(6,:,:)=doubletofloat(ag1d)
      ;cpools(7,:,:)=doubletofloat(gpp1d)
   end if
   return cpools
end




undef ("get_npp")
function get_npp (opt:logical) ;(fn,res:string,lon1,lon2,lat1,lat2:float)
local boxC_reserve2d,boxC_green2d,boxC_woods2d,box_GPP_yDayMean2d,box_Cpools_total2d,total2d,soil2d,green2d,gpp2d,total1d,soil1d,green1d,gpp1d,dims,nlon,nlat,cpools
begin

    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->box_Cpools_total(:,:,:))
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("averaging period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

;full tmp 2d
    tmp_NPP2d=data->box_NPP_yDayMean(fidx:lidx,:,:,:)

    if (opt@lon1 .lt. 0) then
        tmp_NPP2d=lonFlip(tmp_NPP2d)
     end if

    box_NPP_yDayMean2d = tmp_NPP2d(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})



   delete (dims)
   dims=dimsizes(box_NPP_yDayMean2d)
   ntime=dims(0)
   nlev=dims(1)
   nlat=dims(2)
   nlon=dims(3)

   npp2d=new((/7,ntime,nlat,nlon/),float,MyFillValue)
   ;total
   npp2d(0,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,0:nlev-1,:,:),1)
   ;woody
   npp2d(1,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,0:5,:,:),1)
   ;grass
   npp2d(2,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,6:7,:,:),1)
   ;pasture
   npp2d(3,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,8:9,:,:),1)
   ;crop
   npp2d(4,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,10:10,:,:),1)
   ;natural
   npp2d(5,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,0:7,:,:),1)
   ;managed
   npp2d(6,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,8:10,:,:),1)


   area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
   size_land=dim_sum(dim_sum(area))
   carea=conform_dims(dimsizes(npp2d),area,(/2,3/))

   ;1d
   npp1d=new((/2,7,ntime/),double,MyFillValue)
   npp1d(0,:,:) = 1e-15*12.011*(dim_sum_n_Wrap(npp2d*carea,(/2,3/)))*3600*24*365.25
   npp1d(1,:,:) = 12.011*dim_sum_n_Wrap(npp2d*carea,(/2,3/))/size_land*3600*24*365.25
   npp1d!0="NPP in [Gt] and [g m-2]"
   npp1d!1="NPP on tiles"
   npp1d!2="time"
   npp1d&time=data->time(fidx:lidx)
   return npp1d
end



undef ("get_npp_ts")
function get_npp_ts (opt:logical) ;(fn,res:string,lon1,lon2,lat1,lat2:float)
local boxC_reserve2d,boxC_green2d,boxC_woods2d,box_GPP_yDayMean2d,box_Cpools_total2d,total2d,soil2d,green2d,gpp2d,total1d,soil1d,green1d,gpp1d,dims,nlon,nlat,cpools
begin

    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->box_Cpools_total(:,:,:))
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("averaging period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

;full tmp 2d
    tmp_NPP2d=data->box_NPP_yDayMean(fidx:lidx,:,:,:)

    if (opt@lon1 .lt. 0) then
        tmp_NPP2d=lonFlip(tmp_NPP2d)
     end if

    box_NPP_yDayMean2d = tmp_NPP2d(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})



   delete (dims)
   dims=dimsizes(box_NPP_yDayMean2d)
   ntime=dims(0)
   nlev=dims(1)
   nlat=dims(2)
   nlon=dims(3)

   npp2d=new((/7,ntime,nlat,nlon/),float,MyFillValue)
   ;total
   npp2d(0,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,0:nlev-1,:,:),1)
   ;woody
   npp2d(1,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,0:5,:,:),1)
   ;grass
   npp2d(2,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,6:7,:,:),1)
   ;pasture
   npp2d(3,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,8:9,:,:),1)
   ;crop
   npp2d(4,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,10:10,:,:),1)
   ;natural
   npp2d(5,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,0:7,:,:),1)
   ;managed
   npp2d(6,:,:,:)   = dim_sum_n_Wrap(box_NPP_yDayMean2d(:,8:10,:,:),1)


   area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
   size_land=dim_sum(dim_sum(area))
   carea=conform_dims(dimsizes(npp2d),area,(/2,3/))

   ;1d
   npp1d=new((/2,7,ntime/),double,MyFillValue)
   npp1d(0,:,:) = 1e-15*12.011*(dim_sum_n_Wrap(npp2d*carea,(/2,3/)))*3600*24*365.25
   npp1d(1,:,:) = 12.011*dim_sum_n_Wrap(npp2d*carea,(/2,3/))/size_land*3600*24*365.25
   npp1d!0="NPP in [Gt] and [g m-2]"
   npp1d!1="NPP on tiles"
   npp1d!2="time"
   npp1d&time=data->time(fidx:lidx)
   return npp1d
end


undef ("")


undef ("get_cpools_total_1d")
function get_cpools_total_1d (fn,res:string,on_tiles:logical,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
begin
    data_reserve=addfile(fn(0), "r")
    data_green=addfile(fn(1), "r")
    data_woods=addfile(fn(2), "r")
    data_total=addfile(fn(3), "r")
    data_gpp=addfile(fn(4), "r")

    ;3d
    ;time lat lon
    lons=get_lons(res,lon1,lon2)
    nlon=dimsizes(data_total->lon(lons))
    nlat=dimsizes(data_total->lat({lat1:lat2}))
    ntime=dimsizes(data_total->time(:))

    area=get_area_land(res,lon1,lon2,lat1,lat2)
    printVarSummary(area)
    printVarSummary(lons)
    print (lons)
    print(data_total->lon(lons(0))+"  "+data_total->lon(lons(nlon-1)))
    print(ntime+" "+nlat+" "+nlon)
    carea=conform_dims((/ntime,nlat,nlon/),area,(/1,2/))

    if ( on_tiles .eq. False ) then
        reserve3d = dim_sum_n_Wrap(data_reserve->boxC_reserve(:,{lat1:lat2},lons)*carea,(/1,2/))
        green3d =   dim_sum_n_Wrap(data_green->boxC_green(:,{lat1:lat2},lons)*carea,(/1,2/))
        woods3d =   dim_sum_n_Wrap(data_woods->boxC_woods(:,{lat1:lat2},lons)*carea,(/1,2/))
        total3d =   dim_sum_n_Wrap(data_total->box_Cpools_total(:,{lat1:lat2},lons)*carea,(/1,2/))
        gpp3d =     dim_sum_n_Wrap(data_gpp->box_GPP_yDayMean(:,{lat1:lat2},lons)*carea,(/1,2/))
    else
        reserve3d = dim_sum_n_Wrap(dim_sum_n_Wrap(data_reserve->boxC_reserve(:,:,{lat1:lat2},lons),1)*carea,(/1,2/))
        green3d =   dim_sum_n_Wrap(dim_sum_n_Wrap(data_green->boxC_green(:,:,{lat1:lat2},lons),1)*carea,(/1,2/))
        woods3d =   dim_sum_n_Wrap(dim_sum_n_Wrap(data_woods->boxC_woods(:,:,{lat1:lat2},lons),1)*carea,(/1,2/))
        total3d =   dim_sum_n_Wrap(data_total->box_Cpools_total(:,{lat1:lat2},lons)*carea,(/1,2/))
        gpp3d =     dim_sum_n_Wrap(dim_sum_n_Wrap(data_gpp->box_GPP_yDayMean(:,:,{lat1:lat2},lons),1)*carea,(/1,2/))
    end if

    if ( runaverage .eq. True ) then
        cpools1d=new((/8,ntime/),float,MyFillValue)
        cpools1d(0,:)=total3d*1e-15*12.011 ;total
        cpools1d(1,:)=runave(cpools1d(0,:),naverage,0); total average
        cpools1d(2,:)=(total3d-reserve3d-green3d-woods3d)*1e-15*12.011 ; soil
        cpools1d(3,:)=runave(cpools1d(2,:),naverage,0) ; soil average
        cpools1d(4,:)=(reserve3d+green3d+woods3d)*1e-15*12.011 ; green
        cpools1d(5,:)=runave(cpools1d(4,:),naverage,0) ; green avereage
        cpools1d(6,:)=gpp3d*3600*24*365.25*1e-15*12.011 ; gpp
        cpools1d(7,:)=runave(cpools1d(6,:),naverage,0) ; gpp average
    else
        cpools1d=new((/8,ntime/),float,MyFillValue)
        cpools1d(0,:)=total3d*1e-15*12.011 ;total
        cpools1d(1,:)=(total3d-reserve3d-green3d-woods3d)*1e-15*12.011 ; soil
        cpools1d(2,:)=(reserve3d+green3d+woods3d)*1e-15*12.011 ; green
        cpools1d(3,:)=gpp3d*3600*24*365.25*1e-15*12.011 ; gpp
    end if

    return cpools1d
end


undef ("get_cpools_total_1d_short")
function get_cpools_total_1d_short (fn,res:string,on_tiles:logical,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
begin
    data_reserve=addfile(fn(0), "r")
    data_green=addfile(fn(1), "r")
    data_woods=addfile(fn(2), "r")
;    data_total=addfile(fn(3), "r")
;    data_gpp=addfile(fn(4), "r")

;    data_green=addfile(fn(0), "r")



    ;3d
    ;time lat lon
    lons=get_lons(res,lon1,lon2)
    nlon=dimsizes(data_green->lon(lons))
    nlat=dimsizes(data_green->lat({lat1:lat2}))
    ntime=dimsizes(data_green->time(:))

    area=get_area_land(res,lon1,lon2,lat1,lat2)
    printVarSummary(area)
    printVarSummary(lons)
    print (lons)
    print(data_green->lon(lons(0))+"  "+data_green->lon(lons(nlon-1)))
    print(ntime+" "+nlat+" "+nlon)
    carea=conform_dims((/ntime,nlat,nlon/),area,(/1,2/))

    if ( on_tiles .eq. False ) then
        reserve3d = dim_sum_n_Wrap(data_reserve->boxC_reserve(:,{lat1:lat2},lons)*carea,(/1,2/))
        green3d =   dim_sum_n_Wrap(data_green->boxC_green(:,{lat1:lat2},lons)*carea,(/1,2/))
        woods3d =   dim_sum_n_Wrap(data_woods->boxC_woods(:,{lat1:lat2},lons)*carea,(/1,2/))
;        total3d =   dim_sum_n_Wrap(data_total->box_Cpools_total(:,{lat1:lat2},lons)*carea,(/1,2/))
;        gpp3d =     dim_sum_n_Wrap(data_gpp->box_GPP_yDayMean(:,{lat1:lat2},lons)*carea,(/1,2/))
    else
        reserve3d = dim_sum_n_Wrap(dim_sum_n_Wrap(data_reserve->boxC_reserve(:,:,{lat1:lat2},lons),1)*carea,(/1,2/))
        green3d =   dim_sum_n_Wrap(dim_sum_n_Wrap(data_green->boxC_green(:,:,{lat1:lat2},lons),1)*carea,(/1,2/))
        woods3d =   dim_sum_n_Wrap(dim_sum_n_Wrap(data_woods->boxC_woods(:,:,{lat1:lat2},lons),1)*carea,(/1,2/))
 ;       total3d =   dim_sum_n_Wrap(data_total->box_Cpools_total(:,{lat1:lat2},lons)*carea,(/1,2/))
 ;       gpp3d =     dim_sum_n_Wrap(dim_sum_n_Wrap(data_gpp->box_GPP_yDayMean(:,:,{lat1:lat2},lons),1)*carea,(/1,2/))
    end if

    if ( runaverage .eq. True ) then
;        cpools1d=new((/8,ntime/),float,MyFillValue)
;        cpools1d(0,:)=total3d*1e-15*12.011 ;total
;        cpools1d(1,:)=runave(cpools1d(0,:),naverage,0); total average
;        cpools1d(2,:)=(total3d-reserve3d-green3d-woods3d)*1e-15*12.011 ; soil
;        cpools1d(3,:)=runave(cpools1d(2,:),naverage,0) ; soil average
;        cpools1d(4,:)=(reserve3d+green3d+woods3d)*1e-15*12.011 ; green
;        cpools1d(5,:)=runave(cpools1d(4,:),naverage,0) ; green avereage
;        cpools1d(6,:)=gpp3d*3600*24*365.25*1e-15*12.011 ; gpp
;        cpools1d(7,:)=runave(cpools1d(6,:),naverage,0) ; gpp average


        cpools1d=new((/2,ntime/),float,MyFillValue)
;        cpools1d(0,:)=total3d*1e-15*12.011 ;total
;        cpools1d(1,:)=runave(cpools1d(0,:),naverage,0); total average
;        cpools1d(2,:)=(total3d-reserve3d-green3d-woods3d)*1e-15*12.011 ; soil
;        cpools1d(3,:)=runave(cpools1d(2,:),naverage,0) ; soil average
        cpools1d(0,:)=(reserve3d+green3d+woods3d)*1e-15*12.011 ; green
        cpools1d(1,:)=runave(cpools1d(0,:),naverage,0) ; green avereage
;        cpools1d(6,:)=gpp3d*3600*24*365.25*1e-15*12.011 ; gpp
;        cpools1d(7,:)=runave(cpools1d(6,:),naverage,0) ; gpp average



    else
        cpools1d=new((/1,ntime/),float,MyFillValue)
        ;cpools1d(0,:)=total3d*1e-15*12.011 ;total
        ;cpools1d(1,:)=(total3d-reserve3d-green3d-woods3d)*1e-15*12.011 ; soil
        cpools1d(0,:)=(reserve3d+green3d+woods3d)*1e-15*12.011 ; green
        ;cpools1d(3,:)=gpp3d*3600*24*365.25*1e-15*12.011 ; gpp
    end if

    return cpools1d
end



;undef ("get_cpools_green_1d")
;function get_cpools_green_1d (fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
;begin
;    data=addfile(fn, "r")
;
;    ;3d
;    lons=get_lons(res,lon1,lon2)
;    cpools3d = data->box_Cpools_total(:,{lat1:lat2},lons)
;    area=get_area_land(res,lon1,lon2,lat1,lat2)
;    carea=conform_dims(dimsizes(cpools3d),area,(/1,2/))
;
;    if ( runaverage .eq. True ) then
;        cpools1d=new((/2,ntime/),typeof(cpools3d),MyFillValue)
;        cpools1d(0,:) = dim_sum_n_Wrap(cpools3d*carea,(/1,2/))*1e-15*12.011
;        cpools1d(1,:) = runave(cpools1d(0,:),naverage,0)
;    else
;        cpools1d=new((/ntime/),typeof(cpools3d),MyFillValue)
;        cpools1d(:) = dim_sum_n_Wrap(cpools3d*carea,(/1,2/))*1e-15*12.011
;    end if
;
;    return cpools1d
;end



undef ("get_cpools_1d")
function get_cpools_1d (opt:logical)
local boxC_reserve2d,boxC_green2d,boxC_woods2d,box_GPP_yDayMean2d,box_Cpools_total2d,total2d,soil2d,green2d,gpp2d,total1d,soil1d,green1d,gpp1d,dims,nlon,nlat,cpools
begin
   ;options
   ;fn
   ;res
   ;fidx
   ;lidx
   ;lon1 lon2 lat1 lat2
   data=addfile(opt@fn, "r")

;2d
   lons=get_lons(opt@res,opt@lon1,opt@lon2)
   boxC_reserve2d     = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_reserve(opt@fidx:opt@lidx,:,{opt@lat1:opt@lat2},lons),1),0)
   boxC_green2d       = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_green(opt@fidx:opt@lidx,:,{opt@lat1:opt@lat2},lons),1),0)
   boxC_woods2d       = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_woods(opt@fidx:opt@lidx,:,{opt@lat1:opt@lat2},lons),1),0)
   box_GPP_yDayMean2d = dim_avg_n_Wrap(dim_sum_n_Wrap(data->box_GPP_yDayMean(opt@fidx:opt@lidx,:,{opt@lat1:opt@lat2},lons),1),0)
   box_Cpools_total2d = dim_avg_n_Wrap(data->box_Cpools_total(opt@fidx:opt@lidx,{opt@lat1:opt@lat2},lons),0)

   total2d = box_Cpools_total2d
   soil2d  = box_Cpools_total2d-boxC_reserve2d-boxC_green2d-boxC_woods2d
   green2d = boxC_reserve2d+boxC_green2d+boxC_woods2d
   gpp2d   = box_GPP_yDayMean2d

   dims = dimsizes(total2d)
   rank=dimsizes(dims)
   nlat=dims(rank-2)
   nlon=dims(rank-1)

   area=get_area(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)

;1d
   total1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(total2d*area)))
   soil1d  = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(soil2d*area)))
   green1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(green2d*area)))
   gpp1d   = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(gpp2d*area)))*3600*24*365.25


   cpools=new((/8,nlat,nlon/),float,MyFillValue)
   copy_VarAtts(box_Cpools_total2d,cpools)
   latunit=box_Cpools_total2d&lat@units
   lonunit=box_Cpools_total2d&lon@units
   cpools!0="pool"
   cpools!1="lat"
   cpools!2="lon"
   cpools&lat=box_Cpools_total2d&lat
   cpools&lon=box_Cpools_total2d&lon
   cpools&lat@units=latunit
   cpools&lon@units=lonunit

   cpools(0,:,:)=0.012 * total2d
   cpools(1,:,:)=0.012 * soil2d
   cpools(2,:,:)=0.012 * green2d
   cpools(3,:,:)=0.012 * 3600*24*365.25 * gpp2d
   cpools(4,:,:)=total1d
   cpools(5,:,:)=soil1d
   cpools(6,:,:)=green1d
   cpools(7,:,:)=gpp1d

   return cpools
end



undef ("get_cpools_diff")
function get_cpools_diff (fn1,fn2,res:string,lon1,lon2,lat1,lat2:float)
local cpools1, cpools2, latunit, lonunit
begin
   cpoolsopt=True
   cpoolsopt@fn=fn1
   cpoolsopt@lon1=lon1
   cpoolsopt@lon2=lon2
   cpoolsopt@lat1=lat1
   cpoolsopt@lat2=lat2
   cpoolsopt@res=res

   cpools1=get_cpools(cpoolsopt)
   cpoolsopt@fn=fn2
   cpools2=get_cpools(cpoolsopt)
   cpools=cpools1-cpools2

   copy_VarAtts(cpools1,cpools)
   latunit=cpools1&lat@units
   lonunit=cpools1&lon@units
   cpools!0="pool"
   cpools!1="lat"
   cpools!2="lon"
   cpools&lat=cpools1&lat
   cpools&lon=cpools1&lon
   cpools&lat@units=latunit
   cpools&lon@units=lonunit

   return cpools
end


undef ("get_npp_pft1d")
function get_npp_pft1d (opt:logical)

begin

    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")
;    lons=get_lons(opt@res,opt@lon1,opt@lon2)

    dims=dimsizes(data->box_NPP_yDayMean(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2}))
    ntimes=dims(0)
    nlev=dims(1)
    nlat=dims(2)
    nlon=dims(3)

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("averaging period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if






    ;4d

    tmp_cover_fract=data->cover_fract(fidx:lidx,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    tmp_NPP_yDayMean=data->box_NPP_yDayMean(fidx:lidx,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    tmp_veg_ratio_max=conform_dims(dims,data->veg_ratio_max(fidx:lidx,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2}),(/0,2,3/))

    printVarSummary(tmp_veg_ratio_max)


    area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
    carea=conform_dims(dims,area,(/2,3/))


    tarea=dim_sum_n_Wrap(carea*tmp_veg_ratio_max*tmp_cover_fract,(/2,3/))


    NPP_1dacc=12.011*dim_sum_n_Wrap(tmp_NPP_yDayMean*carea*tmp_veg_ratio_max*tmp_cover_fract,(/2,3/))*3600*24*365.25



    ; aggregation
    npp1d=new((/2,5,ntimes/),float,MyFillValue)
    ; total
    npp1d(0,0,:)=1e-15*dim_sum_Wrap(NPP_1dacc(:,:))
    ; tree
    npp1d(0,1,:)=1e-15*dim_sum_Wrap(NPP_1dacc(:,0:3))
    ; shrubs
    npp1d(0,2,:)=1e-15*dim_sum_Wrap(NPP_1dacc(:,4:5))
    ; woody
    npp1d(0,3,:)=1e-15*dim_sum_Wrap(NPP_1dacc(:,0:5))
    ; grass
    npp1d(0,4,:)=1e-15*dim_sum_Wrap(NPP_1dacc(:,6:7))



    ; mean
    ; total
    npp1d(1,0,:)=dim_sum_Wrap(NPP_1dacc(:,:))/dim_sum_Wrap(tarea(:,:))
    ; tree
    npp1d(1,1,:)=dim_sum_Wrap(NPP_1dacc(:,0:3))/dim_sum_Wrap(tarea(:,0:3))
    ; shrubs
    npp1d(1,2,:)=dim_sum_Wrap(NPP_1dacc(:,4:5))/dim_sum_Wrap(tarea(:,4:5))
    ; woody
    npp1d(1,3,:)=dim_sum_Wrap(NPP_1dacc(:,0:5))/dim_sum_Wrap(tarea(:,0:5))
    ; grass
    npp1d(1,4,:)=dim_sum_Wrap(NPP_1dacc(:,6:7))/dim_sum_Wrap(tarea(:,6:7))



   return npp1d
end



undef ("get_npp")
function get_npp (opt:logical)

begin

    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->box_NPP_yDayMean(:,:,:,:))
    ntimes=dims(0)
    nlev=dimsizes(1)
    nlat=dims(2)
    nlon=dims(3)

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("averaging period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

    lons=get_lons(opt@res,opt@lon1,opt@lon2)


;2d
   tmp_NPP_yDayMean=dim_avg_n_Wrap(dim_sum_n_Wrap(data->box_NPP_yDayMean(fidx:lidx,:,:,:),1),0)
   if ( opt@lon1 .lt. 0 ) then
        tmp_NPP_yDayMean = lonFlip(tmp_NPP_yDayMean)
   end if
   box_NPP_yDayMean = tmp_NPP_yDayMean({opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   area=get_area(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)

   delete (dims)
   dims=dimsizes(box_NPP_yDayMean)
   nlat=dims(0)
   nlon=dims(1)


;1d
   npp1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(box_NPP_yDayMean*area)))*3600*24*365.25
   npp=new((/2,nlat,nlon/),float,MyFillValue)

   copy_VarAtts(box_NPP_yDayMean,npp)


   npp!1="lat"
   npp!2="lon"
   npp&lat=box_NPP_yDayMean&lat
   npp&lon=box_NPP_yDayMean&lon
   npp&lat@units=box_NPP_yDayMean&lat@units
   npp&lon@units=box_NPP_yDayMean&lon@units

   npp(0,:,:)=0.012 * box_NPP_yDayMean *3600*24*365.25
   npp(1,0,0)=doubletofloat(npp1d)

   return npp
end





undef ("get_albedo")
function get_albedo (opt:logical)
begin
    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->albedo(:,:,:))
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)


    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("averaging period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

; full 2d albedo
    tmp_albedo=dim_avg_n_Wrap(data->albedo(fidx:lidx,:,:),0)

    if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
        if (opt@lon1 .lt. 0 ) then
            tmp_albedo=lonFlip(tmp_albedo)
        end if
        albedo=tmp_albedo({opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    else
        print("global field will be taken")
        albedo=tmp_albedo
    end if

    ;2d
    slmopt=True
    slmopt=opt
    slmopt@land=True
    slmopt@sea=False
    slm=get_slm(slmopt)

    albedo@_FillValue=MyFillValue

    albedo=albedo*slm

    return albedo
end


undef ("get_harvest_1d_ts")
function get_harvest_1d_ts (opt:logical)
begin
;fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer
    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")
    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("data period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

    tmp_harvest=data->harvest(fidx:lidx,:,:)
    ;tmp_harvest=where(tmp_harvest.eq.0.,MyFillValue,tmp_harvest)


    slmopt=True
    slmopt=opt
    slmopt@land=True
    slmopt@sea=False
    slm=get_slm(slmopt)
    printVarSummary(slm)

    dims=dimsizes(tmp_harvest)
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if (opt@lon1 .lt. 0) then
        tmp_harvest2d=lonFlip(tmp_harvest)
    else
        tmp_harvest2d=tmp_harvest
    end if

    harvest2d     = tmp_harvest2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    harvest2d=harvest2d*conform_dims(dimsizes(harvest2d),slm,(/1,2/))
    printVarSummary(harvest2d)

    delete (dims)
    delete (tmp_harvest)
    delete (tmp_harvest2d)


   sdims=dimsizes(harvest2d)
   ntime=sdims(0)
   nlat=sdims(1)
   nlon=sdims(2)


    area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
    size_land=dim_sum(dim_sum(area))
    ;print("size region: "+size_land)
    cregion=conform_dims(dimsizes(harvest2d),area,(/1,2/))


    harvest1d=new((/ntime,2/),typeof(harvest2d),MyFillValue)

    harvest1d(:,0) = dim_sum_n_Wrap(harvest2d*doubletofloat(cregion)*365.25*1e-15*12.011*3600.*24.,(/1,2/)) ;;doubletofloat(size_land)
    if (.not. isatt (harvest1d,"naverage")) then
     harvest1d(:,1) = harvest1d(:,0)
    else
      harvest1d(:,1) = runave(harvest1d(:,0),opt@naverage,0)
    end if

   harvest1d!0="time"
   harvest1d&time=data->time(fidx:lidx)

   return harvest1d
end


undef ("get_wsmx_1d_ts")
function get_wsmx_1d_ts (opt:logical)
begin
;fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer
    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")
    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("data period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

    if (opt@stream.eq."echam") then
      tmp_ws=data->ws(fidx:lidx,:,:)
      tmp_wsmx=data->wsmx(fidx:lidx,:,:)
    end if
    tmp_wsmx=where(tmp_wsmx.eq.0.,MyFillValue,tmp_wsmx)
    tmp_ws=tmp_ws/tmp_wsmx

    dims=dimsizes(tmp_ws)
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if (opt@lon1 .lt. 0) then
        tmp_ws2d=lonFlip(tmp_ws)
    else
        tmp_ws2d=tmp_ws
    end if

    ws2d     = tmp_ws2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})

   delete (dims)
   dims=dimsizes(ws2d)
   ntime=dims(0)
   nlat=dims(1)
   nlon=dims(2)


    area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
    size_land=dim_sum(dim_sum(area))
    ;print("size region: "+size_land)
    cregion=conform_dims(dimsizes(ws2d),area,(/1,2/))


    ws1d=new((/ntime,2/),typeof(ws2d),MyFillValue)

    ws1d(:,0) = dim_sum_n_Wrap(ws2d*doubletofloat(cregion),(/1,2/))/doubletofloat(size_land)
    if (.not. isatt (ws1d,"naverage")) then
     ws1d(:,1) = ws1d(:,0)
    else
      ws1d(:,1) = runave(ws1d(:,0),opt@naverage,0)
    end if



   ws1d!0="time"
   ws1d&time=data->time(fidx:lidx)

   return ws1d
end



undef ("get_wsmx")
function get_wsmx (opt:logical)
begin
    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->ws(:,:,:))
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)


    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("averaging period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

; full 2d ws
    tmp_ws=data->ws(fidx:lidx,:,:)
    tmp_wsmx=data->wsmx(fidx:lidx,:,:)

    tmp_wsmx=where(tmp_wsmx.eq.0.,MyFillValue,tmp_wsmx)
    tmp_ws=tmp_ws/tmp_wsmx


    if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
        if (opt@lon1 .lt. 0 ) then
            tmp_ws=lonFlip(tmp_ws)
        end if
        ws=tmp_ws(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    else
        print("global field will be taken")
        ws=tmp_ws
    end if

    ;2d
    slmopt=True
    slmopt=opt
    slmopt@land=True
    slmopt@sea=False
    slm=get_slm(slmopt)

    ws@_FillValue=MyFillValue

    slm3d=conform_dims(dimsizes(ws), slm, (/1,2/))



    ws=ws*slm3d
    if ( opt@full .eq. True) then
       return ws
    else
      return dim_avg_n_Wrap(ws,0)
    end if
end


;*******************************************************************************
; HISTORY:
;   20-11-12 Tim Bruecher.
;     * General implementation to get fire data out of veg-stream
;     * taking the veg-stream and calculate burned area
;       in 2d and calculate global sum
;*******************************************************************************




undef ("get_fire")
function get_fire (fn,res:string,lon1,lon2,lat1,lat2:float)
local box_burned_acc2d, box_burned_acc1d, fire,lat,nlon,rank,size
begin
    data=addfile(fn, "r")

    ;ndims=dimsizes(dimsizes(data->box_burned_acc(:,:,:,:)))
    lons=get_lons(res,lon1,lon2)
	;print("+++++++++++++++++++++++++++++++++++++++++"+lons)
    box_burned_acc2d = dim_avg_n_Wrap(dim_sum_n_Wrap(data->box_burned_acc(:,:,{lat1:lat2},lons),1),0)

   dims=dimsizes(box_burned_acc2d)
   rank=dimsizes(dims)
   nlat=dims(rank-2)
   nlon=dims(rank-1)

   area=get_area(res,lon1,lon2,lat1,lat2)
   ;printVarSummary(area)
   ;printVarSummary(box_burned_acc2d)
;1d
   ;1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(total2d*area)))
    box_burned_acc1d=365.25 / 1e10*(dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d*area)))
   ;box_burned_acc1d=dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d*area)) * 365.25 / 1e10
   fire=new((/2,nlat,nlon/),float)
   copy_VarAtts(box_burned_acc2d,fire)
   latunit=box_burned_acc2d&lat@units
   lonunit=box_burned_acc2d&lon@units
   fire!0="fire"
   fire!1="lat"
   fire!2="lon"
   fire&lat=box_burned_acc2d&lat
   fire&lon=box_burned_acc2d&lon
   fire&lat@units=latunit
   fire&lon@units=lonunit

   fire(0,:,:)=box_burned_acc2d * 365.25
   fire(1,:,:)=box_burned_acc1d

   return fire
end


undef ("get_fire_vs")
function get_fire_vs (fn,res:string,lon1,lon2,lat1,lat2:float)
local box_burned_acc2d, box_burned_acc1d, fire,lat,nlon,rank,size
begin
    data=addfile(fn, "r")

    ;ndims=dimsizes(dimsizes(data->box_burned_acc(:,:,:,:)))
    lons=get_lons(res,lon1,lon2)
    box_burned_acc2d = data->box_burned_acc(0,{lat1:lat2},lons)

   dims=dimsizes(box_burned_acc2d)
   rank=dimsizes(dims)
   nlat=dims(rank-2)
   nlon=dims(rank-1)

   area=get_area(res,lon1,lon2,lat1,lat2)

;1d
   ;1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(total2d*area)))
    box_burned_acc1d=365.25 / 1e10*(dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d*area)))
   ;box_burned_acc1d=dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d*area)) * 365.25 / 1e10
   fire=new((/2,nlat,nlon/),float)
   copy_VarAtts(box_burned_acc2d,fire)
   latunit=box_burned_acc2d&lat@units
   lonunit=box_burned_acc2d&lon@units
   fire!0="fire"
   fire!1="lat"
   fire!2="lon"
   fire&lat=box_burned_acc2d&lat
   fire&lon=box_burned_acc2d&lon
   fire&lat@units=latunit
   fire&lon@units=lonunit

   fire(0,:,:)=box_burned_acc2d * 365.25
   fire(1,:,:)=box_burned_acc1d

   return fire
end





undef ("get_fire_cmip5pft")
function get_fire_cmip5pft (opt:logical)
begin
fn=opt@fn
    res=opt@res
    firestream=addfile(opt@fn, "r")
    fire=dim_avg_n_Wrap(firestream->fire_fpc(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2}),0)
;    firepft=dim_avg_n_Wrap(fire,0)


    dims=dimsizes(fire)
    npft=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    firepft=new((/14,nlat,nlon/),typeof(fire))
    area=doubletofloat(get_area(res,opt@lon1,opt@lon2,opt@lat1,opt@lat2))

    printVarSummary(firepft)
    printVarSummary(area)

    ; sum up pfts
    ;woody
    firepft(0,:,:)=dim_sum_n_Wrap(fire(0:5,:,:),0)
    firepft(1,0,0)=dim_sum_Wrap(dim_sum_Wrap(firepft(0,:,:)*area))*1e-10 ;in Mha

    ;tree
    firepft(2,:,:)=dim_sum_n_Wrap(fire(0:3,:,:),0)
    firepft(3,0,0)=dim_sum_Wrap(dim_sum_Wrap(firepft(2,:,:)*area))*1e-10 ;in Mha

    ;shrubs
    firepft(4,:,:)=dim_sum_n_Wrap(fire(4:5,:,:),0)
    firepft(5,0,0)=dim_sum_Wrap(dim_sum_Wrap(firepft(4,:,:)*area))*1e-10 ;in Mha

    ;grass
    firepft(6,:,:)=dim_sum_n_Wrap(fire(6:7,:,:),0)
    firepft(7,0,0)=dim_sum_Wrap(dim_sum_Wrap(firepft(6,:,:)*area))*1e-10 ;in Mha

    ;managed
    firepft(8,:,:)=dim_sum_n_Wrap(fire(8:10,:,:),0)
    firepft(9,0,0)=dim_sum_Wrap(dim_sum_Wrap(firepft(8,:,:)*area))*1e-10 ;in Mha

    ;natural
    firepft(10,:,:)=dim_sum_n_Wrap(fire(0:7,:,:),0)
    firepft(11,0,0)=dim_sum_Wrap(dim_sum_Wrap(firepft(10,:,:)*area))*1e-10 ;in Mha

    ;total land
    firepft(12,:,:)=dim_sum_n_Wrap(fire(0:10,:,:),0)
    firepft(13,0,0)=dim_sum_Wrap(dim_sum_Wrap(firepft(12,:,:)*area))*1e-10 ;in Mha


    ;printVarSummary(burnedarea)
;    print("Total burned: " + burnedarea(1,0,0))
     print("woody burned: " + firepft(1,0,0))
     print("tree burned: " + firepft(3,0,0))
     print("shrubs burned: " + firepft(5,0,0))
     print("grass burned: " + firepft(7,0,0))
     print("managed burned: " + firepft(9,0,0))
     print("natural burned: " + firepft(11,0,0))
     print("total burned: " + firepft(13,0,0))

    return firepft
end




undef ("get_firepft")
function get_firepft (opt:logical)
local box_burned_acc2d, box_burned_acc1d, fire,lat,nlon,rank,size
begin
    if ((opt@vegstream.eq."") .or. (opt@mainstream.eq."")) then
        print("filenames not set properly! EXIT")
        exit ;;
   end if

   res=opt@res ; resoloution STRING (T31)


    vegstream=addfile(opt@vegstream, "r")
    mainstream=addfile(opt@mainstream, "r")

    dims=dimsizes(mainstream->veg_fract_correction(:,:,:,:))
    ntimes=dims(0)
    ntiles=dims(1)
    nlat=dims(2)
    nlon=dims(3)


;print("averaging period from: "+opt@fyear+" to "+opt@lyear)

;1d
   if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
      fidx=opt@fidx
      lidx=opt@lidx
      print("averaging period from: "+fidx+" to "+lidx)
   else
      print("taking all timesteps")
      fidx=0
      lidx=ntimes-1
   end if

  ; full2d fields
    tmp_burned_fpc3d=vegstream->burned_fpc(fidx:lidx,:,:,:)
    tmp_act_fpc3d=vegstream->act_fpc(fidx:lidx,:,:,:)
    tmp_veg_ratio_max=mainstream->veg_ratio_max(fidx:lidx,:,:)
    tmp_cover_fract=mainstream->cover_fract(fidx:lidx,:,:,:)


    if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
        if (opt@lon1 .lt. 0 ) then
            tmp_burned_fpc3d  = lonFlip(tmp_burned_fpc3d)
            tmp_act_fpc3d     = lonFlip(tmp_act_fpc3d)
            tmp_veg_ratio_max = lonFlip(tmp_veg_ratio_max)
            tmp_cover_fract   = lonFlip(tmp_cover_fract)
        end if
    else
        print("global field will be taken")
    end if

    burned_fpc3d  = tmp_burned_fpc3d(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    act_fpc3d     = tmp_act_fpc3d(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    veg_ratio_max = tmp_veg_ratio_max(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    cover_fract   = tmp_cover_fract(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})


    act_fpc3d=1./where(act_fpc3d .eq. 0, act_fpc3d@_FillValue, act_fpc3d)*cover_fract*burned_fpc3d
    box_burned3d=burned_fpc3d

    box_burned_acc2d=dim_avg_n_Wrap(veg_ratio_max*(dim_sum_n_Wrap(act_fpc3d,1)),0)

    area=get_area(res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)

   mydims=dimsizes(box_burned_acc2d)
   rank=dimsizes(mydims)
   nlat=mydims(rank-2)
   nlon=mydims(rank-1)


;1d
   ;1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(total2d*area)))
   box_burned_acc1d=365.25 / 1e10*(dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d*area)))
   ;printVarSummary(box_burned_acc1d)
   fire=new((/2,nlat,nlon/),float)
   ;printVarSummary(fire)
   copy_VarAtts(box_burned_acc2d,fire)
   latunit=burned_fpc3d&lat@units
   lonunit=burned_fpc3d&lon@units


   fire(0,:,:)=box_burned_acc2d * 365.25
   fire(1,0,0)=doubletofloat(box_burned_acc1d)
   fire!0="fire"
   fire!1="lat"
   fire!2="lon"
   fire&lat=burned_fpc3d&lat
   fire&lon=burned_fpc3d&lon
   fire&lat@units=latunit
   fire&lon@units=lonunit
   ;printVarSummary(fire)
   return fire
end



undef ("get_fire_daniau")
function get_fire_daniau (opt:logical)
local boxburned_2d, boxburned1d,area
begin
    fn=opt@fn
    res=opt@res
    firestream=addfile(opt@fn, "r")
    fire3d=firestream->fire_fpc(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})

    dims=dimsizes(fire3d)
    ntime=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    area=get_area(res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
    carea=conform_dims(dims,area,(/1,2/))

    burnedarea=new((/2,nlon,nlat/),float)
    burnedarea(0,:,:)=dim_avg_n_Wrap(fire3d,0)
    burnedarea(1,0,0)=dim_avg_n_Wrap(fire3d*carea,0)

    ;printVarSummary(burnedarea)
    print("Total burned: " + burnedarea(1,0,0))

    return burnedarea
end



undef ("get_fire_cmip5")
function get_fire_cmip5 (opt:logical)
local firestream
begin
    fn=opt@fn
    res=opt@res
    firestream=addfile(opt@fn, "r")
    fire=firestream->fire_fpc(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
    fire2d=dim_avg_n_Wrap(fire,0)
    dims=dimsizes(fire2d)
    nlat=dims(0)
    nlon=dims(1)


    area=doubletofloat(get_area(res,opt@lon1,opt@lon2,opt@lat1,opt@lat2))
    ;carea=conform_dims(dims,area,(/1,2/))

    burnedarea=new((/2,nlat,nlon/),float)


    burnedarea(0,:,:)=fire2d
    burnedarea(1,0,0)=dim_sum_Wrap(dim_sum_Wrap(fire2d*area))*1e-10 ;in Mha

    ;printVarSummary(burnedarea)
    print("Total burned: " + burnedarea(1,0,0))

    printVarSummary(burnedarea)
    return burnedarea
end



undef ("get_firecarbon_1d")
function get_firecarbon_1d (opt:logical)

local fire_C_flux2d,fire_C_flux1d,latunit,lonunit
begin
   data=addfile(opt@vegstream, "r")
   area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)


;2d
   fire_C_flux =data->box_fire_CO2_flux_2_atmos(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   dims=dimsizes(fire_C_flux)
   rank=dimsizes(dims)
   nlat=dims(rank-2)
   nlon=dims(rank-1)
   ntime=dims(0)

   carea = new(dimsizes(fire_C_flux),typeof(fire_C_flux))
   ; printVarSummary (carea)
   carea=conform_dims(dimsizes(fire_C_flux),area,(/1,2/))
   ;printVarSummary(carea)
;1d
   fire_C_flux1d=365.25 * 86400 / 44.01 * 12.0107 * 1000 * dim_sum_Wrap(dim_sum_Wrap(fire_C_flux*carea)) *1e-15 ; GT ; get g(C) m-2 d-1
   printVarSummary(fire_C_flux1d)
   return fire_C_flux1d
end


undef ("get_firepft_ts")
function get_firepft_ts (opt:logical)
local box_burned_acc2d, box_burned_acc1d, fire,lat,nlon,rank,size
begin
      if ((opt@vegstream.eq."") .or. (opt@mainstream.eq."")) then
         print("filenames not set properly! EXIT")
         exit ;;
      end if

      res=opt@res
      vegstream=addfile(opt@vegstream, "r")
      mainstream=addfile(opt@mainstream, "r")

      dims=dimsizes(mainstream->cover_fract(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2}))
      ntimes=dims(0)
      ntiles=dims(1)
      nlat=dims(2)
      nlon=dims(3)



      print(dims)



      ;1d
      if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
         fidx=opt@fidx
         lidx=opt@lidx
      print("averaging period from: "+fidx+" to "+lidx)
      else
         print("taking all timesteps")
         fidx=0
         lidx=ntimes-1
      end if

      ; full fields
      tmp_burned_fpc3d=vegstream->burned_fpc(fidx:lidx,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
      tmp_act_fpc3d=vegstream->act_fpc(fidx:lidx,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
      tmp_veg_ratio_max=mainstream->veg_ratio_max(fidx:lidx,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
      tmp_cover_fract=mainstream->cover_fract(fidx:lidx,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})


      ; if (isatt(opt,"localfiles") ) then
      ;     if (opt@localfiles) then
      ;
      ;     end if
      ; else
      ;   print("global input will be taken")
      ;   if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
      ;      if (opt@lon1 .lt. 0 ) then
      ;         tmp_burned_fpc3d  = lonFlip(tmp_burned_fpc3d)
      ;         tmp_act_fpc3d     = lonFlip(tmp_act_fpc3d)
      ;         tmp_veg_ratio_max = lonFlip(tmp_veg_ratio_max)
      ;         tmp_cover_fract   = lonFlip(tmp_cover_fract)
      ;      end if
      ;   else
      ;     print("global data will be taken")
      ;
      ;   end if
        burned_fpc3d  = tmp_burned_fpc3d(:,:,:,:)
        act_fpc3d     = tmp_act_fpc3d(:,:,:,:)
        veg_ratio_max = tmp_veg_ratio_max(:,:,:)
        cover_fract   = tmp_cover_fract(:,:,:,:)
      ; end if



      act_fpc3d=1./where(act_fpc3d .eq. 0, act_fpc3d@_FillValue, act_fpc3d)*cover_fract*burned_fpc3d
      box_burned3d=burned_fpc3d

      alldims=dimsizes(burned_fpc3d)
      ntime=alldims(0)
      ntiles=alldims(1)
      nlat=alldims(2)
      nlon=alldims(3)


;      print (alldims)

      box_burned_acc2d=new((/ntime,5,nlat,nlon/),"double")

;      printVarSummary(box_burned_acc2d(:,0,:,:))
;      printVarSummary(dim_sum_n_Wrap(act_fpc3d(:,0:10,:,:),1))

      box_burned_acc2d(:,0,:,:)=veg_ratio_max*(dim_sum_n_Wrap(act_fpc3d(:,0:10,:,:),1))
      ; tree
      box_burned_acc2d(:,1,:,:)=veg_ratio_max*(dim_sum_n_Wrap(act_fpc3d(:,0:3,:,:),1))
      ; shrubs
      box_burned_acc2d(:,2,:,:)=veg_ratio_max*(dim_sum_n_Wrap(act_fpc3d(:,4:5,:,:),1))
      ; woody
      box_burned_acc2d(:,3,:,:)=veg_ratio_max*(dim_sum_n_Wrap(act_fpc3d(:,0:5,:,:),1))
      ; grass
      box_burned_acc2d(:,4,:,:)=veg_ratio_max*(dim_sum_n_Wrap(act_fpc3d(:,6:7,:,:),1))



      delete(dims)
      dims=dimsizes(box_burned_acc2d)
      ;ntime=dims(0)
      ;nlat=dims(1)
      ;nlon=dims(2)

      ; if (isatt (opt,"areastream") ) then
      ;     areastream=addfile(opt@areastream, "r")
      ;     area=areastream->cell_area({opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
      ; else
        area=get_area_land(res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
      ; end if
      ;print(area*1e-10)
      print(dim_sum_Wrap(dim_sum_Wrap(area))*1e-10)
      print("land area: "+dim_sum_Wrap(dim_sum_Wrap(area))*1e-10)

      printVarSummary(act_fpc3d)
       printVarSummary(area)
       printVarSummary(dim_sum_n_Wrap(act_fpc3d(0,:,:,:),0))


       ;earea=area*dim_sum_n_Wrap(act_fpc3d(0,:,:,:),0) ; where(dim_sum_n_Wrap(act_fpc3d(0,:,:,:),0) .eq. 0,act_fpc3d@_FillValue,area)
       ;printVarSummary(earea)


      ; printVarSummary(dims)
      ; print(dims)
      carea = new(dimsizes(box_burned_acc2d),"double")
      ; printVarSummary (carea)
      carea=conform_dims(dimsizes(box_burned_acc2d),area,(/2,3/))


      ;1d
      box_burned_acc1d=new((/ntime,5/),"double")
      ;1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(total2d*area)))
      box_burned_acc1d=365.25 / 1e10*(dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d*carea)))
      ; box_burned_acc1d(1,:)=365.25 / 1e10*(dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d(:,1,:,:)*carea)))
      ; box_burned_acc1d(2,:)=365.25 / 1e10*(dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d(:,2,:,:)*carea)))
      ; box_burned_acc1d(3,:)=365.25 / 1e10*(dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d(:,3,:,:)*carea)))
      ; box_burned_acc1d(4,:)=365.25 / 1e10*(dim_sum_Wrap(dim_sum_Wrap(box_burned_acc2d(:,4,:,:)*carea)))
      ; ;printVarSummary(box_burned_acc1d)
      ; printVarSummary(box_burned_acc1d)

      fire=box_burned_acc1d
      fire!0="time"
      fire!1="pfts"
      fire&time=burned_fpc3d&time
      ; printVarSummary(box_burned_acc1d)
      return fire
end




undef ("get_fire_diff")
function get_fire_diff (fn1,fn2,res:string,lon1,lon2,lat1,lat2:float)
local fire1, fire2, latunit, lonunit
begin
   fire1=get_fire(fn1,res,lon1,lon2,lat1,lat2)
   fire2=get_fire(fn2,res,lon1,lon2,lat1,lat2)
   fire=fire1-fire2

   copy_VarAtts(fire1,fire)
   latunit=fire1&lat@units
   lonunit=fire1&lon@units
   fire!0="fire"
   fire!1="lat"
   fire!2="lon"
   fire&lat=fire1&lat
   fire&lon=fire1&lon
   fire&lat@units=latunit
   fire&lon@units=lonunit

   return fire
end




undef ("get_fuel")
function get_fuel (fn,res:string,lon1,lon2,lat1,lat2:float)
local box_burned_acc2d, box_burned_acc1d, fuel,lat,nlon,rank,size
begin
    data=addfile(fn, "r")

    lons=get_lons(res,lon1,lon2)
    fueltmp=dim_avg_n_Wrap(data->fuel(:,{lat1:lat2},lons),0)
    desert=dim_avg_n_Wrap(data->desert_fpc(:,{lat1:lat2},lons),0)
    area=get_area(res,lon1,lon2,lat1,lat2)
    fueltmp=fueltmp*(1-desert)*12.011

    dims=dimsizes(fueltmp)
    rank=dimsizes(dims)
    nlat=dims(rank-2)
    nlon=dims(rank-1)
;1d
    fuel_acc_1d=1e-15*12.011*dim_sum_Wrap(dim_sum_Wrap(fueltmp*area))

    fuel=new((/2,nlat,nlon/),float)
    copy_VarAtts(fueltmp,fuel)
    latunit=fueltmp&lat@units
    lonunit=fueltmp&lon@units
    fuel!0="fuel"
    fuel!1="lat"
    fuel!2="lon"
    fuel&lat=fueltmp&lat
    fuel&lon=fueltmp&lon
    fuel&lat@units=latunit
    fuel&lon@units=lonunit

    fuel(0,:,:)=fueltmp
    fuel(1,:,:)=fuel_acc_1d

    return fuel
end



undef ("get_fuel_diff")
function get_fuel_diff (fn1,fn2,res:string,lon1,lon2,lat1,lat2:float)
local fuel1, fuel2, latunit, lonunit
begin
   fuel1=get_fuel(fn1,res,lon1,lon2,lat1,lat2)
   fuel2=get_fuel(fn2,res,lon1,lon2,lat1,lat2)
   fuel=fuel1-fuel2

   copy_VarAtts(fuel1,fuel)
   latunit=fuel1&lat@units
   lonunit=fuel1&lon@units
   fuel!0="fuel"
   fuel!1="lat"
   fuel!2="lon"
   fuel&lat=fuel1&lat
   fuel&lon=fuel1&lon
   fuel&lat@units=latunit
   fuel&lon@units=lonunit

   return fuel
end




undef ("get_zscore")
function get_zscore (fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
begin
    data=addfile(fn, "r")
    lons=get_lons(res,lon1,lon2)
    barea=dim_sum_n_Wrap(data->box_burned_acc(:,:,{lat1:lat2},lons),1)

    dims=dimsizes(barea)
    rank=dimsizes(dims)
    ntime=dims(rank-3)
    nlat=dims(rank-2)
    nlon=dims(rank-1)

    minfire=conform_dims((/ntime,nlat,nlon/), dim_min_n_Wrap(barea,0),(/1,2/))
    printVarSummary(minfire)
    maxfire=conform_dims((/ntime,nlat,nlon/), dim_max_n_Wrap(barea,0),(/1,2/))
    printVarSummary(maxfire)

    difffire=maxfire-minfire
    difffire_inv=1./where(difffire.ne.0.,difffire,MyFillValue)

    cstar=where(difffire .ne. 0., (barea-minfire)*difffire_inv,MyFillValue)

    cstar_mean=conform_dims((/ntime,nlat,nlon/),dim_avg_n_Wrap(cstar(4000:7999,:,:),0),(/1,2/))
    ;cstar_stdev=conform_dims((/ntime,nlat,nlon/),dim_stddev_n_Wrap(cstar(4000:7999,:,:),0),(/1,2/))
    ;cstar_stdev=where(cstar_stdev .ne. 0., cstar_stdev, MyFillValue)
    zscore=(cstar-cstar_mean) ;/cstar_stdev
    zscore1d=runave(dim_avg_n_Wrap(zscore,(/1,2/)),naverage,0)
    return zscore1d
end



undef ("get_minimax")
function get_minimax (quant,shift:float)
begin
    qmin=min(quant)
    print(qmin)
    qmax=max(quant)
    print(qmax)
    if ((qmin.eq.qmax) .or. ismissing(qmin))then
        minimax=MyFillValue
    else
        minimax=(quant-qmin)/(qmax-qmin)+shift
    end if
    ;printVarSummary(minimax)
    return minimax
end


undef ("boxcox_lambda")
function boxcox_lambda (quant)
begin
    shift=0.01
    nlam=101
    qmiss=quant@_FillValue

    ;number of records
    ndata=dimsizes(quant)

    y=new(ndata,float,qmiss)
    yt=new(ndata,float,qmiss)
    zt=new(ndata,float,qmiss)
    lam=new(nlam,float,qmiss)
    lh=new(nlam,float,qmiss)
    lhmax=new(1,float,"No_FillValue")
    jmax=new(1,integer,"No_FillValue")
    nonmiss=new(1,integer,"No_FillValue")

    rtquant=new(ndata,float,qmiss)

    y=get_minimax(quant,shift)
    nonmiss=dimsizes(quant)
    do i=0,ndata-1
        if (ismissing(quant(i))) then
            nonmiss=nonmiss-1
        end if
    end do
    logy=log(y)
    logymean=dim_avg(logy)
    ydot=exp(logymean)

    ; loop over lamdas from -2 to 2 and find maximum likelihood
    lhmax=-99999.0
    lambda=-9.0
    jmax=1
    do j=0,nlam-1
        lam(j)=-2.0+(j-1.)*(4.0/(nlam-1))
        yt=qmiss
        zt=qmiss
        ; Box-Cox Transformation with current lambda
        do i=0,ndata-1
            if (.not. ismissing(y(i)) ) then
                if (lam(j).ne.0.) then
                    yt(i)=( y(i)^lam(j) -1.)/lam(j)
                else
                    yt(i)=logy(i) * (1.+((lam(j)*logy(i)) / 2.* (1.+(lam(j)*logy(i))/3.*(1.+(lam(j)*logy(i))/4.))))
                end if
                zt(i)=yt(i)/(ydot^(lam(j)-1.))
            end if
       end do
        ; residual
        ztmean=dim_avg(zt)
        rss=0.
        do i=0,ndata-1
            if ( .not. ismissing(zt(i))) then
                rss=rss+(zt(i)-ztmean)^2.
            end if
        end do
        ; likelihood
        lh(j)=(-1.*nonmiss/2.)*log(rss)
        if (lh(j).ge.lhmax) then
            lhmax=lh(j)            ; maximum likelihood value
            lambda=lam(j)          ; lmbda at maximum likelihood
            jmax=j
        end if

    end do
    ;print (lambda+" "+lhmax+"  "+jmax)

    ; now we do have the optimal lambda, lets transform
    y=get_minimax(quant,shift)
    rtquant=qmiss
    do i=0,ndata-1
        if (.not. ismissing(y(i))) then
            if (lambda.ne.0.) then
                rtquant(i)=(y(i)^lambda-1.)/lambda
            else
                rtquant(i)=log(y(i))
            end if

        end if
    end do
    tquant=get_minimax(rtquant,shift)


; calculating zscores
    tmean=avg(tquant(:))
    tstddev=stddev(tquant(:))

    tquant=(tquant-tmean)/tstddev

    return tquant
end



undef("get_fire_boxcox")
function get_fire_boxcox (fn,res:string, lon1,lon2,lat1,lat2:float,scalewitharea:logical,naverage:integer)

begin
    data=addfile(fn, "r")

    lons=get_lons(res,lon1,lon2)

    ; check if 3d or 4d


    box_burned_acc3d = dim_sum_n_Wrap(data->box_burned_acc(:,:,{lat1:lat2},lons),1)

    dims=dimsizes(box_burned_acc3d)
    rank=dimsizes(dims)
    ntime=dims(rank-3)
    nlat=dims(rank-2)
    nlon=dims(rank-1)

    area=get_area(res,lon1,lon2,lat1,lat2)
    carea=conform_dims(dims,area,(/1,2/))

    if (scalewitharea) then
        barea=box_burned_acc3d*carea
    else
        barea=box_burned_acc3d
    end if
    tquant=new(dims,float,box_burned_acc3d@_FillValue)

    do ilon=0,nlon-1
       do ilat=0,nlat-1
            print("processing: "+(ilat+ilon*nlat)+" out of "+ nlon*nlat )
           barea(:,ilat,ilon)=runave(barea(:,ilat,ilon),naverage,0)

           if ( all(ismissing(barea(:,ilat,ilon)))) then
                ; skip this box
                print("This box will be skipped (ocean)")
           else
                tquant(:,ilat,ilon)=boxcox_lambda(barea(:,ilat,ilon))
;            tquant(:,ilat,ilon)=barea(:,ilat,ilon)
            end if
       end do
    end do

    mtquant=new(ntime,float,box_burned_acc3d@_FillValue)
    mtquant=dim_avg_n(tquant,(/1,2/))

    return mtquant
end



undef("get_fire_boxcox2d")
function get_fire_boxcox2d (fn,res:string, lon1,lon2,lat1,lat2:float, scalewitharea:logical,naverage:integer)

begin
    data=addfile(fn, "r")

    lons=get_lons(res,lon1,lon2)

    ; check if 3d or 4d


    box_burned_acc3d = data->box_burned_acc(:,{lat1:lat2},lons)

    dims=dimsizes(box_burned_acc3d)
    rank=dimsizes(dims)
    ntime=dims(rank-3)
    nlat=dims(rank-2)
    nlon=dims(rank-1)

    area=get_area(res,lon1,lon2,lat1,lat2)
    carea=conform_dims(dims,area,(/1,2/))

    if (scalewitharea) then
        barea=box_burned_acc3d*carea
    else
        barea=box_burned_acc3d
    end if
    tquant=new(dims,float,box_burned_acc3d@_FillValue)

    do ilon=0,nlon-1
       do ilat=0,nlat-1
            print("processing: "+(ilat+ilon*nlat)+" out of "+ nlon*nlat )
           barea(:,ilat,ilon)=runave(barea(:,ilat,ilon),naverage,0)

           if ( all(ismissing(barea(:,ilat,ilon))) .or. (max(barea(:,ilat,ilon)) .eq. min(barea(:,ilat,ilon)))) then
                ; skip this box
                print("This box will be skipped (ocean)")
           else
                tquant(:,ilat,ilon)=boxcox_lambda(barea(:,ilat,ilon))
;            tquant(:,ilat,ilon)=barea(:,ilat,ilon)
            end if
       end do
    end do

    ;mtquant=new(ntime,float,box_burned_acc3d@_FillValue)
    ;mtquant=dim_avg_n(tquant,(/1,2/))

    return tquant
end


undef("get_GCD_mask")
function get_GCD_mask(regvec:integer)
;local output
begin
    ;regname=(/"all", "afr","ind","ena","wna","csa","ssa","aus","eas","eur"/)
    regnumber=(/    0,     1,    2,    3,     4,    5,    6,    7,    8,   9/)
    regions=get_GCD_region
    regions@_FillValue=MyFillValue

    dims=dimsizes(regions)
    rank=dimsizes(dims)
    nlat=dims(rank-2)
    nlon=dims(rank-1)

    nregs=dimsizes(regvec)

    printVarSummary (regions)
    printVarSummary(nregs)
    output=conform_dims((/nregs,nlat,nlon/), regions, (/1,2/))

    do ireg = 0, nregs-1
        output(ireg,:,:)=where(regions(:,:).eq.regvec(ireg),1,MyFillValue)
    end do

    copy_VarAtts(regions,output)
    latunit=regions&lat@units
    lonunit=regions&lon@units
    output!0="region"
    output!1="lat"
    output!2="lon"
    output&lat=regions&lat
    output&lon=regions&lon
    output&lat@units=latunit
    output&lon@units=lonunit
    assignFillValue(regions,output)

    ;size of outputfile
;    gcd_data=conform_dims((/nregs,ntime,nlat,nlon/), input, (/1,2,3/))
;    gcd_regions=conform_dims((/ntime,nlat,nlon/), regions, (/1,2/))


;    do ireg = 0,nregs-1
;        gcd_data(ireg,:,:,:)=where(gcd_regions(:,:,:).eq.regvec(ireg),input,gcd_data@_FillValue)
;    end do
;
;    ; average, sum, *size
;    if (accu .eq. 1 ) then
;        ; sum
;        output=dim_sum_n_Wrap(gcd_data,(/2,3/))
;    else if (accu .eq. 2) then
;        ; sum * size
;        output=dim_sum_n_Wrap(gcd_data*area,(/2,3/))
;    else if (accu .eq. 3) then
;        ; average
;        output=dim_avg_n_Wrap(gcd_data,(/2,3/))
;    else if (accu .eq. 5) then
;        ; average * size
;        output=dim_avg_n_Wrap(gcd_data*area,(/2,3/))
;    else
;        ; nothing
;        output=gcd_data
;    end if
;    end if
;    end if
;    end if

    return (output)
end






undef ("get_fire_C_flux")
function get_fire_C_flux (fn,res:string,lon1,lon2,lat1,lat2:float)
local fire_C_flux2d,fire_C_flux1d,latunit,lonunit
begin
   data=addfile(fn, "r")

;2d
   lons=get_lons(res,lon1,lon2)
   fire_C_flux2d = dim_avg_n_Wrap(data->box_fire_CO2_flux_2_atmos(:,{lat1:lat2},lons),0)
   dims=dimsizes(fire_C_flux2d)
   rank=dimsizes(dims)
   nlat=dims(rank-2)
   nlon=dims(rank-1)

   area=get_area(res,lon1,lon2,lat1,lat2)

;1d
   fire_C_flux1d=365.25 * 86400 / 44.01 * 12.0107 * 1000 * dim_sum_Wrap(dim_sum_Wrap(fire_C_flux2d*area)) ; get g(C) m-2 d-1
   C_flux=new((/2,nlat,nlon/),float)
   copy_VarAtts(fire_C_flux2d,C_flux)
   latunit=fire_C_flux2d&lat@units
   lonunit=fire_C_flux2d&lon@units
   C_flux!0="Average C flux to atmosphere"
   C_flux!1="lat"
   C_flux!2="lon"
   C_flux&lat=fire_C_flux2d&lat
   C_flux&lon=fire_C_flux2d&lon
   C_flux&lat@units=latunit
   C_flux&lon@units=lonunit

   C_flux(0,:,:)=fire_C_flux2d * 365.25 * 86400. / 44.01 * 12.0107 *1000. ; get g(C) m-2 yr-1
   C_flux(1,:,:)=fire_C_flux1d * 1e-15
    return C_flux
end



undef ("get_fire_C_flux_diff")
function get_fire_C_flux_diff (fn1,fn2,res:string,lon1,lon2,lat1,lat2:float)
local C_flux1,C_flux2,latunit,lonunit
begin
   C_flux1=get_fire_C_flux(fn1,res,lon1,lon2,lat1,lat2)
   C_flux2=get_fire_C_flux(fn2,res,lon1,lon2,lat1,lat2)
   C_flux=C_flux1-C_flux2

   copy_VarAtts(C_flux1,C_flux)
   latunit=C_flux1&lat@units
   lonunit=C_flux1&lon@units
   C_flux!0="Average C flux to atmosphere"
   C_flux!1="lat"
   C_flux!2="lon"
   C_flux&lat=C_flux1&lat
   C_flux&lon=C_flux1&lon
   C_flux&lat@units=latunit
   C_flux&lon@units=lonunit

   return C_flux
end



undef ("get_fire_barea_1d")
function get_fire_barea_1d (fn,res:string,on_tiles:logical,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
local C_flux_1d
begin
    data=addfile(fn, "r")

   ;2d
    ;time lat lon
   nlon=dimsizes(data->lon(:))
   ntime=dimsizes(data->time(:))
   lons=get_lons(res,lon1,lon2)
    if (on_tiles .eq.True) then
        fire_barea3d = dim_sum_n_Wrap(data->box_burned_acc(:,:,{lat1:lat2},lons),1)
    else
        fire_barea3d = data->box_burned_acc(:,{lat1:lat2},lons)
    end if
   area=get_area(res,lon1,lon2,lat1,lat2)
   carea=conform_dims(dimsizes(fire_barea3d),area,(/1,2/))

   fire_barea_1d=new((/ntime/),typeof(fire_barea3d),MyFillValue)
   if ( runaverage .eq. True ) then
     fire_barea_1d(:) = runave(dim_sum_n_Wrap(fire_barea3d*carea,(/1,2/))* 365.25 / 1e10,naverage,0)
   else
     fire_barea_1d(:) = dim_sum_n_Wrap(fire_barea3d*carea,(/1,2/))* 365.25 / 1e10
   end if
  return fire_barea_1d
end



undef ("get_fire_cflux_1d")
function get_fire_cflux_1d (fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
local fire_C_flux_3d,fire_C_flux_1d,rank, dims,ntime,nlat,nlon,lons
begin
   data=addfile(fn, "r")

;2d
   lons=get_lons(res,lon1,lon2)
   fire_C_flux_3d = data->box_fire_CO2_flux_2_atmos(:,{lat1:lat2},lons)
   dims=dimsizes(fire_C_flux_3d)
   rank=dimsizes(dims)
   ntime=dims(rank-3)
   nlat=dims(rank-2)
   nlon=dims(rank-1)

   area=get_area(res,lon1,lon2,lat1,lat2)
   carea=conform_dims(dimsizes(fire_C_flux_3d),area,(/1,2/))

   fire_cflux_1d=new((/ntime/),typeof(fire_C_flux_3d),MyFillValue)
   if ( runaverage .eq. True ) then
     fire_cflux_1d(:) = runave(dim_sum_n_Wrap(fire_C_flux_3d*carea,(/1,2/))* 365.25 * 86400. / 44.01 * 12.0107 / 1e12 ,naverage,0)
   else
     fire_cflux_1d(:) = dim_sum_n_Wrap(fire_C_flux_3d*carea,(/1,2/))* 365.25 * 86400. / 44.01 * 12.0107 / 1e12
   end if
  return fire_cflux_1d
end



undef ("get_fire_tquant_1d")
function get_fire_tquant_1d (fn,res:string,lon1,lon2,lat1,lat2:float)
local C_flux_1d
begin
    data=addfile(fn, "r")

   ;2d
    ;time lat lon
   nlon=dimsizes(data->lon(:))
   ntime=dimsizes(data->time(:))
   lons=get_lons(res,lon1,lon2)
   fire_tquant_3d = data->tquant(:,{lat1:lat2},lons)

   fire_tquant_1d=new((/ntime/),typeof(fire_tquant_3d),MyFillValue)
   fire_tquant_1d(:) = dim_avg_n_Wrap(fire_tquant_3d,(/1,2/))

  return fire_tquant_1d
end




undef ("get_fire_barea_3d")
function get_fire_barea_3d (fn,res:string,on_tiles:logical,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
local C_flux_1d
begin
    data=addfile(fn, "r")

   ;2d
    ;time lat lon
   nlon=dimsizes(data->lon(:))
   ntime=dimsizes(data->time(:))
   lons=get_lons(res,lon1,lon2)

   if (on_tiles .eq.True) then
        fire_barea3d = dim_sum_n_Wrap(data->box_burned_acc(:,:,{lat1:lat2},lons),1)
    else
        fire_barea3d = data->box_burned_acc(:,{lat1:lat2},lons)
    end if
   area=get_area(res,lon1,lon2,lat1,lat2)
;   carea=conform_dims(dimsizes(fire_barea3d),area,(/2,3/))
;
;   if ( runaverage .eq. True ) then
;     fire_barea_3d=new((/2,nlon,nlat,ntime/),typeof(fire_barea3d),MyFillValue)
;     fire_barea_3d(0,:,:,:) = fire_barea3d*area(/1,2/)* 365.25 / 1e10
;
;     fire_barea_3d(1,:,:,:) = runave_n(fire_barea_3d(0,:,:,:),naverage,0,0)
;   else
;     fire_barea_3d=new((/nlon,nlat,ntime/),typeof(fire_barea3d),MyFillValue)
;     fire_barea_3d(:) = dim_sum_n_Wrap(fire_barea3d*carea,(/1,2/))* 365.25 / 1e10
;   end if
  return fire_barea_3d
end





;*******************************************************************************
; HISTORY:
;   20-11-12 Tim Bruecher.
;     * General implementation to get fire data out of jsbach-stream
;     * taking the jsbach-stream and calculate 2d coverfractions
;       seperately for: desert(0), woody(1), tree(2), shrubs(3), grass(4)
;*******************************************************************************

undef ("get_coverfraction_hoff")
function get_coverfraction_hoff (fncover,fncorrect,fnratio:string)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin


   datacover=addfile(fncover, "r")
   datacorrect=addfile(fncorrect, "r")
   dataratio=addfile(fnratio, "r")

;4d
   cover_fract=datacover->cover_fract(:,:,:,:)
   veg_fract_correction=datacorrect->veg_fract_correction(:,:,:,:)
   veg_ratio_max=dataratio->veg_ratio_max(:,:,:)

   dims=dimsizes(veg_ratio_max)
   printVarSummary(veg_ratio_max)
   ntime=dims(0)
   nlat=dims(1)
   nlon=dims(2)
   coverfraction=new((/5,ntime,nlat/),float,MyFillValue)

   ;desert
   print("0")
   coverfraction(0,:,:)=1.-dim_avg_n_Wrap(veg_ratio_max,2)
   ;woody
   print("1")
   coverfraction(1,:,:)=dim_avg_n_Wrap(veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:5,:,:),1),2)
   ;tree
   print("2")
   coverfraction(2,:,:)=dim_avg_n_Wrap(veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:3,:,:),1),2)
   ;shrubs
   print("3")
   coverfraction(3,:,:)=dim_avg_n_Wrap(veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,4:5,:,:),1),2)
   ;grass
   print("4")
   coverfraction(4,:,:)=dim_avg_n_Wrap(veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,6:7,:,:),1),2)

    ; set correct attributes


   copy_VarAtts(cover_fract,coverfraction)
   latunit=cover_fract&lat@units
   timeunit=cover_fract&time@units
   coverfraction!0="pfts"
   coverfraction!1="time"
   coverfraction!2="lat"

   coverfraction&lat=cover_fract&lat
   coverfraction&time=cover_fract&time
   coverfraction&lat@units=latunit
   coverfraction&time@units=timeunit
    printVarSummary(coverfraction)




   return coverfraction
end





undef ("get_coverfraction")
function get_coverfraction (opt:logical)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin

   if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
   end if

    data=addfile(opt@fn, "r")

    dims=dimsizes(data->veg_fract_correction(:,:,:,:))
    ntimes=dims(0)
    ntiles=dims(1)
    nlat=dims(2)
    nlon=dims(3)

   if (ntiles.ne.11) then
        print ("version does only work with 11 tiles!!! EXIT !!!")
        exit ;;
   end if

   if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
      fidx=opt@fidx
      lidx=opt@lidx
      print("averaging period from: "+fidx+" to "+lidx)
   else
      print("taking all timesteps")
      fidx=0
      lidx=ntimes-1
   end if


   if ( .not. (isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2")) ) then
      opt@lon1=data->lon(0)
      opt@lon2=data->lon(nlon-1)
      opt@lat1=data->lat(0)
      opt@lat2=data->lat(nlat-1)
   end if

   if ( .not. (isatt(opt,"full"))) then
	opt@full=False
   end if


   print(opt@lon1+" "+opt@lon2+" "+opt@lat1+" "+opt@lat2)

   ;full4d
   tmp_full_cover_fract=data->cover_fract(fidx:lidx,:,:,:)
   tmp_full_veg_fract_correction=data->veg_fract_correction(fidx:lidx,:,:,:)
   ;full3d
   tmp_full_veg_ratio_max=data->veg_ratio_max(fidx:lidx,:,:)

;{opt@lat1:opt@lat2},{opt@lon1:opt@lon2}

   if (opt@lon1 .lt. 0 ) then
         tmp_full_cover_fract=lonFlip(tmp_full_cover_fract)
         tmp_full_veg_ratio_max=lonFlip(tmp_full_veg_ratio_max)
   end if

   cover_fract=tmp_full_cover_fract(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   veg_ratio_max=tmp_full_veg_ratio_max(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})

   delete(tmp_full_cover_fract)
   delete(tmp_full_veg_ratio_max)


   delete(dims)
   dims=dimsizes(cover_fract)
   ntimes=dims(0)
   ntiles=dims(1)
   nlat=dims(2)
   nlon=dims(3)

   coverfraction=new((/ntimes,12,nlat,nlon/),float,MyFillValue)
   copy_VarAtts(cover_fract,coverfraction)
   latunit=cover_fract&lat@units
   lonunit=cover_fract&lon@units

   coverfraction!0="time"
   coverfraction!1="pfts"
   coverfraction!2="lat"
   coverfraction!3="lon"

   coverfraction&lat=cover_fract&lat
   coverfraction&lon=cover_fract&lon
   coverfraction&lat@units=latunit
   coverfraction&lon@units=lonunit


   ;desert
   coverfraction(:,0,:,:)=1.-veg_ratio_max
   ;woody
   coverfraction(:,1,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:5,:,:),1)
   ;tree
   coverfraction(:,2,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:3,:,:),1)
   ;shrubs
   coverfraction(:,3,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,4:5,:,:),1)
   ;grass
   coverfraction(:,4,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,6:7,:,:),1)
   ;c3 pasture+c4 pasture
   coverfraction(:,5,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,8:9,:,:),1)
   ;c3 pasture
   coverfraction(:,6,:,:)=veg_ratio_max*cover_fract(:,8,:,:)
   ;c4 pasture
   coverfraction(:,7,:,:)=veg_ratio_max*cover_fract(:,9,:,:)
   ;crops
   coverfraction(:,8,:,:)=veg_ratio_max*cover_fract(:,10,:,:)
   ;managed
   coverfraction(:,9,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,8:10,:,:),1)
   ;natural
   coverfraction(:,10,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:7,:,:),1)

   ;total land
   coverfraction(:,11,:,:)=1.-veg_ratio_max+veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:10,:,:),1)

   print("get covers done")

   if (opt@full .eq. True) then
     return coverfraction
   else 
      return dim_avg_n_Wrap(coverfraction,0)
   end if


end


undef ("get_coverfraction8t")
function get_coverfraction8t (opt:logical)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin

   if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
   end if

    data=addfile(opt@fn, "r")

    dims=dimsizes(data->veg_fract_correction(:,:,:,:))
    ntimes=dims(0)
    ntiles=dims(1)
    nlat=dims(2)
    nlon=dims(3)

   if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
      fidx=opt@fidx
      lidx=opt@lidx
      print("averaging period from: "+fidx+" to "+lidx)
   else
      print("taking all timesteps")
      fidx=0
      lidx=ntimes-1
   end if


   if ( .not. (isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2")) ) then
      opt@lon1=data->lon(0)
      opt@lon2=data->lon(nlon-1)
      opt@lat1=data->lat(0)
      opt@lat2=data->lat(nlat-1)
   end if


   print(opt@lon1+" "+opt@lon2+" "+opt@lat1+" "+opt@lat2)

   ;full4d
   tmp_full_cover_fract=data->cover_fract(fidx:lidx,:,:,:)
   tmp_full_veg_fract_correction=data->veg_fract_correction(fidx:lidx,:,:,:)
   ;full3d
   tmp_full_veg_ratio_max=data->veg_ratio_max(fidx:lidx,:,:)

;{opt@lat1:opt@lat2},{opt@lon1:opt@lon2}

   if (opt@lon1 .lt. 0 ) then
         tmp_full_cover_fract=lonFlip(tmp_full_cover_fract)
         tmp_full_veg_ratio_max=lonFlip(tmp_full_veg_ratio_max)
   end if

   cover_fract=tmp_full_cover_fract(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   veg_ratio_max=tmp_full_veg_ratio_max(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})

   delete(tmp_full_cover_fract)
   delete(tmp_full_veg_ratio_max)


   delete(dims)
   dims=dimsizes(cover_fract)
   ntimes=dims(0)
   ntiles=dims(1)
   nlat=dims(2)
   nlon=dims(3)

   coverfraction=new((/ntimes,12,nlat,nlon/),float,MyFillValue)
   copy_VarAtts(cover_fract,coverfraction)
   latunit=cover_fract&lat@units
   lonunit=cover_fract&lon@units

   coverfraction!0="time"
   coverfraction!1="pfts"
   coverfraction!2="lat"
   coverfraction!3="lon"

   coverfraction&lat=cover_fract&lat
   coverfraction&lon=cover_fract&lon
   coverfraction&lat@units=latunit
   coverfraction&lon@units=lonunit


   ;desert
   coverfraction(:,0,:,:)=1.-veg_ratio_max
   ;woody
   coverfraction(:,1,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:5,:,:),1)
   ;tree
   coverfraction(:,2,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:3,:,:),1)
   ;shrubs
   coverfraction(:,3,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,4:5,:,:),1)
   ;grass
   coverfraction(:,4,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,6:7,:,:),1)

   ;total land
   coverfraction(:,5,:,:)=1.-veg_ratio_max+veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:7,:,:),1)

   if (opt@full .eq. True) then
     return coverfraction

   else
      return dim_avg_n_Wrap(coverfraction,0)
   end if


end





undef ("get_coverfraction_1d_ts")
function get_coverfraction_1d_ts (opt:logical)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin

   if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
   end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->veg_fract_correction(:,:,:,:))
    ntimes=dims(0)
    ntiles=dims(1)
    nlat=dims(2)
    nlon=dims(3)


;print("averaging period from: "+opt@fyear+" to "+opt@lyear)

;1d
   if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
      fidx=opt@fidx
      lidx=opt@lidx
      print("taking period from: "+fidx+" to "+lidx)
   else
      print("taking all timesteps")
      fidx=0
      lidx=ntimes-1
   end if


   ;full4d
    tmp_cover_fract=data->cover_fract(fidx:lidx,:,:,:)
    tmp_veg_fract_correction=data->veg_fract_correction(fidx:lidx,:,:,:)
   ;full 3d
    tmp_veg_ratio_max=data->veg_ratio_max(fidx:lidx,:,:)

    ; if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
    ;     if (opt@lon1 .lt. 0 ) then
    ;         tmp_cover_fract=lonFlip(tmp_cover_fract)
    ;         tmp_veg_fract_correction=lonFlip(tmp_veg_fract_correction)
    ;         tmp_veg_ratio_max=lonFlip(tmp_veg_ratio_max)
    ;     end if
    ; else
    ;     print("global field will be taken")
    ; end if


   ;4d
   cover_fract=tmp_cover_fract(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   veg_fract_correction=tmp_veg_fract_correction(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   ;3d
   veg_ratio_max=tmp_veg_ratio_max(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})


   area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
   size_land=dim_sum(dim_sum(area))
   ;print("size region: "+size_land)


   if (ntiles.ne.11) then
        print ("version does only work with 11 tiles!!! EXIT !!!")
        exit ;;
   end if

   delete(dims)
   dims=dimsizes(veg_fract_correction)
   ntimes=dims(0)
   ntiles=dims(1)
   nlat=dims(2)
   nlon=dims(3)

   coverfraction=new((/ntimes,14,nlat,nlon/),typeof(cover_fract),MyFillValue)

   copy_VarAtts(cover_fract,coverfraction)
   latunit=cover_fract&lat@units
   lonunit=cover_fract&lon@units
   coverfraction!0="time"
   coverfraction!1="pfts"
   coverfraction!2="lat"
   coverfraction!3="lon"
   coverfraction&time=cover_fract&time
   coverfraction&lat=cover_fract&lat
   coverfraction&lon=cover_fract&lon
   coverfraction&lat@units=latunit
   coverfraction&lon@units=lonunit

   ;desert
   coverfraction(:,0,:,:)=1.-veg_ratio_max
   ;woody
   coverfraction(:,1,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:5,:,:),1)
   ;tree
   coverfraction(:,2,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:3,:,:),1)
   ;shrubs
   coverfraction(:,3,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,4:5,:,:),1)
   ;grass
   coverfraction(:,4,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,6:7,:,:),1)
   
   ;grass C3
   coverfraction(:,12,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,6,:,:),1)
   ;grass C4
   coverfraction(:,13,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,6,:,:),1)
   
   
   ;c3 pasture+c4 pasture
   coverfraction(:,5,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,8:9,:,:),1)
   ;c3 pasture
   coverfraction(:,6,:,:)=veg_ratio_max*cover_fract(:,8,:,:)
   ;c4 pasture
   coverfraction(:,7,:,:)=veg_ratio_max*cover_fract(:,9,:,:)
   ;crops
   coverfraction(:,8,:,:)=veg_ratio_max*cover_fract(:,10,:,:)
   ;managed
   coverfraction(:,9,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,8:10,:,:),1)
   ;natural
   coverfraction(:,10,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:7,:,:),1)

   ;total land
   coverfraction(:,11,:,:)=1.-veg_ratio_max+veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:10,:,:),1)




   cregion=conform_dims(dimsizes(coverfraction),area,(/2,3/))

   ; size in 2 and percentag (area weighted)
   covers=(/dim_sum_n_Wrap((coverfraction(:,:,:,:)*(cregion)),(/2,3/)), \
            dim_sum_n_Wrap(coverfraction(:,:,:,:)*(cregion),(/2,3/))/size_land /)


   covers!1="time"
   covers!2="pfts"

;    printVarSummary(covers)
;
;   covers&time=data->time

   return covers
end



undef ("get_fakecoverfraction_1d_ts")
function get_fakecoverfraction_1d_ts (opt:logical)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin

   if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
   end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->veg_fract_correction(:,:,:,:))
    ntimes=dims(0)
    ntiles=dims(1)
    nlat=dims(2)
    nlon=dims(3)


;print("averaging period from: "+opt@fyear+" to "+opt@lyear)

;1d
   if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
      fidx=opt@fidx
      lidx=opt@lidx
      print("taking period from: "+fidx+" to "+lidx)
   else
      print("taking all timesteps")
      fidx=0
      lidx=ntimes-1
   end if


   ;full4d
    tmp_cover_fract=data->cover_fract(fidx:lidx,:,:,:)
    tmp_veg_fract_correction=data->veg_fract_correction(fidx:lidx,:,:,:)
   ;full 3d
    tmp_veg_ratio_max=data->veg_ratio_max(fidx:lidx,:,:)

    if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
        if (opt@lon1 .lt. 0 ) then
            tmp_cover_fract=lonFlip(tmp_cover_fract)
            tmp_veg_fract_correction=lonFlip(tmp_veg_fract_correction)
            tmp_veg_ratio_max=lonFlip(tmp_veg_ratio_max)
        end if
    else
        print("global field will be taken")
    end if


   ;4d
   cover_fract=tmp_cover_fract(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   veg_fract_correction=tmp_veg_fract_correction(:,:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   ;3d
   veg_ratio_max=tmp_veg_ratio_max(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})


   area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
   size_land=dim_sum(dim_sum(area))
   ;print("size region: "+size_land)


   if (ntiles.ne.11) then
        print ("version does only work with 11 tiles!!! EXIT !!!")
        exit ;;
   end if

   delete(dims)
   dims=dimsizes(veg_fract_correction)
   ntimes=dims(0)
   ntiles=dims(1)
   nlat=dims(2)
   nlon=dims(3)

   coverfraction=new((/ntimes,12,nlat,nlon/),typeof(cover_fract),MyFillValue)

   copy_VarAtts(cover_fract,coverfraction)
   latunit=cover_fract&lat@units
   lonunit=cover_fract&lon@units
   coverfraction!0="time"
   coverfraction!1="pfts"
   coverfraction!2="lat"
   coverfraction!3="lon"
   coverfraction&time=cover_fract&time
   coverfraction&lat=cover_fract&lat
   coverfraction&lon=cover_fract&lon
   coverfraction&lat@units=latunit
   coverfraction&lon@units=lonunit


   ;desert
   coverfraction(:,0,:,:)=1.-veg_ratio_max
   ;woody
   coverfraction(:,1,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:5,:,:),1)
   ;tree
   coverfraction(:,2,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:3,:,:),1)
   ;shrubs
   coverfraction(:,3,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,4:5,:,:),1)
   ;grass
   coverfraction(:,4,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,6:7,:,:),1)

   lats=cover_fract&lat(:)
   lons=cover_fract&lon(:)
   nlat=dimsizes(lats)
   nlon=dimsizes(lons)


   ;c3 pasture+c4 pasture
   coverfraction(:,5,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,8:9,:,:),1)
   ;c3 pasture
   coverfraction(:,6,:,:)=veg_ratio_max*cover_fract(:,8,:,:)
   ;c4 pasture
   coverfraction(:,7,:,:)=veg_ratio_max*cover_fract(:,9,:,:)
   ;crops
   coverfraction(:,8,:,:)=veg_ratio_max*cover_fract(:,10,:,:)

   print(nlat+" "+nlon)
   ;print(lats)
   ;print(lons)
   do ilat=0,nlat-1
;       print("current grid box: "+ilat+" "+lats(ilat)+"    "+ilon+" "+lons(ilon))
       if ((lats(ilat).gt.4).and.(lats(ilat).lt.20)) then
           do ilon=0,nlon-1
               if ((lons(ilon).gt.340)  .or.  (lons(ilon).lt.40)) then
                  print("Here is fake: "+ilat+" "+lats(ilat)+"    "+ilon+" "+lons(ilon))
                  ;c3 pasture+c4 pasture
                  coverfraction(:,5,ilat,ilon)=0.
                  ;c3 pasture
                  coverfraction(:,6,ilat,ilon)=0.
                  ;c4 pasture
                  coverfraction(:,7,ilat,ilon)=0.
                  ;crops
                  coverfraction(:,8,ilat,ilon)=veg_ratio_max(:,ilat,ilon)*dim_sum_n_Wrap(cover_fract(:,8:10,ilat,ilon),1)
            end if
           end do
       end if
   end do



   ;managed
   coverfraction(:,9,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,8:10,:,:),1)
   ;natural
   coverfraction(:,10,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:7,:,:),1)

   ;total land
   coverfraction(:,11,:,:)=1.-veg_ratio_max+veg_ratio_max*dim_sum_n_Wrap(cover_fract(:,0:10,:,:),1)

   cregion=conform_dims(dimsizes(coverfraction),area,(/2,3/))

   ; size in 2 and percentag (area weighted)
   covers=(/dim_sum_n_Wrap(doubletofloat(coverfraction(:,:,:,:)*doubletofloat(cregion)),(/2,3/)), \
            dim_sum_n_Wrap(coverfraction(:,:,:,:)*doubletofloat(cregion),(/2,3/))/size_land /)


   printVarSummary(covers)
   printVarSummary(data->time)

   covers!1="time"
   covers!2="pfts"

   ;covers&time=data->time

   return covers
end

undef ("get_coverfraction_diff")
function get_coverfraction_diff (fn1,fn2:string)
local fire1, fire2, latunit, lonunit
begin
   coverfraction1=get_coverfraction(fn1)
   coverfraction2=get_coverfraction(fn2)
   coverfraction=coverfraction1-coverfraction2

   copy_VarAtts(coverfraction1,coverfraction)
   latunit=coverfraction1&lat@units
   lonunit=coverfraction1&lon@units
   coverfraction!0="pfts"
   coverfraction!1="lat"
   coverfraction!2="lon"
   coverfraction&lat=coverfraction1&lat
   coverfraction&lon=coverfraction1&lon
   coverfraction&lat@units=latunit
   coverfraction&lon@units=lonunit

   return coverfraction
end



undef ("get_totalprecipitation")
function get_totalprecipitation (fn,conversion:string)
begin
   data=addfile(fn, "r")

   ;2d
   prec_rain=dim_avg_n_Wrap(data->precip_rain(:,:,:),0)
   prec_snow=dim_avg_n_Wrap(data->precip_snow(:,:,:),0)

   prec=prec_rain
   prec=prec_rain+prec_snow
   prec=convert_prec(prec,conversion)
   return prec
end




undef ("get_precipitation")
function get_precipitation (fn,conversion:string)
begin
   data=addfile(fn, "r")

   ;2d
   prec=dim_avg_n_Wrap(data->precip(:,:,:),0)
   prec=convert_prec(prec,conversion)
   return prec
end



undef ("get_precipitation_echam2d")
function get_precipitation_echam2d (fn,conversion:string)
begin
   data=addfile(fn, "r")

   ;2d
   precl2d=dim_avg_n_Wrap(data->aprl(:,:,:),0)
   precc2d=dim_avg_n_Wrap(data->aprc(:,:,:),0)

   prec=precl2d+precc2d
   prec=convert_prec(prec,conversion)

   return prec
end



undef ("get_precipitation_echam3d")
function get_precipitation_echam3d (opt:logical)
begin
    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    dims=dimsizes(data->aprl(:,:,:))
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("taking period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

    if (opt@full3d .eq. True) then
      tmp_aprl=data->aprl(fidx:lidx,:,:)
      tmp_aprc=data->aprc(fidx:lidx,:,:)
      if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
         if (opt@lon1 .lt. 0 ) then
            tmp_aprl=lonFlip(tmp_aprl)
            tmp_aprc=lonFlip(tmp_aprc)
         end if
         precl2d=tmp_aprl(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
         precc2d=tmp_aprc(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
      else
         print("global field will be taken")
         precl2d=tmp_aprl
         precc2d=tmp_aprc
      end if
      prec=precl2d+precc2d
      prec=convert_prec(prec,opt@conversion)
      latunit=precl2d&lat@units
      lonunit=precl2d&lon@units
      prec!0="time"
      prec!1="lat"
      prec!2="lon"
  else
      ; full 2d precipitation
      tmp_aprl=dim_avg_n_Wrap(data->aprl(fidx:lidx,:,:),0)
      tmp_aprc=dim_avg_n_Wrap(data->aprc(fidx:lidx,:,:),0)

      if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
          if (opt@lon1 .lt. 0 ) then
              tmp_aprl=lonFlip(tmp_aprl)
              tmp_aprc=lonFlip(tmp_aprc)
          end if
          ;2d
         precl2d=tmp_aprl({opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
         precc2d=tmp_aprc({opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
      else
          print("global field will be taken")

          ;2d
         precl2d=tmp_aprl
         precc2d=tmp_aprc
      end if

      prec=precl2d+precc2d
      prec=convert_prec(prec,opt@conversion)

      latunit=precl2d&lat@units
      lonunit=precl2d&lon@units

      prec!0="lat"
      prec!1="lon"
    end if

    prec&lat=precl2d&lat
    prec&lon=precl2d&lon
    prec&lat@units=latunit
    prec&lon@units=lonunit


    return prec
end





undef ("get_co2_1d")
function get_co2_1d (fn:string,runaverage:logical,naverage:integer)
begin
    data=addfile(fn, "r")
    input=data->CO2_concentr(:,:,:)
    co2=input(:,0,0)
    ntime=dimsizes(data->time(:))
    if ( runaverage .eq. True ) then
       co2_1d=new((/2,ntime/),typeof(co2),MyFillValue)
       co2_1d(0,:) = co2
       co2_1d(1,:) = runave(co2_1d(0,:),naverage,0)
   else
       co2_1d=new((/ntime/),typeof(co2),MyFillValue)
       co2_1d(:) = co2
   end if
    printVarSummary(co2_1d)
    return co2_1d
end


undef ("get_ecc_1d")
function get_ecc_1d (fn:string)
begin
    data=addfile(fn, "r")
    input=data->eccentricity(:)
    ecc=input(:)

    printVarSummary(ecc)
    return ecc
end





undef ("get_prec_1d")
function get_prec_1d (fn,res,conversion:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
begin
    data=addfile(fn, "r")
    ;3d
    ;time lat lon
    nlonfull=dimsizes(data->lon(:))
    nlatfull=dimsizes(data->lat(:))
    ntime=dimsizes(data->time(:))

    lons=get_lons(res,lon1,lon2)
    prec = data->precip(:,{lat1:lat2},lons)
    area=get_area_land(res,lon1,lon2,lat1,lat2)
    carea=conform_dims(dimsizes(prec),area,(/1,2/))
    regionalsize=dim_sum_n_Wrap(carea,(/1,2/))

    dims=dimsizes(prec)
    rank=dimsizes(dims)
    ntime=dims(rank-3)
    nlat=dims(rank-2)
    nlon=dims(rank-1)

    if ( runaverage .eq. True ) then
       prec1d=new((/2,ntime/),typeof(prec),MyFillValue)
       prec1d(0,:) = dim_sum_n_Wrap(prec*carea,(/rank-2,rank-1/))/regionalsize
       prec1d(1,:) = runave(prec1d(0,:),naverage,0)
   else
       prec1d=new((/ntime/),typeof(prec),MyFillValue)
       prec1d(:) = dim_sum_n_Wrap(prec*carea,(/rank-2,rank-1/))/regionalsize
   end if
   prec1d=convert_prec(prec1d,conversion)

   return prec1d
end





undef ("get_temperature")
function get_temperature (fn,units:string)
begin
   data=addfile(fn, "r")

   ;2d
   temp=dim_avg_n_Wrap(data->air_temp(:,:,:),0)
   if (max(temp) .lt. 100 ) then
	   temp@units="C"
   else
	   temp@units="K"
   end if
   printVarSummary(temp)

   ;units=temp&units
   ;temp@units=units
   ;area=get_area_land("T31",-180.,180.,-90,90)
   ;tmean=temp*area/(dim_sum_Wrap(area))
   ;print("tmean: "+temp)
   return temp
end


undef ("get_temperature3d")
function get_temperature3d (opt:logical)
begin
    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")
    if (opt@stream.eq."echam") then
        temp=data->temp2(:,:,:)
    end if
    if (opt@stream.eq."jsbach") then
        temp=data->air_temp(:,:,:)
    end if

    dims=dimsizes(temp)
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("averaging period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

;    if (isatt(opt,"region") then
;        print("region is defined")
;
;    else
;        if ( isatt(opt,"lon1")  .and. isatt(opt,"lon2") .and. isatt(opt,"lat1") .and. isatt(opt,"lat2") ) then
;            if (opt@lon1 .lt. 0 ) then
;                temp=lonFlip(temp)
;            end if
;        else
;            print("global field will be taken")
;        end if
;    end if

; full 3d
   ;temp3d=temp(fidx:lidx,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})
   temp3d=temp(fidx:lidx,:,:)
; 2d
   temp2d=dim_avg_n_Wrap(temp3d,0)

    temp2d@units=opt@conversion

   if (opt@conversion.eq."C") then
       if (min(temp).gt.180 ) then
            temp3d=temp3d-273.15
            temp2d=temp2d-273.15
       end if
   end if
   if (opt@conversion.eq."K") then
       if (max(temp).lt.180) then
            temp3d=temp3d+273.15
            temp2d=temp2d+273.15
       end if
   end if

;   printVarSummary(temp3d)


   if ( opt@full3d.eq.True ) then
      return temp3d
   else
      return dim_avg_n_Wrap(temp3d,0)
   end if
end



undef ("get_temp_1d")
function get_temp_1d (fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
begin
    data=addfile(fn, "r")
    ;3d
    ;time lat lon
    nlonfull=dimsizes(data->lon(:))
    nlatfull=dimsizes(data->lat(:))
    ntime=dimsizes(data->time(:))
    ;3d
    lons=get_lons(res,lon1,lon2)
    temp=data->air_temp(:,{lat1:lat2},lons)
    area=get_area_land(res,lon1,lon2,lat1,lat2)
    size_land=dim_sum(dim_sum(area))
    print("size region: "+size_land)

    cregion=conform_dims(dimsizes(temp),area,(/1,2/))

    dims=dimsizes(temp)
    rank=dimsizes(dims)
    ntime=dims(rank-3)
    nlat=dims(rank-2)
    nlon=dims(rank-1)
    if ( runaverage .eq. True ) then
       temp1d=new((/2,ntime/),typeof(temp),MyFillValue)
       temp1d(0,:) = dim_sum_n_Wrap(temp*cregion,(/rank-2,rank-1/))/size_land
       temp1d(1,:) = runave(temp1d(0,:),naverage,0)
   else
       temp1d=new((/ntime/),typeof(temp),MyFillValue)
       temp1d(:) = dim_sum_n_Wrap(temp*cregion,(/rank-2,rank-1/))/size_land
   end if

   return temp1d
end



undef ("get_temp_1d_ts")
function get_temp_1d_ts (opt:logical)
begin
    ;fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer
    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")

    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("data period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

   if (opt@stream.eq."echam") then
        tmp_temp=data->temp2(:,:,:)
    end if
    if (opt@stream.eq."jsbach") then
        tmp_temp=data->air_temp(:,:,:)
    end if


    dims=dimsizes(tmp_temp)
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if (opt@lon1 .lt. 0) then
        tmp_temp2d=lonFlip(tmp_temp)
    else
        tmp_temp2d=tmp_temp
    end if


    temp2d     = tmp_temp2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})

   delete (dims)
   dims=dimsizes(temp2d)
   ntime=dims(0)
   nlat=dims(1)
   nlon=dims(2)


    area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
    size_land=dim_sum(dim_sum(area))
    ;print("size region: "+size_land)
    cregion=conform_dims(dimsizes(temp2d),area,(/1,2/))


    temp1d=new((/ntime,2/),typeof(temp2d),MyFillValue)

    temp1d(:,0) = dim_sum_n_Wrap(temp2d*doubletofloat(cregion),(/1,2/))/doubletofloat(size_land)
    temp1d(:,1) = runave(temp1d(:,0),opt@naverage,0)


    if (opt@conversion.eq."C") then
       if (min(temp1d).gt.180 ) then
            temp1d=temp1d-273.15
       end if
   end if
   if (opt@conversion.eq."K") then
       if (max(temp1d).lt.180) then
            temp1d=temp1d+273.15
       end if
   end if

   temp1d!0="time"
   temp1d&time=data->time(fidx:lidx)

   return temp1d
end




undef ("get_prec_1d_ts")
function get_prec_1d_ts (opt:logical)
begin
    ;fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer
    if (opt@fn.eq."") then
        print("no filename set! EXIT")
        exit ;;
    end if
    data=addfile(opt@fn, "r")
    if ( isatt(opt,"lidx")  .and. isatt(opt,"fidx")) then
        fidx=opt@fidx
        lidx=opt@lidx
        print("data period from: "+fidx+" to "+lidx)
    else
        print("taking all timesteps")
        fidx=0
        lidx=ntimes-1
    end if

   if (opt@stream.eq."echam") then
        tmp_prec=data->aprl(fidx:lidx,:,:)
        tmp_prec=tmp_prec+data->aprc(fidx:lidx,:,:)
    end if
    if (opt@stream.eq."jsbach") then
        tmp_prec=data->prec(fidx:lidx,:,:)
    end if

    dims=dimsizes(tmp_prec)
    ntimes=dims(0)
    nlat=dims(1)
    nlon=dims(2)

    if (opt@lon1 .lt. 0) then
        tmp_prec2d=lonFlip(tmp_prec)
    else
        tmp_prec2d=tmp_prec
    end if

    prec2d     = tmp_prec2d(:,{opt@lat1:opt@lat2},{opt@lon1:opt@lon2})

   delete (dims)
   dims=dimsizes(prec2d)
   ntime=dims(0)
   nlat=dims(1)
   nlon=dims(2)


    area=get_area_land(opt@res,opt@lon1,opt@lon2,opt@lat1,opt@lat2)
    size_land=dim_sum(dim_sum(area))
    ;print("size region: "+size_land)
    cregion=conform_dims(dimsizes(prec2d),area,(/1,2/))


    prec1d=new((/ntime,2/),typeof(prec2d),MyFillValue)

    prec1d(:,0) = dim_sum_n_Wrap(prec2d*doubletofloat(cregion),(/1,2/))/doubletofloat(size_land)
    prec1d(:,1) = runave(prec1d(:,0),opt@naverage,0)
    prec1d=convert_prec(prec1d,opt@conversion)



   prec1d!0="time"
   prec1d&time=data->time(fidx:lidx)

   return prec1d
end





undef ("get_precipitation_diff")
function get_precipitation_diff (fn1,fn2,conversion:string)
local prec1,prec2
begin
   ;2d
   prec1=get_precipitation(fn1,conversion)
   prec2=get_precipitation(fn2,conversion)


   dims=dimsizes(prec1)
   nlat=dims(0)
   nlon=dims(1)
   prec_diff=new((/nlat,nlon/),float,MyFillValue)

   prec_diff=prec1-prec2
   copy_VarAtts(prec1,prec_diff)

   prec_diff!0="lat"
   prec_diff!1="lon"
   prec_diff&lat=prec1&lat
   prec_diff&lon=prec1&lon
   return prec_diff
end



undef ("get_temperature_diff")
function get_temperature_diff (fn1,fn2,units:string)
local temp1,temp2
begin
   ;2d
   temp1=get_temperature(fn1,units)
   temp2=get_temperature(fn2,units)

   dims=dimsizes(temp1)
   nlat=dims(0)
   nlon=dims(1)
   temp_diff=new((/nlat,nlon/),float,MyFillValue)

   temp_diff=temp1-temp2

   copy_VarAtts(temp1,temp_diff)
   latunit=temp1&lat@units
   lonunit=temp1&lon@units
   temp_diff!0="lat"
   temp_diff!1="lon"
   temp_diff&lat=temp1&lat
   temp_diff&lon=temp1&lon
   temp_diff&lat@units=latunit
   temp_diff&lon@units=lonunit
   temp_diff@units=units
   return temp_diff
end


undef ("get_tmin")
function get_tmin (fn:string)
begin
   data=addfile(fn, "r")

   ;2d
   temp=dim_avg_n_Wrap(data->tmin(:,:,:),0)
   return temp
end



undef ("get_tmax")
function get_tmax (fn:string)
begin
   data=addfile(fn, "r")

   ;2d
   temp=dim_avg_n_Wrap(data->tmax(:,:,:),0)
   return temp
end



undef("get_edc_domec_data")
function get_edc_domec_data(tstart,tend:integer)
local edc
begin
    fn=LIBPATH+"CO2_HighResolutionTaylorDomeIceCore.txt"
    ; skip header and docu - 9 lines
    data=asciiread(fn,-1,"string")
    ncolumns = str_fields_count(data(9)," ")
    nlines = dimsizes(data)

    edc=True
    edc@depth=stringtofloat(str_get_field(data(9:), 1," "))
    edc@age=stringtofloat(str_get_field(data(9:), 2," "))
    edc@co2=stringtofloat(str_get_field(data(9:), 3," "))
    edc@sigma=stringtofloat(str_get_field(data(9:), 4," "))

    return edc
end





undef ("get_marlondata")
function get_marlondata(fn)
begin
    ;read full data into string and convert afterwards
    fulldata = asciiread(fn,-1,"string")

    ncolumns = str_fields_count(fulldata(1),", ")
    nlines = dimsizes(fulldata) ;(there is one line of header)
    print(fn + " -- number of columns = " + ncolumns)
    print(fn + " -- number of lines   = " + nlines)


   ; Skip first row of "data" because it's just a header line.
   ; Use a colon (",") as a delimiter in str_get_field. The first
   ; field is field=1 (unlike str_get_cols, in which the first column
   ; is column=0).
   ; first two columns "A" (cal yr BP) and "B" (charcoal index) are plotted and then "J" (10) and "K" (11)

    offset=39

    years=new(nlines-1-offset,float)
    influx=new(nlines-1-offset,float)
    cup=new(nlines-1-offset,float)
    cdown=new(nlines-1-offset,float)
    nsites=new(nlines-1-offset,float)
    years = stringtofloat(str_get_field(fulldata(27:nlines-14), 1,","))*-1
    influx = stringtofloat(str_get_field(fulldata(27:nlines-14), 2,", "))
    cup = stringtofloat(str_get_field(fulldata(27:nlines-14), 10,", "))
    cdown = stringtofloat(str_get_field(fulldata(27:nlines-14), 11,", "))
    nsites = stringtofloat(str_get_field(fulldata(27:nlines-14), 12,", "))

    data=True
    data@nlines=nlines-1
    data@ctime=years
    data@influx=influx
    data@cup=cup
    data@cdown=cdown
    data@nsites=nsites
    return data
end




undef ("get_climbazscoredata")
function get_climbazscoredata (fn)
local data
begin

    infile=addfile(fn, "r")
    ;1d
    ;time
    data=True
    data@mtime=infile->time
    data@ntime=dimsizes(infile->time(:))
    data@zbarea=infile->zbarea
    data@barea=infile->barea
    data@zcflux=infile->zcflux
    data@cflux=infile->cflux
    return data
end

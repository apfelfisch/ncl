load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"


MyFillValue=-9e+33

begin
    mainpath="/Volumes/work/m300107/wtab_wfrac_prec/"
    fnmprec=mainpath+"mprec.nc"
    fnmtemp=mainpath+"mtemp.nc"
    fnmwfrac=mainpath+"mwfrac_tab.nc"
    fnwfrac=mainpath+"wfrac.nc"

    f=addfile(fnmprec,"r")
    prec_data=f->mprec(:,:,:,:)
    printVarSummary(prec_data)

    f=addfile(fnmtemp,"r")
    temp_data=f->mtemp(:,:,:,:)
    printVarSummary(temp_data)

    f=addfile(fnmwfrac,"r")
    wfrac_data=f->mwfrac_tab(:,:,:,:)
    printVarSummary(wfrac_data)

    wfrac_data=where(wfrac_data.lt.-1.5.or.wfrac_data.gt.1.5,MyFillValue,wfrac_data)

    lon=f->longitude
    lat=f->latitude
   


    dims=dimsizes(prec_data)
    nyear=dims(0)
    nmonth=dims(1)
    nlat=dims(2)
    nlon=dims(3)

    ntimes=nyear*nmonth
    prec=new((/ntimes,nlat,nlon/),float,MyFillValue)
    temp=new((/ntimes,nlat,nlon/),float,MyFillValue)
    wfrac=new((/ntimes,nlat,nlon/),float,MyFillValue)


    do iyear=0,nyear-1
        do imonth=0,nmonth-1
            step=iyear*nmonth+imonth
            prec(step,:,:)=prec_data(iyear,imonth,:,:)
            temp(step,:,:)=temp_data(iyear,imonth,:,:)
            wfrac(step,:,:)=wfrac_data(iyear,imonth,:,:)
            ntime=step
        end do
    end do


    time=new((/ntime+1/),float,MyFillValue)
    printVarSummary(time)
    time=fspan(0, 359, 1)
    

    printVarSummary(prec)
    printVarSummary(temp)
    printVarSummary(wfrac)

    ; write down the file:

;===================================================================  

        diro = "./"                     ; Output directory
        filo = "wfrac_prec_temp.nc"             ; Output file
	system("/bin/rm -f " + diro + filo)    ; remove if exists
	fout  = addfile (diro + filo, "c")  ; open output file

    ;===================================================================
    ; explicitly declare file definition mode. Improve efficiency.
    ;===================================================================
        setfileoption(fout,"DefineMode",True)

    ;===================================================================
    ; create global attributes of the file
    ;===================================================================
        fAtt               = True            ; assign file attributes
	fAtt@Conventions   = "None"   
	fAtt@creation_date = systemfunc ("date")        
	fileattdef( fout, fAtt )            ; copy file attributes    

    ;===================================================================
    ; predefine the coordinate variables and their dimensionality
    ; Note: to get an UNLIMITED record dimension, we set the dimensionality
    ; to -1 (or the actual size) and set the dimension name to True.
    ;===================================================================
        dimNames = (/"time", "latitude", "longitude"/)  
	dimSizes = (/ -1   ,  nlat,  nlon/) 
	dimUnlim = (/ True , False, False/)   
	filedimdef(fout,dimNames,dimSizes,dimUnlim)

    ;===================================================================
    ; predefine the the dimensionality of the variables to be written out
    ;===================================================================
    ; Here we are using NCL functions to facilitate defining 
    ; each variable's dimension name(s) and type. 
    ; The following could be replaced with explicit, user defined dimension 
    ; names different from those associated with the variable in memory. 
    ; Say, PS(time,lat,lon) in the NCL script. They could be redefined for the file via: 
    ; filevardef(fout, "PS"   ,typeof(PS) ,(/"TIME","latitude","longitude"/)) 
    ;===================================================================
       filevardef(fout, "time" ,"float",(/"time"/)) 
       filevardef(fout, "lat"  ,typeof(lat),getvardims(lat))                          
       filevardef(fout, "lon"  ,typeof(lon),getvardims(lon))                          
       filevardef(fout, "temp" ,"float",getvardims(temp))    
       filevardef(fout, "prec" ,"float",getvardims(prec))          
       filevardef(fout, "wfrac","float",getvardims(wfrac))  ; variable name on the file                
                                                              ; different from name on script
    ;===================================================================
    ; Copy attributes associated with each variable to the file
    ; All attributes associated with each variable will be copied.
    ;====================================================================
       filevarattdef(fout,"temp",temp)                           ; copy temp attributes
       filevarattdef(fout,"time" ,time)                    ; copy time attributes
       filevarattdef(fout,"lat"  ,lat)                     ; copy lat attributes
       filevarattdef(fout,"lon"  ,lon)                     ; copy lon attributes
       filevarattdef(fout,"prec"   ,prec)                      ; copy prec attributes
       filevarattdef(fout,"wfrac",wfrac)                     ; copy wfrac attributes

    ;===================================================================
    ; explicitly exit file definition mode. **NOT REQUIRED**
    ;===================================================================
        setfileoption(fout,"DefineMode",False)

    ;===================================================================
    ; output only the data values since the dimensionality and such have
    ; been predefined. The "(/", "/)" syntax tells NCL to only output the
    ; data values to the predefined locations on the file.
    ;====================================================================

       printVarSummary(lat)
       printVarSummary(time)
       
      istep=0
      do iyear=1,30
        do imonth=1,12

            time(istep)=(1849+iyear)*100+imonth
            istep=istep+1

        end do
    end do
 
    print(time)

       fout->time   = (/time/)     
       fout->lat    = (/lat/)
       fout->lon    = (/lon/) 
       fout->prec   = (/prec/)
       fout->temp   = (/temp/)
       fout->wfrac  = (/wfrac/)

end

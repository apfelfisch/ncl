load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"


; constants
MyFillValue=-9e+33


undef ("def_colormap")
function def_colormap ()
local cmap
begin
   ; ###============================================================           
   ; ###
   ; ### color table for climba plots
   ; ###
   ; ### 2012 Tim Bruecher
   ; ###
   ; ###============================================================           
   ; # white                        #            0
   ; # black                        #            1
   ; # abs. carbon pool             # 11 colors  2 -> 12
   ; # dif. carbon pool             # 13 colors 13 -> 25
   ; # abs. cover fraction          # 12 colors 26 -> 37
   ; # dif. cover fraction          # 13 colors 38 -> 50
   ; # abs. desert fraction         # 12 colors 51 -> 62
   ; # dif. desert fraction         # 13 colors 63 -> 75
   ; # abs. fire fraction           # 10 colors 76 -> 85
   ; # dif. fire fraction           # 11 colors 86 -> 96
   ; # abs. precipitation           #  7 colors 97 -> 103
   ; # dif. precipitation           # 13 colors 104 -> 116
   ; # precipitation (brown->bue)   # 10 colors 117 -> 127 
   ; # temperature (blue->red)      # 14 colors 128 -> 139
   ; #
   ; ###============================================================
   cmap = (/ "(/ 1.000, 1.000, 1.000/)", \    ; color no     0 white
             "(/ 0.000, 0.000, 0.000/)", \    ; color no     1 black        ##============================================================    
             "(/ 0.949, 0.855, 0.804/)", \    ; color no     2 light brown  # carbon pool absolute values
             "(/ 0.898, 0.773, 0.698/)", \    ; color no     3              # number of colors in table
             "(/ 0.847, 0.686, 0.592/)", \    ; color no     4              # ncolors = 11
             "(/ 0.824, 0.647, 0.537/)", \    ; color no     5
             "(/ 0.800, 0.608, 0.478/)", \    ; color no     6
             "(/ 0.698, 0.494, 0.345/)", \    ; color no     7
             "(/ 0.600, 0.376, 0.208/)", \    ; color no     8
             "(/ 0.490, 0.282, 0.106/)", \    ; color no     9
             "(/ 0.400, 0.188, 0.000/)", \    ; color no    10
             "(/ 0.302, 0.145, 0.000/)", \    ; color no    11
             "(/ 0.200, 0.098, 0.000/)", \    ; color no    12 dark brown   ##============================================================    
             "(/ 0.094, 0.471, 0.612/)", \    ; color no    13 dark blue    # carbon pool differences
             "(/ 0.141, 0.659, 0.816/)", \    ; color no    14              # number of colors in table
             "(/ 0.282, 0.886, 1.000/)", \    ; color no    15              # ncolors = 13
             "(/ 0.447, 0.933, 1.000/)", \    ; color no    16
             "(/ 0.627, 0.969, 1.000/)", \    ; color no    17
             "(/ 0.812, 0.992, 1.000/)", \    ; color no    18
             "(/ 1.000, 1.000, 1.000/)", \    ; color no    19 white
             "(/ 0.945, 0.855, 0.796/)", \    ; color no    20
             "(/ 0.839, 0.690, 0.580/)", \    ; color no    21
             "(/ 0.792, 0.604, 0.459/)", \    ; color no    22
             "(/ 0.592, 0.380, 0.173/)", \    ; color no    23
             "(/ 0.392, 0.188, 0.000/)", \    ; color no    24
             "(/ 0.196, 0.094, 0.000/)", \    ; color no    25 dark brown   ##============================================================    
             "(/ 1.000, 1.000, 1.000/)", \    ; color no    26 white        # green cover fraction - absolute values - 
             "(/ 0.867, 0.937, 0.827/)", \    ; color no    27              # number of colors in table
             "(/ 0.737, 0.886, 0.663/)", \    ; color no    28              # ncolors = 12 colors
             "(/ 0.604, 0.831, 0.490/)", \    ; color no    29
             "(/ 0.475, 0.769, 0.329/)", \    ; color no    30
             "(/ 0.365, 0.722, 0.216/)", \    ; color no    31
             "(/ 0.267, 0.675, 0.020/)", \    ; color no    32
             "(/ 0.180, 0.631, 0.000/)", \    ; color no    33
             "(/ 0.145, 0.561, 0.000/)", \    ; color no    34
             "(/ 0.122, 0.475, 0.000/)", \    ; color no    35
             "(/ 0.094, 0.392, 0.051/)", \    ; color no    36
             "(/ 0.063, 0.310, 0.110/)", \    ; color no    37 dark green   ##============================================================    
             "(/ 0.502, 0.063, 0.541/)", \    ; color no    38 magenta      # cover fraction - differences - 
             "(/ 0.706, 0.102, 0.757/)", \    ; color no    39              # number of colors in table
             "(/ 0.910, 0.149, 0.976/)", \    ; color no    40              # ncolors = 13 colors
             "(/ 0.973, 0.294, 1.000/)", \    ; color no    41
             "(/ 0.980, 0.514, 1.000/)", \    ; color no    42
             "(/ 0.984, 0.729, 1.000/)", \    ; color no    43
             "(/ 1.000, 1.000, 1.000/)", \    ; color no    44 white
             "(/ 0.580, 0.992, 0.447/)", \    ; color no    45
             "(/ 0.424, 0.992, 0.000/)", \    ; color no    46
             "(/ 0.259, 0.945, 0.000/)", \    ; color no    47
             "(/ 0.200, 0.729, 0.000/)", \    ; color no    48
             "(/ 0.125, 0.525, 0.000/)", \    ; color no    49
             "(/ 0.055, 0.275, 0.000/)", \    ; color no    50 dark green   ##============================================================    
             "(/ 0.976, 0.957, 0.745/)", \    ; color no    51              # desert fraction - absolute values - 
             "(/ 0.965, 0.929, 0.690/)", \    ; color no    52              # number of colors in table 
             "(/ 0.949, 0.914, 0.627/)", \    ; color no    53              # ncolrs = 12 colors
             "(/ 0.922, 0.878, 0.533/)", \    ; color no    54
             "(/ 0.886, 0.827, 0.420/)", \    ; color no    55
             "(/ 0.855, 0.780, 0.298/)", \    ; color no    56
             "(/ 0.824, 0.714, 0.153/)", \    ; color no    57
             "(/ 0.808, 0.671, 0.000/)", \    ; color no    58
             "(/ 0.796, 0.616, 0.000/)", \    ; color no    59
             "(/ 0.714, 0.533, 0.000/)", \    ; color no    60
             "(/ 0.627, 0.439, 0.047/)", \    ; color no    61
             "(/ 0.529, 0.353, 0.125/)", \    ; color no    62              ##============================================================    
             "(/ 0.055, 0.310, 0.000/)", \    ; color no    63 dark green   # desert fraction - differences -  
             "(/ 0.125, 0.525, 0.000/)", \    ; color no    64              # number of colors in table
             "(/ 0.200, 0.729, 0.000/)", \    ; color no    65              # ncolors = 13 colors
             "(/ 0.259, 0.945, 0.000/)", \    ; color no    66
             "(/ 0.624, 0.992, 0.200/)", \    ; color no    67
             "(/ 0.780, 0.992, 0.447/)", \    ; color no    68
             "(/ 1.000, 1.000, 1.000/)", \    ; color no    69 white 
             "(/ 0.984, 0.729, 1.000/)", \    ; color no    70
             "(/ 0.980, 0.514, 1.000/)", \    ; color no    71
             "(/ 0.973, 0.294, 1.000/)", \    ; color no    72
             "(/ 0.910, 0.149, 0.976/)", \    ; color no    73
             "(/ 0.706, 0.102, 0.757/)", \    ; color no    74
             "(/ 0.502, 0.063, 0.541/)", \    ; color no    75 magente      ##============================================================    
             "(/ 1.000, 1.000, 1.000/)", \    ; color no    76 white        # fire absolute values
             "(/ 0.988, 0.953, 0.718/)", \    ; color no    77 yellow       # taken from WhiteYellowOrangeRed.rgb 
             "(/ 0.976, 0.878, 0.443/)", \    ; color no    78              # number of colors in table
             "(/ 0.973, 0.741, 0.184/)", \    ; color no    79              # ncolors=10
             "(/ 0.953, 0.569, 0.000/)", \    ; color no    80
             "(/ 0.922, 0.396, 0.035/)", \    ; color no    81
             "(/ 0.859, 0.235, 0.078/)", \    ; color no    82
             "(/ 0.776, 0.086, 0.102/)", \    ; color no    83
             "(/ 0.624, 0.043, 0.086/)", \    ; color no    84
             "(/ 0.475, 0.043, 0.063/)", \    ; color no    85              ##============================================================    
             "(/ 0.031, 0.078, 0.220/)", \    ; color no    86 dark blue    # fire differences
             "(/ 0.051, 0.251, 0.561/)", \    ; color no    87              # taken from temp_diff_18lev.rgb 
             "(/ 0.224, 0.486, 0.749/)", \    ; color no    88              # number of colors in table
             "(/ 0.306, 0.549, 0.776/)", \    ; color no    89              # ncolors = 11
             "(/ 0.616, 0.827, 0.886/)", \    ; color no    90
             "(/ 1.000, 1.000, 1.000/)", \    ; color no    91 white
             "(/ 0.961, 0.671, 0.592/)", \    ; color no    92
             "(/ 0.941, 0.329, 0.200/)", \    ; color no    93
             "(/ 0.882, 0.153, 0.098/)", \    ; color no    94
             "(/ 0.557, 0.000, 0.051/)", \    ; color no    95
             "(/ 0.282, 0.000, 0.000/)", \    ; color no    96 dark red     ##============================================================    
             "(/ 0.973, 0.973, 0.455/)", \    ; color no    97 yellow       # absolut precipitation
             "(/ 0.733, 0.875, 0.624/)", \    ; color no    98              # taken from lost-river paper 
             "(/ 0.463, 0.788, 0.776/)", \    ; color no    99              # number of colors in table
             "(/ 0.012, 0.702, 0.961/)", \    ; color no   100              # ncolors = 7
             "(/ 0.059, 0.443, 0.769/)", \    ; color no   101
             "(/ 0.027, 0.188, 0.561/)", \    ; color no   102
             "(/ 0.004, 0.059, 0.416/)", \    ; color no   103 blue         ##============================================================    
             "(/ 0.200, 0.094, 0.000/)", \    ; color no   104 brown        # differences in precipitation (lost-river) 
             "(/ 0.400, 0.184, 0.000/)", \    ; color no   105              # number of colors in table
             "(/ 0.600, 0.376, 0.208/)", \    ; color no   106              # ncolors = 13
             "(/ 0.800, 0.608, 0.478/)", \    ; color no   107
             "(/ 0.847, 0.686, 0.592/)", \    ; color no   108
             "(/ 0.949, 0.855, 0.804/)", \    ; color no   109
             "(/ 1.000, 1.000, 1.000/)", \    ; color no   110 white
             "(/ 0.800, 0.992, 0.996/)", \    ; color no   111
             "(/ 0.600, 0.973, 1.000/)", \    ; color no   112
             "(/ 0.396, 0.937, 1.000/)", \    ; color no   113
             "(/ 0.216, 0.890, 1.000/)", \    ; color no   114
             "(/ 0.145, 0.663, 0.800/)", \    ; color no   115
             "(/ 0.094, 0.478, 0.600/)", \    ; color no   116 blue         ##============================================================    
             "(/ 0.710, 0.420, 0.153/)", \    ; color no   117 brown        # differences and absolute values for precipitation (brown->bue) 
             "(/ 0.800, 0.518, 0.247/)", \    ; color no   118              # number of colors in table
             "(/ 0.878, 0.647, 0.388/)", \    ; color no   119              # ncolors = 11
             "(/ 0.957, 0.800, 0.518/)", \    ; color no   120
             "(/ 1.000, 0.957, 0.729/)", \    ; color no   121
             "(/ 0.800, 1.000, 0.800/)", \    ; color no   122
             "(/ 0.600, 0.953, 0.698/)", \    ; color no   123
             "(/ 0.329, 0.737, 0.620/)", \    ; color no   124
             "(/ 0.427, 0.671, 0.773/)", \    ; color no   125
             "(/ 0.067, 0.439, 0.686/)", \    ; color no   126 
             "(/ 0.024, 0.118, 0.267/)", \    ; color no   127 blue         ##============================================================
             "(/ 0.027, 0.318, 0.608/)", \    ; color no   128              # differences in temperature (blue->red)
             "(/ 0.129, 0.439, 0.710/)", \    ; color no   129              # number of colors in table
             "(/ 0.259, 0.569, 0.776/)", \    ; color no   130              # ncolors = 12
             "(/ 0.467, 0.753, 0.839/)", \    ; color no   131
             "(/ 0.667, 0.859, 0.898/)", \    ; color no   132
             "(/ 0.859, 0.957, 1.000/)", \    ; color no   133
             "(/ 0.988, 0.729, 0.667/)", \    ; color no   134
             "(/ 0.984, 0.569, 0.447/)", \    ; color no   135
             "(/ 0.937, 0.239, 0.169/)", \    ; color no   136
             "(/ 0.800, 0.086, 0.118/)", \    ; color no   137
             "(/ 0.647, 0.059, 0.078/)", \    ; color no   138
             "(/ 0.467, 0.039, 0.059/)", \    ; color no   139 
             "turquoise1" /)                  ; myOceanColor                ## now named colors are following

   return cmap
end



function island(res:string,lon,lat:float)
begin
    
    return bisland
end


function get_lons (res:string,lon1,lon2:float)
begin
    lat1=10.
    lat2=20.
    areafilename="/Volumes/work/m300107/scripts/plot/ncl/libs/area_"+res+".nc"
    areafile=addfile(areafilename,"r")
    lon1d=areafile->lon
    lat1d=areafile->lat
    nlon=dimsizes(lon1d)
    nlat=dimsizes(lat1d)
    lon2d=conform_dims((/nlat,nlon/),lon1d,1)
    lat2d=conform_dims((/nlat,nlon/),lat1d,0)
    lon=(/lon1,lon2/)
    lat=(/lat1,lat2/)
    yx=getind_latlon2d(lat2d,lon2d,lat,lon)    

    if ( yx(0,1) .gt. yx(1,1) ) then
        x1=dimsizes(ispan(yx(0,1),nlon-1,1))
        x2=dimsizes(ispan(0,yx(1,1),1))
        lons=new(x1+x2,integer)
        lons(0:x1-1)=ispan(yx(0,1),nlon-1,1)
        lons(x1:x1+x2-1)=ispan(0,yx(1,1),1)
    else if ( yx(0,1) .eq. yx(1,1) ) then
        lons=ispan(0,nlon-1,1)
    else
        x1=dimsizes(ispan(yx(0,1),yx(1,1),1))
        lons=new(x1,integer)
        lons(0:x1-1)=ispan(yx(0,1),yx(1,1),1)
    end if
    end if
;    print (lon1d(lons))
;    print(lons)
    return lons
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
    areafilename="/Volumes/work/m300107/scripts/plot/ncl/libs/area_"+res+".nc"
    areafile=addfile(areafilename,"r")
    lons=get_lons(res,lon1,lon2)
    area2d = areafile->cell_area({lat1:lat2},lons)
    return area2d
end



undef ("get_area_land")
function get_area_land (res:string,lon1,lon2,lat1,lat2:float)
local res,areafilename,areafile,area2d
begin
    ; res=T31 T63 ...
    areafilename="/Volumes/work/m300107/scripts/plot/ncl/libs/area_land_"+res+".nc"
    areafile=addfile(areafilename,"r")
    lons=get_lons(res,lon1,lon2)
    ;printVarSummary(lons)
    area2d = areafile->cell_area({lat1:lat2},lons)
    ;printVarSummary(area2d)
   return area2d
end




undef ("get_GCD_region")
function get_GCD_region ()
begin
    regionfilename="/Volumes/work/m300107/scripts/plot/ncl/libs/GCD_regionsdef_T31.nc"
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
function get_cpools (fn,res:string,lon1,lon2,lat1,lat2:float)
local boxC_reserve2d,boxC_green2d,boxC_woods2d,box_GPP_yDayMean2d,box_Cpools_total2d,total2d,soil2d,green2d,gpp2d,total1d,soil1d,green1d,gpp1d,dims,nlon,nlat,cpools
begin
   
   data=addfile(fn, "r")
   lons=get_lons(res,lon1,lon2)
;2d   
   boxC_reserve2d     = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_reserve(:,:,{lat1:lat2},lons),1),0)     
   boxC_green2d       = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_green(:,:,{lat1:lat2},lons),1),0)       
   boxC_woods2d       = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_woods(:,:,{lat1:lat2},lons),1),0)       
   box_GPP_yDayMean2d = dim_avg_n_Wrap(dim_sum_n_Wrap(data->box_GPP_yDayMean(:,:,{lat1:lat2},lons),1),0) 
   box_Cpools_total2d = dim_avg_n_Wrap(data->box_Cpools_total(:,{lat1:lat2},lons),0)                     

   total2d = box_Cpools_total2d
   soil2d  = box_Cpools_total2d-boxC_reserve2d-boxC_green2d-boxC_woods2d
   green2d = boxC_reserve2d+boxC_green2d+boxC_woods2d
   gpp2d   = box_GPP_yDayMean2d

   dims = dimsizes(total2d)
   rank=dimsizes(dims)
   nlat=dims(rank-2)
   nlon=dims(rank-1)
   
   area=get_area(res,lon1,lon2,lat1,lat2)
  
;1d
   total1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(total2d*area)))
   soil1d  = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(soil2d*area)))
   green1d = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(green2d*area)))
   gpp1d   = 1e-15*12.011*(dim_sum_Wrap(dim_sum_Wrap(gpp2d*area)))*3600*24*365.25


   ;soil1d  = dim_avg_Wrap(dim_avg_Wrap(where(ismissing(soil2d)  .or. soil2d  .lt. 0. ,0.,soil2d)))  * 6.1256
   ;green1d = dim_avg_Wrap(dim_avg_Wrap(where(ismissing(green2d) .or. green2d .lt. 0. ,0.,green2d))) * 6.1256
   ;gpp1d   = dim_avg_Wrap(dim_avg_Wrap(where(ismissing(gpp2d)   .or. gpp2d   .lt. 0. ,0.,gpp2d)))   * 6.1256*3600*24*365.25

   
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
    ;printVarSummary(area)
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




undef ("get_cpools_green_1d")
function get_cpools_green_1d (fn,res:string,lon1,lon2,lat1,lat2:float,runaverage:logical,naverage:integer)
begin
    data=addfile(fn, "r")
    
    ;3d   
    lons=get_lons(res,lon1,lon2)
    cpools3d = data->box_Cpools_total(:,{lat1:lat2},lons)
    area=get_area_land(res,lon1,lon2,lat1,lat2)
    carea=conform_dims(dimsizes(cpools3d),area,(/1,2/))
   
    if ( runaverage .eq. True ) then 
        cpools1d=new((/2,ntime/),typeof(cpools3d),MyFillValue)
        cpools1d(0,:) = dim_sum_n_Wrap(cpools3d*carea,(/1,2/))*1e-15*12.011
        cpools1d(1,:) = runave(cpools1d(0,:),naverage,0)
    else
        cpools1d=new((/ntime/),typeof(cpools3d),MyFillValue)
        cpools1d(:) = dim_sum_n_Wrap(cpools3d*carea,(/1,2/))*1e-15*12.011 
    end if 

    return cpools1d
end



undef ("get_cpools_1d")
function get_cpools_1d (fn,res:string)
local boxC_reserve2d,boxC_green2d,boxC_woods2d,box_GPP_yDayMean2d,box_Cpools_total2d,total2d,soil2d,green2d,gpp2d,total1d,soil1d,green1d,gpp1d,dims,nlon,nlat,cpools
begin
   
   data=addfile(fn, "r")
   
;2d   
   lons=get_lons(res,lon1,lon2)
   boxC_reserve2d     = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_reserve(:,:,{lat1:lat2},lons),1),0)     
   boxC_green2d       = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_green(:,:,{lat1:lat2},lons),1),0)       
   boxC_woods2d       = dim_avg_n_Wrap(dim_sum_n_Wrap(data->boxC_woods(:,:,{lat1:lat2},lons),1),0)       
   box_GPP_yDayMean2d = dim_avg_n_Wrap(dim_sum_n_Wrap(data->box_GPP_yDayMean(:,:,{lat1:lat2},lons),1),0) 
   box_Cpools_total2d = dim_avg_n_Wrap(data->box_Cpools_total(:,{lat1:lat2},lons),0)                     

   total2d = box_Cpools_total2d
   soil2d  = box_Cpools_total2d-boxC_reserve2d-boxC_green2d-boxC_woods2d
   green2d = boxC_reserve2d+boxC_green2d+boxC_woods2d
   gpp2d   = box_GPP_yDayMean2d

   dims = dimsizes(total2d)
   rank=dimsizes(dims)
   nlat=dims(rank-2)
   nlon=dims(rank-1)

   area=get_area(res,lon1,lon2,lat1,lat2)
  
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
   cpools1=get_cpools(fn1,res,lon1,lon2,lat1,lat2)
   cpools2=get_cpools(fn2,res,lon1,lon2,lat1,lat2)
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
    lons=get_lons("T31",lon1,lon2)
    box_burned_acc2d = dim_avg_n_Wrap(dim_sum_n_Wrap(data->box_burned_acc(:,:,{lat1:lat2},lons),1),0)
 
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
    qmax=max(quant)
    minimax=(quant-qmin)/(qmax-qmin)+shift
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

    lons=get_lons("T31",lon1,lon2)

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




function get_GCD_mask(regvec:integer)
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

    return output
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
   
   C_flux(0,:,:)=fire_C_flux2d * 86400. / 44.01 * 12.0107 *1000. ; get g(C) m-2 d-1
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
function get_coverfraction (fn:string)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin
   
   data=addfile(fn, "r")
   
;2d   
   cover_fract=dim_avg_n_Wrap(data->cover_fract(:,:,:,:),0)
   veg_fract_correction=dim_avg_n_Wrap(data->veg_fract_correction(:,:,:,:),0)
   veg_ratio_max=dim_avg_n_Wrap(data->veg_ratio_max(:,:,:),0)

   dims=dimsizes(veg_ratio_max)
   nlat=dims(0)
   nlon=dims(1)
   coverfraction=new((/5,nlat,nlon/),float,MyFillValue)

   copy_VarAtts(cover_fract,coverfraction)
   latunit=cover_fract&lat@units
   lonunit=cover_fract&lon@units
   coverfraction!0="pfts"
   coverfraction!1="lat"
   coverfraction!2="lon"
   coverfraction&lat=cover_fract&lat
   coverfraction&lon=cover_fract&lon
   coverfraction&lat@units=latunit
   coverfraction&lon@units=lonunit


   ;desert
   coverfraction(0,:,:)=1.-veg_ratio_max
   ;woody
   coverfraction(1,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(0:5,:,:),0)
   ;tree
   coverfraction(2,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(0:3,:,:),0)
   ;shrubs
   coverfraction(3,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(4:5,:,:),0)
   ;grass
   coverfraction(4,:,:)=veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0)

   return coverfraction
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






undef ("get_precipitation")
function get_precipitation (fn,conversion:string)
begin
   data=addfile(fn, "r")

   ;2d   
   prec=dim_avg_n_Wrap(data->precip(:,:,:),0)
   prec=convert_prec(prec,conversion)
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
function get_temperature (fn:string)
begin
   data=addfile(fn, "r")

   ;2d   
   temp=dim_avg_n_Wrap(data->air_temp(:,:,:),0)
   return temp
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
function get_temperature_diff (fn1,fn2:string)
local temp1,temp2
begin
   ;2d   
   temp1=get_temperature(fn1)
   temp2=get_temperature(fn2)

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




function get_edc_domec_data(tstart,tend:integer)
begin
    fn="/Volumes/work/m300107/scripts/plot/ncl/libs/CO2_HighResolutionTaylorDomeIceCore.txt"
    ; skip header and docu
    head = readAsciiHead(fn, "Depth")
    print(head)

    
    
    ; read until end
    
    
    return co2
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



;=================================================================================================================================
;
; plotting
;
;=================================================================================================================================
; all plots based on climba.rgb - colortable file of pages article
;
;###============================================================           
;###
;### color table for climba plots
;###
;### 2012 Tim Bruecher
;###
;###============================================================           
;# white
;# black
;# abs. carbon pool        # 11 colors  2 -> 12
;# dif. carbon pool        # 13 colors 13 -> 25
;# abs. cover fraction     # 12 colors 26 -> 37
;# dif. cover fraction     # 13 colors 38 -> 50
;# abs. desert fraction    # 12 colors 51 -> 62
;# dif. desert fraction    # 13 colors 63 -> 75
;# abs. fire fraction      # 10 colors 76 -> 85
;# dif. fire fraction      # 11 colors 86 -> 96
;###============================================================

;plot=new(nplot,graphic)
;    res@tiYAxisSide=""
;    do iplot=0,nplot-1
;        res@tmXTOn=(iplot.eq.0)      
;        res@tmXBOn=(iplot.eq.nplot-1)
;        if ( res@tiYAxisSide.eq."Right" ) then 
;            res@tiYAxisSide="Left"
;            res@tmYRLabelsOn=False 
;            res@tmYLLabelsOn=True 
;        else 
;            res@tiYAxisSide="Right" 
;            res@tmYRLabelsOn=True 
;            res@tmYLLabelsOn=False 
;        end if
;
;;        res@tmXBMode             = "Explicit"
;        ;res@tmXBValues           = xindexc  
;        ;res@tmXBLabels           = xlabelc  
;        res@tmXBLabelFontHeightF = 0.02
;        res@xyLineColor          = colorvec(iplot)
;        res@tiYAxisString        = yaxisstring(iplot)
;        res@tiXAxisString        = xaxisstring
;        res@tiYAxisFontColor     = res@xyLineColor
;        res@tmYLLabelFontColor   = res@xyLineColor
;
;        if ( rank.eq.1) then
;            plot(iplot)=gsn_csm_y(wks,data(:),res) ; create plot, if there is just one timeline
;        else
;            plot(iplot)  = gsn_csm_y(wks,data(iplot,:),res) ; create plot
;        end if
;    end do
;    
;    if (rank.eq.1) then
;        ;respanel=True
;        pres = False               ; No resources needed
;        ;maximize_output(wks,pres)  ; Maximize plot on page
;    else
;        attachres1                     = True
;        attachres1@gsnAttachPlotsXAxis = True  ;; attaches along x-axis
;        attachres1@gsnAttachBorderOn   = False ;; No border please
;        attachres2                     = True
;        attachres2@gsnAttachPlotsXAxis = True  ;; attaches along x-axis
;        attachres2@gsnAttachBorderOn   = False ;; No border please
;
;        attachid1  = gsn_attach_plots(plot(0),plot(1:(nplot-1)),attachres1,attachres2)
;
;        respanel=True
;        pres = False               ; No resources needed
;        maximize_output(wks,pres)  ; Maximize plot on page
;    end if


undef ("plot_kehrwald")
procedure plot_kehrwald(path,fn:string)
begin
; data
    infile=path+fn+".nc"
    data=addfile(infile, "r")
    ;time
    barea=data->barea(:)
    zbarea=data->zbarea(:)
    time=data->time(:)

   output=path+fn+".pdf"

  
   wks=gsn_open_wks("pdf",output)
   cmap=def_colormap
   gsn_define_colormap(wks,cmap)
   ;gsn_draw_colormap(wks)
   gsnMaximize = True

   res=True
    res@gsnDraw            = False             ; don't draw yet
    res@gsnFrame           = False             ; don't advance frame yet
    res@vpHeightF=0.4
    res@vpWidthF=0.6
    res@vpYF=0.93
    res@vpXF=0.13

  resa=res
  resb=res

  resa@xyLineColors=1
  resb@xyLineColors=13
  resa@tiYAxisFontColor=1
  resb@tiYAxisFontColor=13

  resa@tiYAxisString = "burned area [Mha]"
  resb@tiYAxisString = "Z scores"
  resa@xyDashPattern=0
  resb@xyDashPattern=0


  resb@trYMaxF=1.5
  resb@trYMinF=-1.5
  resb@tiMainString=fn



  plot=gsn_csm_xy2(wks,time,barea,zbarea,resa, resb)

  draw(plot)
end



undef("plot_marlon2")
procedure plot_marlon2 (data:logical,wkstype,output,paneltitle:string)
begin
   wks_type=wkstype
   wks=gsn_open_wks(wks_type,output)
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)
    ;gsn_draw_colormap(wks)
    gsnMaximize = True

    res=True
    res@gsnDraw            = False             ; don't draw yet
    res@gsnFrame           = False             ; don't advance frame yet
    res@vpHeightF=0.4
    res@vpWidthF=0.6
    res@vpYF=0.93
    res@vpXF=0.13

    resa=res
    resa@trXMaxF                = 200
    resa@trXMinF                = -8200
    resa@trYMaxF=1.
    resa@trYMinF=-1.2
    resa@tiYAxisString = "Z scores"
    resa@tiXAxisString = "cal. yrs BP"
    resa@tmXBMode = "Explicit"
    resa@tmXBLabels = (/"-8000","-6000","-4000","-2000","0"/)
    resa@tmXBValues = (/"-8000","-6000","-4000","-2000","0"/)
    resa@xyLineColors= (/1,13/)
    resa@xyDashPatterns=(/0,0/) ;LineColors= (/1,13/)

    resa@pmLegendDisplayMode    = "Always"   ; Display a legend.
    resa@xyExplicitLegendLabels = (/"zbarea","zcflux","influx"/)
    resa@pmLegendOrthogonalPosF = -0.55      ; Move into to plot
    resa@pmLegendParallelPosF   =  0.785      ; Move to right
    resa@pmLegendWidthF         = 0.2        ; Make it smaller
    resa@pmLegendHeightF        = 0.1        ; Make it smaller
    resa@lgPerimOn              = False      ; No legend perimeter.
    resa@lgLabelFontHeightF     = 0.01



    resb=res
    resb@tiYAxisString = "burned area [Mha]"
    resb@pmLegendDisplayMode    = "Always"   ; Display a legend.
    resb@xyExplicitLegendLabels = (/"barea"/)
    resb@pmLegendOrthogonalPosF = -0.28     ; Move into to plot
    resb@pmLegendParallelPosF   =  0.785      ; Move to right
    resb@pmLegendWidthF         = 0.2        ; Make it smaller
    resb@pmLegendHeightF        = 0.1        ; Make it smaller
    resb@lgPerimOn              = False      ; No legend perimeter.
    resb@lgLabelFontHeightF     = 0.01
    resb@xyLineColor= 139
    resb@tiYAxisFontColor = 139
    max_zb=max(data@zbarea)
    max_zc=max(data@zcflux)
    max_cup=max(data@cup)
    min_zb=min(data@zbarea)
    min_zc=min(data@zcflux)
    min_cdown=min(data@cdown)


    ampzbarea=max_zb-min_zb
    ampbarea=max(data@barea)-min(data@barea)
    ratio=(1./(ampzbarea/(resa@trYMaxF-resa@trYMinF))-1.)/2.
    resb@trYMaxF=max(data@barea)+ratio*ampbarea
    resb@trYMinF=min(data@barea)-ratio*ampbarea


    
    resc=res
    resc@tiYAxisString = "nsites"
    resc@tiYAxisFontColor = 124
    resc@xyLineColor= 124
    resc@amOrthogonalPosF = 0.73
    resc@trYMaxF                = 600
    resc@trYMinF                = 0
    resc@tmYRMode="Explicit"
    resc@tmYRValues=(/0,100,200/)
    resc@tmYRLabels=(/"0","100","200"/)


     top_plot=gsn_csm_xy3(wks,data@mtime,(/data@zbarea,data@zcflux/),data@barea,data@cflux*(-1.),resa, resb, resc)
;     draw(top_plot)


    resd=res
    resd@trXMaxF                = 200
    resd@trXMinF                = -8200

    resd@trYMaxF=1.
    resd@trYMinF=-1.2
    ;confidence interval in charcoal
    resd@gsnXYFillColors = (/0.984, 0.729, 1.000 ,0.3/)
    resd@xyLineColors     = (/-1,-1/) 
    ;resd@tmXBLabelsOn=False
    ; charcoal mean curve
    resd@tmYRLabelsOn=False
    resd@tmYROn=False

    bot_plot=gsn_csm_xy (wks,data@ctime,(/data@cup,data@cdown/),resd)
    bot_plot2=gsn_csm_xy (wks,data@ctime,(/data@cup,data@cdown/),resd)

;bar_plot
    polyres=True
    px1=(/-8000,-6000,-6000,-8000,-8000/)
    px2=(/-4000,-2000,-2000,-4000,-4000/)
    px3=(/0,200,200,0,0/)

    py=(/resd@trYMinF,resd@trYMinF,resd@trYMaxF,resd@trYMaxF,resd@trYMinF/)
    polyres@gsFillColor = "gainsboro"
    p1=gsn_add_polygon(wks, bot_plot, px1, py, polyres)
    p2=gsn_add_polygon(wks, bot_plot, px2, py, polyres)
    p3=gsn_add_polygon(wks, bot_plot, px3, py, polyres)


;    draw(bot_plot)


    rese=res
    rese@trXMaxF                = 200
    rese@trXMinF                = -8200
    rese@tmYRLabelsOn=False
    rese@tmXBOn=False
    rese@tmYROn=False
    rese@tmYLOn=False
    resf=rese

    rese@trYMaxF=1.
    rese@trYMinF=-1.2
    rese@pmLegendDisplayMode    = "Always"   ; Display a legend.
    rese@xyExplicitLegendLabels = (/"zinflux"/)
    rese@pmLegendOrthogonalPosF = -0.55     ; Move into to plot
    rese@pmLegendParallelPosF   =  0.785      ; Move to right
    rese@pmLegendWidthF         = 0.2        ; Make it smaller
    rese@pmLegendHeightF        = 0.1        ; Make it smaller
    rese@lgPerimOn              = False      ; No legend perimeter.
    rese@lgLabelFontHeightF     = 0.01



    resf@trYMaxF=600.
    resf@trYMinF=0.
    rese@xyLineColors= (/38,38/) ; "blueviolet"
    rese@tmYRLabelsOn=False
    resf@tmYLLabelsOn=False
    resf@xyLineColor= 124
    resf@tiMainString=paneltitle
    mid_plot=gsn_csm_xy2 (wks,data@ctime,data@influx,data@nsites,rese,resf)
;    draw(back_plot)



    overlay(bot_plot,bot_plot2)
    overlay(bot_plot,mid_plot)
    overlay(bot_plot,top_plot)

    draw(bot_plot)
end


undef ("plot_marlon")
procedure plot_marlon (data:logical,wkstype,output,paneltitle:string)
begin
    wks_type = wkstype
    wks=gsn_open_wks(wks_type,output)
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)
    ;gsn_draw_colormap(wks)
    gsnMaximize = True
    res=True
    res@tfPolyDrawOrder="PreDraw"
    ;res@gsnDraw            = False             ; don't draw yet
    ;res@gsnFrame           = False             ; don't advance frame yet

    res@trXMaxF                = 200
    res@trXMinF                = -8200
    res@pmLegendDisplayMode    = "Always"   ; Display a legend.
    res@pmLegendWidthF         = 0.2        ; Make it smaller
    res@pmLegendHeightF        = 0.1        ; Make it smaller
    res@pmLegendOrthogonalPosF = -0.27      ; Move into to plot
    res@pmLegendParallelPosF   =  0.79      ; Move to right
    res@lgPerimOn              = False      ; No legend perimeter.
    res@lgLabelFontHeightF     = 0.01

    res2=res
    res@tiYAxisString = "Z scores"
    res2@tiYAxisFontColor = 139
    res2@tmYRLabelFontColor = 139

    res2@tiYAxisString = "burned area [Mha]"
 
    res@xyLineColors= (/1,13/)
    res@xyDashPatterns=(/0,0/) ;LineColors= (/1,13/)

    res@xyExplicitLegendLabels = (/"zbarea","zcflux","influx"/)
    max_zb=max(data@zbarea)
    max_zc=max(data@zcflux)
    max_cup=max(data@cup)
    min_zb=min(data@zbarea)
    min_zc=min(data@zcflux)
    min_cdown=min(data@cdown)

;    res@trYMaxF=max((/max_zb,max_zc,max_cup/))
;    res@trYMinF=min((/min_zb,min_zc,min_cdown/))

    res@trYMaxF=1.
    res@trYMinF=-1.2

    ampzbarea=max_zb-min_zb
    ampbarea=max(data@barea)-min(data@barea)
    ratio=(1./(ampzbarea/(res@trYMaxF-res@trYMinF))-1.)/2.

       
    res2@trYMaxF=max(data@barea)+ratio*ampbarea
    res2@trYMinF=min(data@barea)-ratio*ampbarea

    ;print(""+ampbarea+"  "+ratio+"   "+ampzbarea+"  "+res2@trYMaxF+"   "+res2@trYMinF+"  "+min(data@barea)+"    "+max(data@barea))

    res2@xyLineColor= 139 
    res2@xyExplicitLegendLabels = (/"barea"/)
    res2@pmLegendOrthogonalPosF = -0.2415      ; Move into to plot
    res2@pmLegendParallelPosF   =  0.785      ; Move to right

    res3=res2
;    top_plot=gsn_csm_xy2(wks,data@mtime,(/data@zbarea,data@zcflux/),data@barea,res,res2)
    
    
    data@empty=data@zbarea*0.
    res3@trYMaxF=600
    res3@trYMinF=0
    res3@tmYRMode="Explicit"
    res3@tmYRValues=(/0,100,200/)
    top_plot=gsn_csm_xy3(wks,data@mtime,(/data@zbarea,data@zcflux/),data@barea,data@empty,res,res2,res3)




    res@pmLegendDisplayMode    = "Never"   ; Display a legend.
;    res@tmYROn=False

    ; charcoal mean curve
;    res@tmYRLabelsOn=False 

    res@xyLineColors= (/38,38/) ; "blueviolet"
    mid_plot=gsn_csm_xy (wks,data@ctime,data@influx,res)
      
    ; confidence interval in charcoal
    res@gsnXYFillColors = (/0.984, 0.729, 1.000 ,0.3/)
    res@xyLineColors     = (/-1,-1/)   
    res@tiMainString=paneltitle
    
;    bot_plot=gsn_csm_xy (wks,data@ctime,(/data@cup,data@cdown/),res)
    
    empty=new(dimsizes(data@cup),float,0)
    empty=0.
    resE=True
    resE@tmYRLabelsOn=False
    resE@tmYROn=True
    
    resE@tiYAxisFontColor = 139
    resE@tmYRLabelFontColor = 139
    resE@tiYAxisOffsetXF = 0.6
    resE@tiYAxisString = "burned area [Mha]"
    
    resS=True
    resS@trYMaxF=600
    resS@trYMinF=0
    resS@tmYRMode="Explicit"
    resS@tmYRValues=(/0,100,200/)
    ;resS@gsnXYBarChart = True

    bot_plot=gsn_csm_xy3 (wks,data@ctime,(/data@cup,data@cdown/),empty,data@nsites,res,resE,resS)
    bot_plot2=gsn_csm_xy3 (wks,data@ctime,(/data@cup,data@cdown/),empty,data@nsites,res,resE,resS)

    ;bar_plot
    polyres=True
    px1=(/-8000,-6000,-6000,-8000,-8000/)
    px2=(/-4000,-2000,-2000,-4000,-4000/)
    px3=(/0,200,200,0,0/)

    py=(/res@trYMinF,res@trYMinF,res@trYMaxF,res@trYMaxF,res@trYMinF/)
    polyres@gsFillColor = "gainsboro"
    p1=gsn_add_polygon(wks, bot_plot, px1, py, polyres)
    p2=gsn_add_polygon(wks, bot_plot, px2, py, polyres)
    p3=gsn_add_polygon(wks, bot_plot, px3, py, polyres)
    
    overlay(bot_plot,bot_plot2)
    overlay(bot_plot,mid_plot)
    overlay(bot_plot,top_plot)
    
    maximize_output(wks,res)
    draw(bot_plot)

; plotting number of sites
    ;resS=True
    ;resS@gsnXYBarChart = True
    ;resS@tiYAxisSide=""
    ;resS@tmXTOn=False
;    resS@tmXBOn=(iplot.eq.nplot-1)

    ;resS@tiYAxisSide="Right" 
    ;resS@tmYRLabelsOn=True 
    ;resS@tmYLLabelsOn=False 

;;        res@tmXBMode             = "Explicit"
;        ;res@tmXBValues           = xindexc  
;        ;res@tmXBLabels           = xlabelc  
;        res@tmXBLabelFontHeightF = 0.02
;        res@xyLineColor          = colorvec(iplot)
;        res@tiYAxisString        = yaxisstring(iplot)
;        res@tiXAxisString        = xaxisstring
;        res@tiYAxisFontColor     = res@xyLineColor
;        res@tmYLLabelFontColor   = res@xyLineColor
;
     ;plotS=gsn_csm_xy(wks,data@ctime,data@nsites,resS) ; create plot, if there is just one timeline


;        attachres1                     = True
;        attachres1@gsnAttachPlotsXAxis = True  ;; attaches along x-axis
;        attachres1@gsnAttachBorderOn   = False ;; No border please
;        attachres2                     = True
;        attachres2@gsnAttachPlotsXAxis = True  ;; attaches along x-axis
;        attachres2@gsnAttachBorderOn   = False ;; No border please
;
;        attachid1  = gsn_attach_plots(plotS,bot_plot,attachres1,attachres2)
;
;    ;maximize_output(wks,res)
;    ;draw(bot_plot)
;    draw()
end




undef ("plot_lat_lon")
procedure plot_lat_lon (data:float,wkstype:string,output:string,paneltitle:string)
begin
   wks_type              = wkstype
   gsnMaximize           = True
   res=True
   wks=gsn_open_wks(wks_type,output)
   res@cnFillOn          = True
 ;  cmap=def_colormap
 ;  gsn_define_colormap(wks_fire,cmap)

;   gsn_define_colormap(wks_fire,"climba")
   ;gsn_draw_colormap(wks_fire)

;   resfire@cnLevels = (/-0.1,-0.075,-0.05,-0.025,-0.005,0.005,0.025,0.05,0.075,0.1/)
;   resfire@cnFillColors = ispan(86,96,1)
;   resfire@gsnRightString= "[M ha]"
   
   ; plotting
   plot = gsn_csm_contour_map(wks,data(:,:),res)
end


; general functions / subroutines
; set_plot_settings (res:logical)
; set_panel_settings (resP:logical,paneltitle:string,year:string)


undef ("set_plot_settings")
function set_plot_settings (res:logical)
begin
   res                   = True 
   res@cnFillOn          = True            ; color Fill 
   res@cnFillMode        = "CellFill"      ; Raster Mode
   res@cnLinesOn         = False           ; Turn off contour lines
   res@gsnFrame          = False 
   res@gsnDraw           = False


   res@cnFillDrawOrder   = "PostDraw"
   res@mpProjection      = "Mollweide"
   ;res@mpProjection      = "CylindricalEquidistant"

   res@mpLandFillPattern = 0
   res@mpOutlineOn=False
   res@mpGeophysicalLineColor="turquoise1"
   res@mpOceanFillColor  = "turquoise1"
   res@mpLandFillColor   = "turquoise1"
   res@mpDefaultFillColor = "turquoise1"

   res@mpPerimOn         = False             ; turn off box around plot
   res@mpGridLatSpacingF = 30.               ; spacing for lat lines
   res@mpGridLonSpacingF = 30.               ; spacing for lon lines
   res@mpFillOn          = True
   res@cnFillOn          = True              ; color plot desired
   res@cnLineLabelsOn    = False             ; turn off contour lines
   res@txFontHeightF     = 0.015 

   res@vpXF              = 0.1                 ; make plot bigger
   res@vpYF              = 0.9         
   res@vpWidthF          = 0.8
   res@vpHeightF         = 0.8

   res@tmXBOn            = False
   res@tmXTOn            = False
   res@tmYROn            = False
   res@tmYLOn            = False

   res@cnLevelSelectionMode = "ExplicitLevels" 
   ;res@mpLandFillColor      = -1
   res@lbAutoManage         = False
   res@lbLabelFontHeightF   = 0.015
   res@pmLabelBarWidthF     = 0.8
   res@lbLabelAngleF        = -90


   res@mpMaxLatF            = 90          ; choose subregion           
   res@mpMinLatF            = -90
   res@mpMaxLonF            = 180
   res@mpMinLonF            = -180


   ; masking the ocean
   ;t31lsm=addfile("sea_land_mask_T31.nc","r")
   ;slmdata = at31lsm->slm
   ;slm = landsea_mask(slmdata,data&lat,data&lon)
    

   return (res)
end



undef ("set_panel_settings")
function set_panel_settings (resP:logical,paneltitle:string,year:string,unit: string)
begin
   resP@gsnMaximize     = True
   resP@gsnPanelRowSpec = True
   resP@gsnPanelCenter  = True
   resP@txString        = paneltitle+year+" "+unit
   return(resP)
end


undef("set_zonalmean_settings")
function set_zonalmean_settings (res:logical)
local zm
begin
; some settings necessary
   
   return (res)
end

; subroutines to plot panels
; plot_cpools_abs (cpools:float,wkstype:string,year:string,output:string,paneltitle:string)
; plot_cpools_diff (cpools:float,wkstype:string,year:string,output:string,paneltitle:string)              
; plot_coverfraction_abs (covers:float,wkstype:string,year:string,output:string,paneltitle:string)    # green + desert
; plot_coverfraction_diff (covers:float,wkstype:string,year:string,output:string,paneltitle:string)   # green + desert
; plot_fire_abs (covers:float,wkstype:string,year:string,output:string,paneltitle:string)
; plot_fire_diff (fire:float,wkstype:string,year:string,output:string,paneltitle:string)


undef ("plot_cpools_abs")
procedure plot_cpools_abs (cpools:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True

   res=True
   res=set_plot_settings(res)

   wks_cpools            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_cpools,cmap)
   ;gsn_draw_colormap(wks_cpools)

   plot=new(4,graphic)
   res@cnLevels = (/0.05,0.10,0.50,1,2.5,5.,10,15,25,50/)
   res@cnFillColors = ispan(2,12,1)
   res@gsnRightString= "[kg/m2]"
   
   ; plotten of absolute values for carbon pools
   ; total
   res@gsnLeftString = "cpools total: "+year+"  "+cpools(4,0,0)+" Gt C"
   plot(0) = gsn_csm_contour_map(wks_cpools,cpools(0,:,:),res)
   ; soil
   res@gsnLeftString = "cpools soil: "+year+"  "+cpools(5,0,0)+" Gt C"
   plot(1) = gsn_csm_contour_map(wks_cpools,cpools(1,:,:),res)
   ; green
   res@gsnLeftString = "cpools green: "+year+"  "+cpools(6,0,0)+" Gt C"
   plot(2) = gsn_csm_contour_map(wks_cpools,cpools(2,:,:),res)
   ; gpp
   res@gsnLeftString = "gpp: "+year+"  "+cpools(7,0,0)+" Gt C"
   plot(3) = gsn_csm_contour_map(wks_cpools,cpools(3,:,:),res)
   
   ;plotting the four figures as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,res@gsnRightString)
   
   gsn_panel(wks_cpools,plot(0:3),(/2,2/),resP)
end



undef ("plot_cpools_diff")
procedure plot_cpools_diff (cpools:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True

   res=True
   res=set_plot_settings(res)
   wks_cpools            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_cpools,cmap)
   ;gsn_draw_colormap(wks_cpools)

   plot=new(4,graphic)
   res@cnLevels = (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)
   res@cnFillColors = ispan(13,25,1)
   res@gsnRightString= "[kg/m2]"
   
   ; plotten of absolute values for carbon pools
   ; total
   res@gsnLeftString = "cpools total: "+year+"  "+cpools(4,0,0)+" Gt C"
   plot(0) = gsn_csm_contour_map(wks_cpools,cpools(0,:,:),res)
   ; soil
   res@gsnLeftString = "cpools soil: "+year+"  "+cpools(5,0,0)+" Gt C"
   plot(1) = gsn_csm_contour_map(wks_cpools,cpools(1,:,:),res)
   ; green
   res@gsnLeftString = "cpools green: "+year+"  "+cpools(6,0,0)+" Gt C"
   plot(2) = gsn_csm_contour_map(wks_cpools,cpools(2,:,:),res)
   ; gpp
   res@gsnLeftString = "gpp: "+year+"  "+cpools(7,0,0)+" Gt C"
   plot(3) = gsn_csm_contour_map(wks_cpools,cpools(3,:,:),res)
   
   ;plotting the four figures as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,res@gsnRightString)
   
   gsn_panel(wks_cpools,plot(0:3),(/2,2/),resP)
end



undef ("plot_coverfraction_abs")
procedure plot_coverfraction_abs (covers:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resgreen=True
   resgreen=set_plot_settings(resgreen)
   resdes=resgreen
   wks_covers            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_covers,cmap)
   ;gsn_draw_colormap(wks_covers)

   plot=new(5,graphic)
   resgreen@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5/)
   resgreen@cnFillColors = ispan(26,37,1)
   resgreen@gsnRightString= "[ ]"
   resdes@cnLevels = (/0.001,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5/)
   resdes@cnFillColors = ispan(51,62,1)
   resdes@gsnRightString= "[ ]"
   
   ; plotten of absolute values for carbon pools
   ; desert fraction
   resdes@gsnLeftString = "desert fraction: "+year+" [ ]"
   plot(0) = gsn_csm_contour_map(wks_covers,covers(0,:,:),resdes)
   ; woody
   resgreen@gsnLeftString = "woody fraction: "+year+" [ ]"
   plot(1) = gsn_csm_contour_map(wks_covers,covers(1,:,:),resgreen)
   ; green
   resgreen@gsnLeftString = "tree fraction: "+year+" [ ]"
   plot(2) = gsn_csm_contour_map(wks_covers,covers(2,:,:),resgreen)
   ; shrubs
   resgreen@gsnLeftString = "shrubs fraction: "+year+" [ ]"
   plot(3) = gsn_csm_contour_map(wks_covers,covers(3,:,:),resgreen)
   ; grass
   resgreen@gsnLeftString = "grass fraction: "+year+" [ ]"
   plot(4) = gsn_csm_contour_map(wks_covers,covers(4,:,:),resgreen)
   
   ;plotting the five figures as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,resdes@gsnRightString)
   
   gsn_panel(wks_covers,plot(0:4),(/1,2,2/),resP)
end



undef ("plot_coverfraction_diff")
procedure plot_coverfraction_diff (covers:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resgreen=True
   resgreen=set_plot_settings(resgreen)
   resdes=resgreen
   wks_covers            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
	
   gsn_define_colormap(wks_covers,cmap)
   ;gsn_draw_colormap(wks_covers)

   plot=new(5,graphic)
   resgreen@cnLevels = (/-0.3,-0.25,-0.20,-0.15,-0.10,-0.05,0.05,0.1,0.15,0.20,0.25,0.30/)
   resgreen@cnFillColors = ispan(38,50,1)
   resgreen@gsnRightString= "[ ]"
   resdes@cnLevels = (/-0.3,-0.25,-0.20,-0.15,-0.10,-0.05,0.05,0.1,0.15,0.20,0.25,0.30/)
   resdes@cnFillColors = ispan(63,75,1)
   resdes@gsnRightString= "[ ]"

   
   ; plotten of absolute values for carbon pools
   ; desert fraction
   resdes@gsnLeftString = "desert fraction: "+year+" [ ]"
   plot(0) = gsn_csm_contour_map(wks_covers,covers(0,:,:),resdes)
   ; woody
   resgreen@gsnLeftString = "woody fraction: "+year+" [ ]"
   plot(1) = gsn_csm_contour_map(wks_covers,covers(1,:,:),resgreen)
   ; green
   resgreen@gsnLeftString = "tree fraction: "+year+" [ ]"
   plot(2) = gsn_csm_contour_map(wks_covers,covers(2,:,:),resgreen)
   ; shrubs
   resgreen@gsnLeftString = "shrubs fraction: "+year+" [ ]"
   plot(3) = gsn_csm_contour_map(wks_covers,covers(3,:,:),resgreen)
   ; grass
   resgreen@gsnLeftString = "grass fraction: "+year+" [ ]"
   plot(4) = gsn_csm_contour_map(wks_covers,covers(4,:,:),resgreen)
   
   ;plotting the five figures as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,resdes@gsnRightString)
   
   gsn_panel(wks_covers,plot(0:4),(/1,2,2/),resP)
end



undef ("plot_fire_abs")
procedure plot_fire_abs (fire:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resfire=True
   resfire=set_plot_settings(resfire)
   wks_fire            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_fire,cmap)
   ;gsn_draw_colormap(wks_fire)

   plot=new(1,graphic)
   resfire@cnLevels = (/0.01,0.025,0.05,0.075,0.1,0.125,0.15,0.175,0.2/)
   resfire@cnFillColors = ispan(76,85,1)
   resfire@gsnRightString= "[M ha]"

   ; plotting burned area
   resfire@gsnLeftString = "burned area: "+year+" "+fire(1,0,0)+" [M ha]"
   plot(0) = gsn_csm_contour_map(wks_fire,fire(0,:,:),resfire)

   ;plotting the figures as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,resfire@gsnRightString)
   gsn_panel(wks_fire,plot(0),(/1/),resP)
end



undef ("plot_fire_diff")
procedure plot_fire_diff (fire:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resfire=True
   resfire=set_plot_settings(resfire)
   wks_fire            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_fire,cmap)

;   gsn_define_colormap(wks_fire,"climba")
   ;gsn_draw_colormap(wks_fire)

   plot=new(1,graphic)
   resfire@cnLevels = (/-0.1,-0.075,-0.05,-0.025,-0.005,0.005,0.025,0.05,0.075,0.1/)
   resfire@cnFillColors = ispan(86,96,1)
   resfire@gsnRightString= "[M ha]"

   
   ; plotting burned area
   resfire@gsnLeftString = "burned area: "+year+" "+fire(1,0,0)+" [M ha]"
   plot(0) = gsn_csm_contour_map(wks_fire,fire(0,:,:),resfire)
   
   ;plotting the figure as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,resfire@gsnRightString)
   gsn_panel(wks_fire,plot(0),(/1/),resP)
end




undef ("plot_fuel_abs")
procedure plot_fuel_abs (fuel:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resfuel=True
   resfuel=set_plot_settings(resfuel)
   wks_fuel            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_fuel,cmap)
   gsn_draw_colormap(wks_fuel)

   plot=new(1,graphic)
   resfuel@cnLevels = (/0.01,0.025,0.05,0.075,0.1,0.125,0.15,0.175,0.2/)
   resfuel@cnFillColors = ispan(76,85,1)
   resfuel@gsnRightString= "[g(C)]"

   ; plotting burned area
   resfuel@gsnLeftString = "fuel: "+year+" "+fuel(1,0,0)+" [Gt(C)]"
   plot(0) = gsn_csm_contour_map(wks_fuel,fuel(0,:,:),resfuel)

   ;plotting the figures as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,resfuel@gsnRightString)
   gsn_panel(wks_fuel,plot(0),(/1/),resP)
end



undef ("plot_fuel_diff")
procedure plot_fuel_diff (fuel:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resfuel=True
   resfuel=set_plot_settings(resfuel)
   wks_fuel            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_fuel,cmap)

;   gsn_define_colormap(wks_fuel,"climba")
   gsn_draw_colormap(wks_fuel)

   plot=new(1,graphic)
   resfuel@cnLevels = (/-0.1,-0.075,-0.05,-0.025,-0.005,0.005,0.025,0.05,0.075,0.1/)
   resfuel@cnFillColors = ispan(86,96,1)
   resfuel@gsnRightString= "[g(C)]"

   
   ; plotting burned area
   resfuel@gsnLeftString = "burned area: "+year+" "+fuel(1,0,0)+" [Gt(C)]"
   plot(0) = gsn_csm_contour_map(wks_fuel,fuel(0,:,:),resfuel)
   
   ;plotting the figure as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,resfuel@gsnRightString)
   gsn_panel(wks_fuel,plot(0),(/1/),resP)
end


undef ("plot_cflux_abs")
procedure plot_cflux_abs (cflux:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   rescflux=True
   rescflux=set_plot_settings(rescflux)
   wks_cflux            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_cflux,cmap)
   ;gsn_draw_colormap(wks_cflux)

   plot=new(1,graphic)
   rescflux@cnLevels = (/0.01,0.025,0.05,0.075,0.1,0.125,0.15,0.175,0.2/)
   rescflux@cnFillColors = ispan(76,85,1)
   rescflux@gsnRightString= "[g(C) d-1]"

   rescflux@gsnLeftString = "C-flux to atmosphere: "+year+" "+cflux(1,0,0)+" [Gt]"
   plot(0) = gsn_csm_contour_map(wks_cflux,cflux(0,:,:),rescflux)

   resP=True
   resP=set_panel_settings(resP,paneltitle,year,rescflux@gsnRightString)
   gsn_panel(wks_cflux,plot(0),(/1/),resP)
end



undef ("plot_cflux_diff")
procedure plot_cflux_diff (cflux:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   rescflux=True
   rescflux=set_plot_settings(rescflux)
   wks_cflux            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_cflux,cmap)
   ;gsn_draw_colormap(wks_cflux)

   plot=new(1,graphic)
   rescflux@cnLevels = (/-0.1,-0.075,-0.05,-0.025,-0.005,0.005,0.025,0.05,0.075,0.1/)
   rescflux@cnFillColors = ispan(86,96,1)
   rescflux@gsnRightString= "[g(C) d-1]"

   rescflux@gsnLeftString = "C-flux to atmosphere: "+year+" "+cflux(1,0,0)+" [Gt]"
   plot(0) = gsn_csm_contour_map(wks_cflux,cflux(0,:,:),rescflux)

   resP=True
   resP=set_panel_settings(resP,paneltitle,year,rescflux@gsnRightString)
   gsn_panel(wks_cflux,plot(0),(/1/),resP)
end



undef ("plot_precipitation_abs")
procedure plot_precipitation_abs (prec:float,wkstype:string,year:string,output:string,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resprec=True
   resprec=set_plot_settings(resprec)
   wks_prec            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_prec,cmap)

   plot=new(1,graphic)
   resprec@cnLevels = (/50.,125.,250.,500.,775.,1250/)
   resprec@cnFillColors = ispan(97,103,1)
   resprec@gsnRightString= "["+prec@units+"]"

   
   ; plotten of absolute values for precipitation
   resprec@gsnLeftString = "precipitation: "+year+" ["+prec@units+"]"
   plot(0) = gsn_csm_contour_map(wks_prec,prec(:,:),resprec)
   
   ;plotting the five figures as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,resprec@gsnRightString)
   gsn_panel(wks_prec,plot(0),(/1/),resP)
end



undef ("plot_precipitation_diff")
procedure plot_precipitation_diff (prec:float,wkstype,year,output,paneltitle:string)
local  wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resprec=True
   resprec=set_plot_settings(resprec)
   ;resprec@mpOutlineBoundarySets (MapPlot)

   wks_prec            = gsn_open_wks(wks_type,output)
   cmap=def_colormap
   gsn_define_colormap(wks_prec,cmap)

   plot=new(1,graphic)
   resprec@cnLevels = (/-750,-500,-250,-100,-50,-10,10,50,100,250,500,750/)
   resprec@cnFillColors = (/139,138,137,136,135,134,0,133,132,131,130,129,128/) 
   resprec@gsnRightString= "["+prec@units+"]"
   
   ; plotten of absolute values for carbon pools
   resprec@gsnLeftString = "precipitation: "+year+" ["+prec@units+"]"
   plot(0) = gsn_csm_contour_map(wks_prec,prec(:,:),resprec)
   
   ;plotting the figures as a panel
   resP=True
   resP=set_panel_settings(resP,paneltitle,year,resprec@gsnRightString)
   
   gsn_panel(wks_prec,plot(0),(/1/),resP)
end



undef("get_xy_plotres")
function get_xy_plotres (res:logical)
begin
   res@gsnDraw               = False        ; don't draw yet
   res@gsnFrame              = False        ; don't advance frame yet
   res@vpWidthF              = .45          ; set width of second plot
   res@tmXBMinorOn           = True         ; minor tickmarks
   res@tmXBLabelStride       = 1            ; label stride
   res@tmXBLabelAngleF       = 0.
   res@tmXBLabelFontHeightF   = 0.009
   res@txFontHeightF          = 0.018        ; change font height
   res@tmXBLabelFontHeightF   = 0.001
      
   res@tmYROn                   = True
   res@tmYLOn                = False

   res@trXMinF                = 0
   res@trXMaxF                = 2100
   return res
end


undef ("make_xy_plot")
procedure make_xy_plot (xyplot:graphic,dataxy:float,maintitle,subtitle:string)
begin
   xyres=True
   xyres=get_xy_plotres(xyres)   
   
   xyres@xyLineColors=(/"blue","red","green","black","orange"/)
   xyres@tiMainString           = maintitle
   xyres@gsnCenterString        = subtitle  ; add title

   xyres@tiMainString           = ""
   zonal_average                = new(dimsizes(dataxy&lat),float)
   zonal_average(:)           = dim_avg(dataxy)
   xyplot=gsn_csm_xy(wks, zonal_average,xydata&lat,xyres)
end



undef ("climate_zm_abs")
procedure climate_zm_abs (prec,temp:float,wkstype,year,output,paneltitle:string)
local wks_type
begin
   ; general settings for all plots
   wks_type              = wkstype
   gsnMaximize           = True
   resprec=True
   resprec=set_plot_settings(resprec)
   resprec@mpProjection      = "CylindricalEquidistant"
   restemp=resprec
   
   wks            = gsn_open_wks(wks_type,output)
   ;printVarSummary(wks)
   cmap=def_colormap
   gsn_define_colormap(wks,cmap)
 

   printVarSummary(prec)
   printVarSummary(temp)
   



   plot2d=new(2,graphic)
   xyplot=new(2,graphic)
   finalplot=new(2,graphic)

   resprec@cnFillColors             = ispan(117,126,1)
;  resprec@cnLevels                 = (/0,50,100,250,500,750,1000,1500,2000/)
   restemp@cnFillColors             = ispan(127,140,1)
;  restemp@cnLevels                 = (/254,258,262,266,270,274,278,282,286,290,294,298,302/)


   plot2d(0) = gsn_csm_contour_map(wks,prec,resprec)

   xyprec=True
   xyprec=get_xy_plotres(xyprec)   
   xyprec@xyLineColors=(/"blue","red","green","black","orange"/)
   xyprec@tiMainString           = "prec"
   xyprec@gsnCenterString        = "[mm]"  ; add title
   xyprec@tiMainString           = ""
   zonal_prec                = new(dimsizes(prec&lat),float)
   zonal_prec(:)           = dim_avg(prec)
   xyplot(0)=gsn_csm_xy(wks, zonal_prec,prec&lat,xyprec)
   
   
   
   plot2d(1) = gsn_csm_contour_map(wks,temp,restemp)
   xytemp=True
   xytemp=get_xy_plotres(xytemp)   
   xytemp@xyLineColors=(/"blue","red","green","black","orange"/)
   xytemp@tiMainString           = "temp"
   xytemp@gsnCenterString        = "[mm]"  ; add title
   xytemp@tiMainString           = "  "
   printVarSummary (temp)
   zonal_temp                = new(dimsizes(temp&lat),float)
   zonal_temp(:)           = dim_avg(temp)
   printVarSummary(zonal_temp)
   xyplot(1)=gsn_csm_xy(wks, zonal_temp,temp&lat,xytemp)
   

   finalplot(0) =   gsn_attach_plots(plot2d(0),(/xyplot(0)/),resprec,xyprec)
   finalplot(1) =   gsn_attach_plots(plot2d(1),(/xyplot(1)/),restemp,xytemp)
   
  ; resP=True
;   resP=set_panel_settings(resP,paneltitle,year)
;   gsn_panel(wks,finalplot,(/1,2/),resP)
   
   restemp@amOrthogonalPosF=-.49
   final=gsn_attach_plots (plot2d(0),plot2d(1),resprec,restemp)
   draw (plot2d(0))
  frame(wks)
 
 
   
end



function set_res_climate(leftString:string)
local res
begin
      res                        = True
      res@gsnDraw                = False     ; don't draw yet
      res@gsnFrame               = False
      res@cnFillOn               = True     ; turn on color fill
      res@cnLinesOn              = False   
      res@cnFillMode             = "CellFill" ; turn of contour lines

      ; labelbar
      res@lbLabelFontHeightF     = 0.012
;      res@gsnSpreadColors        = False    ; use full color map
      res@cnLevelSelectionMode   = "ExplicitLevels"
      res@lbOrientation          = "vertical"
      res@lbLabelPosition        = "left"

      res@lbLabelStride          = 1
      res@gsnRightString=""

      ; labeling x and y
      res@gsnMajorLatSpacing       = 20              ; change maj lat tm spacing
      res@gsnMajorLonSpacing       = 50              ; change maj lon tm spacing
      res@mpFillOn                 = False
      res@tmXBMinorOn              = True
      res@tmXBLabelFontHeightF     = 0.012           ; resize tick labels
      res@tmYLLabelFontHeightF     = 0.012
      res@gsnAddCyclic             = True 
      res@pmLabelBarOrthogonalPosF = -1.3
      res@tiMainString = ""

      res@gsnLeftString            = leftString
      ;printVarSummary (res)
      return(res)
end



function set_sres_climate()
local sres
begin
      sres=True
      sres@cnFillOn                = True               ; Turn on contour line fill.
      sres@cnMonoFillPattern       = False              ; Turn off using a single fill pattern
      sres@cnMonoFillColor         = True
      sres@cnMonoLineColor         = True
      sres@cnLineLabelsOn          = False
      sres@cnMonoFillColor         = True
      sres@cnInfoLabelOn           = False 
      sres@cnLevelSelectionMode    = "ExplicitLevels"   ; use explicit levels

      sres@tiMainString           = ""
      
      return (sres)
end



function set_xyres_climate(xymin,xymax:float,title:string)
local xyres
begin
   ;;; xy res prec      
   xyres                       = True         ; xy plot mods desired
   xyres@gsnDraw                = False        ; don't draw yet
   xyres@gsnFrame               = False ;True       ; don't advance frame yet
   xyres@vpWidthF               = .45          ; set width of second plot
   xyres@tmXBMinorOn            = True         ; minor tickmarks
   xyres@tmXBLabelStride        = 1            ; label stride
   xyres@tmXBLabelAngleF        = 0.
   xyres@tmXBLabelFontHeightF   = 0.009
   xyres@txFontHeightF          = 0.018        ; change font height
   xyres@tmXBLabelFontHeightF   = 0.001

   xyres@tmYROn                 = True
   xyres@tmYLOn                 = False

   xyres@xyLineColors=(/"blue","red","green","black","orange"/)
   xyres@tiMainString           = ""
   xyres@gsnCenterString        = title  ; add title
   ;xyres@tiMainString           = ""
   xyres@trXMinF                = xymin
   xyres@trXMaxF                = xymax
   return (xyres)
end


function set_zres_climate(zmin,zmax:float,title:string)
local zres
begin
   zres=True
   zres@gsnDraw                 = False; True
   zres@gsnFrame                = False ; True
   zres@tiMainString            = ""
   zres@gsnZonalMeanYRefLine    = 0  ; X-axis reference line value
   zres@amOrthogonalPosF        = 0.375
   zres@gsnCenterString         = title
   zres@gsnZonalMeanXMinF       = zmin       ; set minimum X-axis value for zonal mean plot  
   zres@gsnZonalMeanXMaxF       = zmax       ; set maximum X-axis value for zonal mean plot  
   return (zres)
end



undef("climate")
procedure  climate (prec,temp,grass,forest:float,wkstype,year,output,paneltitle:string)
begin
   wkstype@wkPaperWidthF = 15;
   wkstype@wkPaperHeightF = 10;
   wks = gsn_open_wks(wkstype ,output)    
   cmap=def_colormap
   gsn_define_colormap(wks,cmap)
   ;gsn_draw_colormap(wks)


;;;;; Definitions
   plot = new(2,graphic) 
   
    if (min(temp) .gt. 100 ) then
        temp=temp-273.15
    end if

   ;set_res_climate(levels,colors:float, leftString:string)
   resp=True
   resp=set_res_climate("yearly precipitation [mm]; grass fract. > 35% (shaded)")
   resp@cnFillColors=(/117,118,119,120,121,122,123,124,125,126/)
   resp@cnLevels=(/0,50,100,250,500,750,1000,1500,2000/)
   rest=True
   rest=set_res_climate("2m annual mean temperature [C], woody fraction > 35% (shaded)")
   rest@cnFillColors=(/127,128,129,130,132,133,134,135,136,137,138,139/)
   rest@cnLevels=(/-25.,-20.,-15.,-10.,-5.,0.,5.,10.,15.,20.,25./)
   
   
   sresp=True
   sresp=set_sres_climate()
   srep@cnLevels               = (/0,0.35/)         ; set the contour levels
   srep@cnFillPatterns          = (/-1,-1,17/)
   srest=True
   srest=set_sres_climate()
   sret@cnLevels               = (/0,0.35/)         ; set the contour levels
   sret@cnFillPatterns          = (/-1,-1,17/)
   
   xyresp = True
   xyresp = set_xyres_climate (0.,2100.,"zonal yearly precipitation [mm]")
   xyrest = True
   xyrest = set_xyres_climate (-25.,30.,"zonal averaged annual mean temperature [C]")

   ;;; zonal res prec
   zresp                         = True
   zresp = set_zres_climate(0.,1.,"zonal mean grass frac.[%]")
   zrest                         = True
   zrest = set_zres_climate(0.,1.,"zonal mean woody frac.[%]")

;precipitation
   fig0                          = gsn_csm_contour_map_overlay(wks,add90LatY(prec),add90LatY(grass),resp,sresp)
   zonal_averagep                = new((/2,dimsizes(prec&lat)/),float)
   zonal_averagep(0,:)           = dim_avg(prec)
   xyplotp                       = gsn_csm_xy(wks, zonal_averagep,prec&lat,xyresp)
   returnplot                    = gsn_attach_plots(fig0,(/xyplotp/),resp,xyresp)
   plot(0)                       = gsn_csm_attach_zonal_means(wks,fig0,grass,zresp)

; TEMPERATURE
   fig1                          = gsn_csm_contour_map_overlay(wks,add90LatY(temp),add90LatY(forest),rest,srest)
   zonal_averaget                = new((/1,dimsizes(temp&lat)/),float)
   zonal_averaget(0,:)           = dim_avg(temp)
   xyplott                       = gsn_csm_xy(wks, zonal_averaget,temp&lat,xyrest)
   returnplot2                   = gsn_attach_plots(fig1,(/xyplott/),rest,xyrest)
   plot(1)                       = gsn_csm_attach_zonal_means(wks,fig1,forest,zrest)

; combine both
   resPanel=True
   resPanel=set_panel_settings(resPanel,paneltitle,year,"")
   gsn_panel(wks,(/fig0,fig1/),(/1,2/),resPanel) 

end



undef("climatediff")
procedure  climatediff (prec,temp,grass,forest:float,wkstype,year,output,paneltitle:string)
begin
   wkstype@wkPaperWidthF = 15;
   wkstype@wkPaperHeightF = 10;
   wks = gsn_open_wks(wkstype ,output)    
   cmap=def_colormap
   gsn_define_colormap(wks,cmap)
   ;gsn_draw_colormap(wks)


;;;;; Definitions
   plot = new(2,graphic) 
   
    if (min(temp) .gt. 100 ) then
        temp=temp-273.15
    end if


;1d
   area=get_area("T31",0.,360.,-90,90.)
   tarea=dim_sum(dim_sum(area))

   gtdiff=dim_sum(dim_sum(temp*area))/tarea
   gpdiff=dim_sum(dim_sum(prec*area))/tarea


   ;set_res_climate(levels,colors:float, leftString:string)
   resp=True
   resp=set_res_climate("change in yearly precipitation [mm]")
   resp@cnFillColors=(/117,118,119,120,121,122,123,124,125,126/)
   resp@cnLevels=(/-500,-250,-100,-50,0,50,100,250,500/)
   rest=True
   rest=set_res_climate("change in 2m annual mean temperature [C]")
   rest@cnFillColors=(/127,128,129,130,132,133,134,135,136,137,138,139/)
   rest@cnLevels=(/-2.5,-2.,-1.5,-1.,-0.5,0.,0.5,1.,1.5,2.,2.5/)
   
   
   ;sresp=True
   ;sresp=set_sres_climate()
   ;sresp@cnLevels                = (/-0.01,0.01/)
   ;sresp@cnFillPatterns          = (/1,-1,15/)
   ;srest=True
   ;srest=set_sres_climate()
   ;srest@cnLevels                = (/-0.35,0.35/)
   ;srest@cnFillPatterns          = (/1,-1,15/)
   xyresp = True
   xyresp = set_xyres_climate (-200.,200.,"zonal yearly precipitation [mm]")
   xyrest = True
   xyrest = set_xyres_climate (-2.5,2.5,"zonal averaged annual mean temperature [C]")

   ;;; zonal res prec
   zresp                         = True
   zresp = set_zres_climate(-0.1,0.1,"zonal mean grass frac.[%]")
   zrest                         = True
   zrest = set_zres_climate(-0.1,0.1,"zonal mean woody frac.[%]")






;precipitation
;   fig0                          = gsn_csm_contour_map_overlay(wks,add90LatY(prec),add90LatY(grass),resp,sresp)
   fig0                          = gsn_csm_contour_map (wks,add90LatY(prec),resp)
   zonal_averagep                = new((/2,dimsizes(prec&lat)/),float)
   zonal_averagep(0,:)           = dim_avg(prec)
   xyplotp                       = gsn_csm_xy(wks, zonal_averagep,prec&lat,xyresp)
   returnplot                    = gsn_attach_plots(fig0,(/xyplotp/),resp,xyresp)
   plot(0)                       = gsn_csm_attach_zonal_means(wks,fig0,grass,zresp)

; TEMPERATURE
;   fig1                          = gsn_csm_contour_map_overlay(wks,add90LatY(temp),add90LatY(forest),rest,srest)
   fig1                          = gsn_csm_contour_map (wks,add90LatY(temp),rest)
   zonal_averaget                = new((/1,dimsizes(temp&lat)/),float)
   zonal_averaget(0,:)           = dim_avg(temp)
   xyplott                       = gsn_csm_xy(wks, zonal_averaget,temp&lat,xyrest)
   returnplot2                   = gsn_attach_plots(fig1,(/xyplott/),rest,xyrest)
   plot(1)                       = gsn_csm_attach_zonal_means(wks,fig1,forest,zrest)

; combine both
   resPanel=True
   resPanel=set_panel_settings(resPanel,paneltitle,year,"")
   gsn_panel(wks,(/fig0,fig1/),(/1,2/),resPanel) 

end




undef ("xy1d")
procedure xy1d (data:float,wkstype,output,title:string)
local res
begin
   res=True
   wks = gsn_open_wks(wkstype ,output)    
   cmap=def_colormap
   gsn_define_colormap(wks,cmap)

    res@xyLineThicknesses = (/1.0,2.0/)               ; make 2nd lines thicker
      
    res@xyLineColors           = (/"blue","red","green"/)          ; change line color
      
    res@pmLegendDisplayMode    = "Always"   ; Display a legend.
    res@pmLegendWidthF         = 0.2        ; Make it smaller
    res@pmLegendHeightF        = 0.1        ; Make it smaller
    res@pmLegendOrthogonalPosF = -0.32      ; Move into to plot
    res@pmLegendParallelPosF   =  0.75      ; Move to right
    res@lgPerimOn              = False      ; No legend perimeter.
    res@lgLabelFontHeightF     = 0.01
   
   res@tiMainString=title        ; add title
   plot  = gsn_csm_y (wks,data,res) ; create plot
end


undef ("xyfireclim")
procedure xyfireclim(data:float,colorvec:string,xaxisstring,yaxisstring:string,wkstype,output,paneltitle:string,XBValues:integer, XBLabels:string)
begin
    res=True
    res@tmXBMode      = "Explicit" ; label independently
	res@tmXBValues    = XBValues
	res@tmXBLabels    = XBLabels
    dims=dimsizes(data)
    rank=dimsizes(dims)
    print(dims+" "+rank)
    printVarSummary(data)
   
    if (rank.eq.1) then
        nplot=1
        ntime=dims(0)
    else
        nplot=dims(0)
        ntime=dims(1)
    end if 
    
 
    print(nplot+" "+ntime)
    wks = gsn_open_wks(wkstype ,output)    
    cmap=def_colormap

    gsn_define_colormap(wks,cmap)
    res@xyLineThicknesses = (/1.0,2.0/)               ; make 2nd lines thicker
      
    ;res@xyLineColors           = colorvec          ; change line color
      
    ;res@pmLegendDisplayMode    = "Always"   ; Display a legend.
    res@pmLegendWidthF         = 0.2        ; Make it smaller
    res@pmLegendHeightF        = 0.1        ; Make it smaller
    res@pmLegendOrthogonalPosF = -0.32      ; Move into to plot
    res@pmLegendParallelPosF   =  0.75      ; Move to right
    res@lgPerimOn              = False      ; No legend perimeter.
    res@lgLabelFontHeightF     = 0.01
   


    res@tfPolyDrawOrder       = "PreDraw"    ; Draw any attached primitives
                                           ; before rest of plot.

;    res@tmXBOn                = False
    res@tmYLLabelFontHeightF  = 0.03      ; resize tick labels
    res@tmYRLabelFontHeightF  = 0.03
     res@tmYLLabelStride    = 2
     res@tmYRLabelStride    = 2


  res@gsnDraw              = False
  res@gsnFrame             = False

  res@vpWidthF             = 0.80          ; change aspect ratio of plot
  res@vpHeightF            = 0.25

   ; just print 1000yr steps
;   times=data&time/10000
    res@tiMainString=paneltitle        ; add title
    ;res@tmYRMode="Explicit"
    ;res@tmYLMode="Explicit"
    ;res@trYMinF                = -1.5
    ;res@trYMaxF                = 1.5

;    res@YRValues=(/-0.6,-0.3,0.,0.3,0.6/)
;    res@YLValues=(/-0.6,-0.3,0.,0.3,0.6/)

; plot  = gsn_csm_xy (wks,tlc2&time,data,res) ; create plot
    plot=new(nplot,graphic)
    res@tiYAxisSide=""
    do iplot=0,nplot-1
        res@tmXTOn=(iplot.eq.0)      
        res@tmXBOn=(iplot.eq.nplot-1)
        if ( res@tiYAxisSide.eq."Right" ) then 
            res@tiYAxisSide="Left"
            res@tmYRLabelsOn=False 
            res@tmYLLabelsOn=True 
        else 
            res@tiYAxisSide="Right" 
            res@tmYRLabelsOn=True 
            res@tmYLLabelsOn=False 
        end if

;        res@tmXBMode             = "Explicit"
        ;res@tmXBValues           = xindexc  
        ;res@tmXBLabels           = xlabelc  
        res@tmXBLabelFontHeightF = 0.02
        res@xyLineColor          = colorvec(iplot)
        res@tiYAxisString        = yaxisstring(iplot)
        res@tiXAxisString        = xaxisstring
        res@tiYAxisFontColor     = res@xyLineColor
        res@tmYLLabelFontColor   = res@xyLineColor

        if ( rank.eq.1) then
            plot(iplot)=gsn_csm_y(wks,data(:),res) ; create plot, if there is just one timeline
        else
            plot(iplot)  = gsn_csm_y(wks,data(iplot,:),res) ; create plot
        end if
    end do
    
    if (rank.eq.1) then
        ;respanel=True
        pres = False               ; No resources needed
        ;maximize_output(wks,pres)  ; Maximize plot on page
    else
        attachres1                     = True
        attachres1@gsnAttachPlotsXAxis = True  ;; attaches along x-axis
        attachres1@gsnAttachBorderOn   = False ;; No border please
        attachres2                     = True
        attachres2@gsnAttachPlotsXAxis = True  ;; attaches along x-axis
        attachres2@gsnAttachBorderOn   = False ;; No border please

        attachid1  = gsn_attach_plots(plot(0),plot(1:(nplot-1)),attachres1,attachres2)

        respanel=True
        pres = False               ; No resources needed
        maximize_output(wks,pres)  ; Maximize plot on page
    end if
    
end


undef ("xyfirezscore")
procedure xyfirezscore(data:float,options:logical)
begin
    res=True
    colorvec=options@colors
    xaxisstring=options@xstring
    yaxisstring=options@ystrings
    wkstype=options@wks
    output=options@output
    paneltitle=options@title
    XBValues=options@XBValues
    XBLabels=options@XBLabels
        
    res@tmXBMode      = "Explicit" ; label independently
	res@tmXBValues    = XBValues
	res@tmXBLabels    = XBLabels

    dims=dimsizes(data)
    rank=dimsizes(dims)
    if (rank.eq.1) then
        nplot=1
        ntime=dims(0)
    else
        nplot=dims(0)
        ntime=dims(1)
    end if 
    wks = gsn_open_wks(wkstype ,output)    
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)
    res@xyLineThicknessF = 1.0

    res@pmLegendWidthF         = 0.2        ; Make it smaller
    res@pmLegendHeightF        = 0.1        ; Make it smaller
    res@pmLegendOrthogonalPosF = -0.32      ; Move into to plot
    res@pmLegendParallelPosF   =  0.75      ; Move to right
    res@lgPerimOn              = False      ; No legend perimeter.
    res@lgLabelFontHeightF     = 0.01
   
    res@tfPolyDrawOrder       = "PreDraw"    ; Draw any attached primitives
                                             ; before rest of plot.
;    res@tmXBOn                = False
    res@tmYLLabelFontHeightF  = 0.01      ; resize tick labels
    res@gsnDraw              = False
    res@gsnFrame             = False
    res@vpWidthF             = 0.80          ; change aspect ratio of plot
    res@vpHeightF            = 0.25
    res@tiMainString=paneltitle        ; add title

     if (options@autoscaling) then
        res@tmYRMode="Explicit"
        res@tmYLMode="Explicit"
        res@trYMinF                = options@ymin
        res@trYMaxF                = options@ymax
     end if

    plot=new(nplot,graphic)
    res@tiYAxisSide=""
    res@tmYLLabelStride    = 2
    res@tmYRLabelStride    = 2
    res@tmYLLabelFontHeightF=0.04
    res@tmYRLabelFontHeightF=0.04
    res@tmXBLabelFontHeightF=0.04

    do iplot=0,nplot-1
        res@tmXTOn=(iplot.eq.0)      
        res@tmXBOn=(iplot.eq.nplot-1)
        if ( res@tiYAxisSide.eq."Right" ) then 
            res@tiYAxisSide="Left"
            res@tmYRLabelsOn=False 
            res@tmYLLabelsOn=True
        else 
            res@tiYAxisSide="Right"
            res@tmYRLabelsOn=True 
            res@tmYLLabelsOn=False 
        end if

        res@xyLineColor          = colorvec(iplot)
        res@tiYAxisString        = yaxisstring(iplot)
        res@tiXAxisString        = xaxisstring
        res@tiYAxisFontColor     = res@xyLineColor
        res@tmYLLabelFontColor   = res@xyLineColor
        if ( rank.eq.1) then
            plot(iplot)=gsn_csm_y(wks,data(:),res) ; create plot, if there is just one timeline
        else
            plot(iplot)  = gsn_csm_y(wks,data(iplot,:),res) ; create plot
        end if
    end do
    
    if (rank.eq.1) then
        ;respanel=True
        pres = False               ; No resources needed
        ;maximize_output(wks,pres)  ; Maximize plot on page
    else
        attachres1                     = True
        attachres1@gsnAttachPlotsXAxis = True  ;; attaches along x-axis
        attachres1@gsnAttachBorderOn   = False ;; No border please
        attachres2                     = True
        attachres2@gsnAttachPlotsXAxis = True  ;; attaches along x-axis
        attachres2@gsnAttachBorderOn   = False ;; No border please

        attachid1  = gsn_attach_plots(plot(0),plot(1:(nplot-1)),attachres1,attachres2)

        respanel=True
        pres = False               ; No resources needed
        maximize_output(wks,pres)  ; Maximize plot on page
    end if    
end



function set_basics_hoff_opt(opt:logical)
begin
    opt=True
    opt@ano=True
    opt@baseStart=7900
    opt@baseEnd=7999
    opt@smooth=True
    opt@nave=101

    return opt
end



function prepare_hoff(data:float,opt:logical)
begin
    print (opt@ano)
    print (opt@baseStart)
    print (opt@baseEnd)
    print (opt@smooth)
    print (opt@nave)
    
    if ( opt@ano) then
        data=data-conform_dims(dimsizes(data),dim_avg_n(data(opt@baseStart:opt@baseEnd,:),0),1)
    end if 

    plotdata=data(lat|:,time|:)
    plotdata!0 = data!1
    plotdata!1 = data!0
    plotdata&lat = data&lat
    plotdata&time = data&time

    if (opt@smooth) then
        plotdata=runave_n_Wrap(plotdata,opt@nave,0,1)
    end if

    plotdata&time = data&time/10000 ;-8000
    plotdata&lat@units=data&lat@units
    plotdata&time@units=data&time@units    

    return plotdata
end




function prepare_hoff_temp(fn:string)
begin
    ;open file
    f=addfile(fn,"r")
    data=f->air_temp(:,:,0)
    printVarSummary(data)
    opt=True
    opt=set_basics_hoff_opt(opt)
    plotdata=prepare_hoff (data,opt)
    return plotdata
end


function prepare_hoff_prec(fn:string)
begin
    ;open file
    f=addfile(fn,"r")
    data=f->precip(:,:,0)
    printVarSummary(data)
    opt=True
    opt=set_basics_hoff_opt(opt)
    plotdata=prepare_hoff (data,opt)
    return plotdata
end

function prepare_hoff_cpools(fn:string)
begin
    ;open file
    f=addfile(fn,"r")
    data=f->box_Cpools_total(:,:,0)
    printVarSummary(data)
    opt=True
    opt=set_basics_hoff_opt(opt)
    plotdata=prepare_hoff (data,opt)
    return plotdata
end


undef ("prepare_hoff_coverfraction")
function prepare_hoff_coverfraction (fn:string)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin
   
   data=addfile(fn, "r")
   
;3d   
   ;3d
   area=get_area("T31",0.,360.,-90.,90.)
   cover_fract=data->cover_fract(:,:,:,:)
   veg_fract_correction=data->veg_fract_correction(:,:,:,:)
   veg_ratio_max=data->veg_ratio_max(:,:,:)

    

   dims=dimsizes(veg_ratio_max)
   ntime=dims(0)
   nlat=dims(1)
   nlon=dims(2)

   coverfraction=new((/5,ntime,nlat,nlon/),float,MyFillValue)

   copy_VarAtts(cover_fract,coverfraction)
   timeunit=cover_fract&time@units
   latunit=cover_fract&lat@units

   coverfraction!0="pfts"
   coverfraction!1="time"
   coverfraction!2="lat"

   coverfraction&time=cover_fract&time
   coverfraction&lat=cover_fract&lat
   coverfraction&time@units=timeunit
   coverfraction&lat@units=latunit


   ;desert
   coverfraction(0,:,:)=dim_avg_n_Wrap(1.-veg_ratio_max,2)
   ;woody
   coverfraction(1,:,:)=dim_avg_Wrag_n(veg_ratio_max*dim_sum_n_Wrap(cover_fract(0:5,:,:,:),0),3)
   ;tree
   coverfraction(2,:,:)=dim_avg_Wrag_n(veg_ratio_max*dim_sum_n_Wrap(cover_fract(0:3,:,:),0),3)
   ;shrubs
   coverfraction(3,:,:)=dim_avg_Wrag_n(veg_ratio_max*dim_sum_n_Wrap(cover_fract(4:5,:,:),0),3)
   ;grass
   coverfraction(4,:,:)=dim_avg_Wrag_n(veg_ratio_max*dim_sum_n_Wrap(cover_fract(6:7,:,:),0),3)

   return coverfraction
end


undef ("prepare_hoff_desert")
function prepare_hoff_desert (fn:string)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin
   f=addfile(fn, "r")
   
;3d   
   data=f->veg_ratio_max(:,:,0)
   data2=1-f->veg_ratio_max(:,:,0)
    
   copy_VarCoords(data,data2)
   
   printVarSummary(data)
   printVarSummary(data2)
   opt=True
   opt=set_basics_hoff_opt(opt)
   plotdata=prepare_hoff (data2,opt)
   return plotdata
end


undef ("prepare_hoff_fire")
function prepare_hoff_fire (fn:string)
local data,cover_fract,veg_fract_correction,veg_ratio_max,dims,nlat,nlon,coverfraction
begin
   f=addfile(fn, "r")
   
;3d
   area=get_area("T31",0.,360.,-90.,90.)
   data=f->box_burned_acc(:,:,:)
   area3d=conform_dims(dimsizes(data),area,(/1,2/))   
   
   printVarSummary(data)
    printVarSummary(area3d)
    data2=365.25 / 1e10*data*area3d
   copy_VarCoords(data,data2)
   data3=dim_avg_n_Wrap(data2,2)


   printVarSummary(data3)
   print(min(data3))
   print(max(data3))

   opt=True
   opt=set_basics_hoff_opt(opt)
   plotdata=prepare_hoff (data3,opt)
   return plotdata
end





procedure plot_hoff_temp_ano(data:float,wkstype,output,title:string)
begin
    wks   = gsn_open_wks (wkstype, output )  ; open workstation 
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)

    res                  = True                ; plot mods desired
    res@tiMainString     = title               ; title
    ;res@tmXBLabelStride  = 2                   ; tick mark label stride
    res@tiYAxisString    = "latitude"              ; y axis title

    res@cnFillOn         = True                ; color on
    res@cnFillMode = "RasterFill"

    res@cnLevelSelectionMode = "ExplicitLevels"
    res@cnFillColors=(/127,128,129,130,132,133,134,135,136,137,138,139/)
    res@gsnRightString= "[K]"
    res@cnLevels=(/-1.,-.8,-.6,-.4,-.2,0.,0.2,0.4,.6,.8,1./)
    ;res@lbLabelStride    = 2                   ; every other label
    res@lbOrientation    = "Vertical"          ; vertical label bar
    res@cnLinesOn        = False               ; turn off contour lines
    res@gsnSpreadColors  = True                ; use full range of color map
    ;res@cnLevelSpacingF  = 5                   ; contour spacing

    plot = gsn_csm_time_lat(wks, data, res ) 

end



procedure plot_hoff_prec_ano(data:float,wkstype,output,title,conversion:string)
begin
    wks   = gsn_open_wks (wkstype, output )  ; open workstation 
    data=convert_prec(data,conversion)
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)

    res                  = True                ; plot mods desired
    res@tiMainString     = title               ; title
    ;res@tmXBLabelStride  = 2                   ; tick mark label stride
    res@tiYAxisString    = "latitude"              ; y axis title

    res@cnFillOn         = True                ; color on
    res@cnFillMode = "RasterFill"

    res@cnLevelSelectionMode = "ExplicitLevels"
    res@cnLevels = (/-250,-200,-150,-100,-50,-10,10,50,100,150,200,250/)
    res@cnFillColors = (/139,138,137,136,135,134,0,133,132,131,130,129,128/) 
    res@gsnRightString= "["+data@units+"]"

    ;res@lbLabelStride    = 2                   ; every other label
    res@lbOrientation    = "Vertical"          ; vertical label bar
    res@cnLinesOn        = False               ; turn off contour lines
    res@gsnSpreadColors  = True                ; use full range of color map
    ;res@cnLevelSpacingF  = 5                   ; contour spacing

    plot = gsn_csm_time_lat(wks, data, res ) 

end


procedure plot_hoff_cpools_ano(data:float,wkstype,output,title:string)
begin
    wks   = gsn_open_wks (wkstype, output )  ; open workstation 
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)
    printVarSummary(data)
    res                  = True                ; plot mods desired
    res@tiMainString     = title               ; title
    ;res@tmXBLabelStride  = 2                   ; tick mark label stride
    res@tiYAxisString    = "latitude"              ; y axis title

    res@cnFillOn         = True                ; color on
    res@cnFillMode = "RasterFill"

    res@cnLevelSelectionMode = "ExplicitLevels"
    res@cnLevels = (/-5.00,-2.50,-1.00,-0.50,-0.25,-0.05,0.05,0.25,0.50,1.00,2.50,5.00/)
    res@cnFillColors = ispan(13,25,1) 
    res@gsnRightString= "[Kg C m-2 (grid box)]"

    ;res@lbLabelStride    = 2                   ; every other label
    res@lbOrientation    = "Vertical"          ; vertical label bar
    res@cnLinesOn        = False               ; turn off contour lines
    res@gsnSpreadColors  = True                ; use full range of color map
    ;res@cnLevelSpacingF  = 5                   ; contour spacing

    plot = gsn_csm_time_lat(wks,data, res ) 

end




procedure plot_hoff_cover(covers:float,wkstype,output,title:string,XBValues:integer, XBLabels:string)
begin
    year="8k-0k"
    wks   = gsn_open_wks (wkstype, output )  ; open workstation 
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)
    res                  = True                ; plot mods desired
    res@tiMainString     = title               ; title
    ;res@tmXBLabelStride  = 2                   ; tick mark label stride
    res@tiYAxisString    = "latitude"              ; y axis title
    res@cnFillOn         = True                ; color on
    res@cnFillMode = "RasterFill"
    res@cnLevelSelectionMode = "ExplicitLevels"
    res@gsnRightString= "[ ]"
    res@lbOrientation    = "Vertical"          ; vertical label bar
    res@cnLinesOn        = False               ; turn off contour lines
    res@gsnSpreadColors  = True                ; use full range of color map
    res@tmXBValues    = XBValues
	res@tmXBLabels    = XBLabels
    res@cnLevels = (/0.0001,0.005,0.01,0.015,0.02,0.025,0.03,0.035,0.04,0.045,0.05/)
    res@gsnDraw              = False
    res@gsnFrame             = False
    resgreen=res
    resdes=res
    plot=new(5,graphic)
    resgreen@cnFillColors = ispan(26,37,1)
    resdes@cnFillColors = ispan(51,62,1)
   ; plotten of absolute values for carbon pools
   ; desert fraction
   resdes@gsnLeftString = "desert fraction: "+year+" [ ]"
   opt=True
   opt=set_basics_hoff_opt(opt)
   opt@ano=False
   hoff=prepare_hoff(covers(0,:,:),opt)
   plot(0) = gsn_csm_time_lat(wks,hoff,resdes) 
   ; woody
    hoff=prepare_hoff(covers(1,:,:),opt)
   resgreen@gsnLeftString = "woody fraction: "+year+" [ ]"
   plot(1) = gsn_csm_time_lat(wks,hoff,resgreen)
   ; green
   hoff=prepare_hoff(covers(2,:,:),opt)
   resgreen@gsnLeftString = "tree fraction: "+year+" [ ]"
   plot(2) = gsn_csm_time_lat(wks, hoff,resgreen)
   ; shrubs
   hoff=prepare_hoff(covers(3,:,:),opt)
   resgreen@gsnLeftString = "shrubs fraction: "+year+" [ ]"
   plot(3) = gsn_csm_time_lat(wks, hoff,resgreen)
   ; grass
   hoff=prepare_hoff(covers(4,:,:),opt)
   resgreen@gsnLeftString = "grass fraction: "+year+" [ ]"
   plot(4) = gsn_csm_time_lat(wks, hoff,resgreen)
   ;plotting the five figures as a panel
   resP=True
   resP=set_panel_settings(resP,title,year,resdes@gsnRightString)
   gsn_panel(wks,plot(0:4),(/1,2,2/),resP)
    ;res@lbLabelStride    = 2                   ; every other label
    ;res@cnLevelSpacingF  = 5                   ; contour spacing
end



procedure plot_hoff_cover_ano(covers:float,wkstype,output,title:string,XBValues:integer, XBLabels:string)
begin
    year="8k-0k"
    wks   = gsn_open_wks (wkstype, output )  ; open workstation 
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)
    res                  = True                ; plot mods desired
    res@tiMainString     = title               ; title
    ;res@tmXBLabelStride  = 2                   ; tick mark label stride
    res@tiYAxisString    = "latitude"              ; y axis title
    res@cnFillOn         = True                ; color on
    res@cnFillMode = "RasterFill"
    res@cnLevelSelectionMode = "ExplicitLevels"
    res@gsnRightString= "[ ]"
    res@lbOrientation    = "Vertical"          ; vertical label bar
    res@cnLinesOn        = False               ; turn off contour lines
    res@gsnSpreadColors  = True                ; use full range of color map
    res@tmXBValues    = XBValues
	res@tmXBLabels    = XBLabels
    res@cnLevels = (/0.0001,0.005,0.01,0.015,0.02,0.025,0.03,0.035,0.04,0.045,0.05/)
    
    resgreen=res
    resdes=res
    plot=new(5,graphic)
    resgreen@cnFillColors = ispan(26,37,1)
    resdes@cnFillColors = ispan(51,62,1)
   
   ; plotten of absolute values for carbon pools
   ; desert fraction
   resdes@gsnLeftString = "desert fraction: "+year+" [ ]"
   opt=True
   opt=set_basics_hoff_opt(opt)
   hoff=prepare_hoff(covers(0,:,:),opt)
   plot(0) = gsn_csm_time_lat(wks,hoff,resdes) 

   ; woody
    hoff=prepare_hoff(covers(1,:,:),opt)

   resgreen@gsnLeftString = "woody fraction: "+year+" [ ]"
   plot(1) = gsn_csm_time_lat(wks,hoff,resgreen)
   ; green
   hoff=prepare_hoff(covers(2,:,:),opt)
   resgreen@gsnLeftString = "tree fraction: "+year+" [ ]"
   plot(2) = gsn_csm_time_lat(wks, hoff,resgreen)
   ; shrubs
   hoff=prepare_hoff(covers(3,:,:),opt)
   resgreen@gsnLeftString = "shrubs fraction: "+year+" [ ]"
   plot(3) = gsn_csm_time_lat(wks, hoff,resgreen)
   ; grass
   hoff=prepare_hoff(covers(4,:,:),opt)
   resgreen@gsnLeftString = "grass fraction: "+year+" [ ]"
   plot(4) = gsn_csm_time_lat(wks, hoff,resgreen)
   
   ;plotting the five figures as a panel
   resP=True
   resP=set_panel_settings(resP,title,year,resdes@gsnRightString)
   gsn_panel(wks,plot(0:4),(/1,2,2/),resP)


    ;res@lbLabelStride    = 2                   ; every other label
    ;res@cnLevelSpacingF  = 5                   ; contour spacing
end




procedure plot_hoff_fire_ano(data:float,wkstype,output,title:string,XBValues:integer, XBLabels:string)
begin
    wks   = gsn_open_wks (wkstype, output )  ; open workstation 
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)
    res                  = True                ; plot mods desired
    res@tmXBMode      = "Explicit" ; label independently
	res@tmXBValues    = XBValues
	res@tmXBLabels    = XBLabels
    
    res@tiMainString     = title               ; title
    ;res@tmXBLabelStride  = 2                   ; tick mark label stride
    res@tiYAxisString    = "latitude"              ; y axis title
    res@tiXAxisString    = "[kyr BP]"              ; y axis title

    res@cnFillOn         = True                ; color on
    res@cnFillMode = "RasterFill"

    res@cnLevelSelectionMode = "ExplicitLevels"

   res@cnLevels = (/-0.1,-0.075,-0.05,-0.025,-0.005,0.005,0.025,0.05,0.075,0.1/)
   res@cnFillColors = ispan(86,96,1)
   res@gsnRightString= "[M ha]"

    ;res@lbLabelStride    = 2                   ; every other label
    res@lbOrientation    = "Vertical"          ; vertical label bar
    res@cnLinesOn        = False               ; turn off contour lines
    res@gsnSpreadColors  = True                ; use full range of color map
    ;res@cnLevelSpacingF  = 5                   ; contour spacing

    plot = gsn_csm_time_lat(wks, data, res ) 

end





procedure plot_hoff_fire_anoII(data:float,wkstype,output,title:string,XBValues:integer, XBLabels:string)
begin

    wks   = gsn_open_wks (wkstype, output )  ; open workstation 
    cmap=def_colormap
    gsn_define_colormap(wks,cmap)

    res                  = True                ; plot mods desired
    
    res@tmXTMode      = "Explicit" ; label independently
	res@tmXTValues    = XBValues
	res@tmXTLabels    = XBLabels
    
    res@tiMainString     = title               ; title
    ;res@tmXBLabelStride  = 2                   ; tick mark label stride
    res@tiYAxisString    = "latitude"              ; y axis title
    ;res@tiXAxisString    = "[kyr BP]"              ; y axis title
    ;res@tiXAxisPosition = "Top"
    res@cnFillOn         = True                ; color on
    res@cnFillMode = "RasterFill"

    res@cnLevelSelectionMode = "ExplicitLevels"

   res@cnLevels = (/-0.1,-0.075,-0.05,-0.025,-0.005,0.005,0.025,0.05,0.075,0.1/)
   res@cnFillColors = ispan(86,96,1)
   res@gsnRightString= "[M ha]"

    ;res@lbLabelStride    = 2                   ; every other label
    res@lbOrientation    = "Vertical"          ; vertical label bar
    res@cnLinesOn        = False               ; turn off contour lines
    res@gsnSpreadColors  = True                ; use full range of color map
    ;res@cnLevelSpacingF  = 5                   ; contour spacing

    res@gsnDraw                  = False            ; don't draw yet
    res@gsnFrame                 = False            ; don't advance frame yet

    res@tmXTOn=True
    res@tmXTLabelsOn=True
    res@tmXBOn=False
    res@tmXTLabelsOn=False

    base_plot = gsn_csm_time_lat(wks, data, res ) 
;---------------------
    printVarSummary(data)
    xy1res=True
    xy1res@tmXTOn=False
    xy1res@tmXBOn=True
    x=ispan(0,dimsizes(data&time)-1,1) 
    y=dim_sum_n_Wrap(data,0)
xy1res@vpHeightF        = .20          ; set width of second plot
    printVarSummary(x)
    printVarSummary(y)

    
    xy1res@tmXBMode      = "Explicit" ; label independently
	xy1res@tmXBValues    = XBValues
	xy1res@tmXBLabels    = XBLabels

    xy1res@gsnDraw         = False        ; don't draw yet
 xy1res@gsnFrame        = False        ; don't advance frame yet
   
    plot2 = gsn_csm_xy(wks, x,y,xy1res)


   xy2res=True
   y2=data&lat 
    x2=dim_avg_n_Wrap(data(:,0:99),1)
xy2res@vpWidthF        = .20          ; set width of second plot
    printVarSummary(x2)
    printVarSummary(y2)

    plot3 = gsn_csm_xy(wks, x2,y2,xy2res)



;    draw(plot2)
   xy1res@gsnAttachPlotsXAxis = True
   gsn_panel(wks, (/base_plot,plot3,plot2/), (/2,2/), False)






;   attached=gsn_attach_plots(base_plot, plot2, res, xy1res)
;   draw(attached)

end


;;set_plot_settings(opt2dmap)
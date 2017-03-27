load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/Volumes/work/m300107/scripts/plot/ncl/libs/climba.ncl"

begin
  wks = gsn_open_wks("png","color")
  cmap=def_colormap
  gsn_define_colormap(wks,cmap)
  gsn_draw_colormap(wks)
end

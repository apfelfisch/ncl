; ------------------------------------------
; Script     : newNCLTemplate.ncl
; Created on : Aug 5, 2013 10:45:07 AM
; Author     : m300107
; ------------------------------------------
; Description:
;   Purpose of the script follows.
; ------------------------------------------

begin
   array=new(11,float)
   array=(/0,1,2,3,4,5,6,7,8,9,10/)
   print(""+array((/0,1,3,9,10/)))

end
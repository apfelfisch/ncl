      PROGRAM convert_color
      
      IMPLICIT NONE
      INTEGER i
      
      REAL fR, fG, fB
      INTEGER iR, iG, iB
      CHARACTER*10, cR, cG, cB
      
      open (1,File="climba.rgb",status="old")
      read (1,*)
      read (1,*)
      do i = 1,140
         read (1,*) iR, iG, iB
         fR= float(iR)/255.
         fG= float(iG)/255.
         fB= float(iB)/255.
         
         write(cR,FMT="(F6.3)") fR
         write(cG,FMT="(F6.3)") fG
         write(cB,FMT="(F6.3)") fB
         write (*,*) '"(/' // TRIM(cR) // ',' // Trim(cG) // ',' //  TRIM(cB) // '/)"' // ', \    ; color no ', i-1
         
         
         
         
      end do
      close (1)
      
      END PROGRAM
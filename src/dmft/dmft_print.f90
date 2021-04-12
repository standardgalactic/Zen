!!!-----------------------------------------------------------------------
!!! project : jacaranda
!!! program : dmft_print_header
!!!           dmft_print_footer
!!!           dmft_print_summary
!!! source  : dmft_print.f90
!!! type    : subroutines
!!! author  : li huang (email:lihuang.dmft@gmail.com)
!!! history : 02/23/2021 by li huang (created)
!!!           04/12/2021 by li huang (last modified)
!!! purpose :
!!! status  : unstable
!!! comment :
!!!-----------------------------------------------------------------------

!!
!! @sub dmft_print_header
!!
!! print the startup information for the dmft/jacaranda code
!!
  subroutine dmft_print_header()
     use constants, only : mystd

     use version, only : V_FULL_ZD
     use version, only : V_AUTH_ZD
     use version, only : V_INST_ZD
     use version, only : V_MAIL_ZD
     use version, only : V_GPL3_ZD

     use control, only : cname
     use control, only : nprocs

     implicit none

! local variables
! string for current date and time
     character (len = 20) :: date_time_string

! obtain current date and time
     call s_time_builder(date_time_string)

# if defined (MPI)

     write(mystd,'(2X,a)') cname//' (Parallelized Edition)'

# else   /* MPI */

     write(mystd,'(2X,a)') cname//' (Sequential Edition)'

# endif  /* MPI */

     write(mystd,'(2X,a)') 'A Modern Dynamical Mean-Field Theory Booster'
     write(mystd,*)

     write(mystd,'(2X,a)') 'Version: '//V_FULL_ZD//' (built at '//__TIME__//" "//__DATE__//')'
     write(mystd,'(2X,a)') 'Develop: '//V_AUTH_ZD//' ('//V_INST_ZD//')'
     write(mystd,'(2X,a)') 'Support: '//V_MAIL_ZD
     write(mystd,'(2X,a)') 'License: '//V_GPL3_ZD
     write(mystd,*)

     write(mystd,'(2X,a)') 'start running at '//date_time_string

# if defined (MPI)

     write(mystd,'(2X,a,i4)') 'currently using cpu cores:', nprocs

# else   /* MPI */

     write(mystd,'(2X,a,i4)') 'currently using cpu cores:', 1

# endif  /* MPI */

     return
  end subroutine dmft_print_header

!!
!! @sub: dmft_print_footer
!!
!! print the ending information for the dmft/jacaranda
!!
  subroutine dmft_print_footer()
     use constants, only : dp
     use constants, only : mystd

     use control, only : cname

     implicit none

! local variables
! string for current date and time
     character (len = 20) :: date_time_string

! used to record the time usage information
     real(dp) :: tot_time

! obtain time usage information
     call cpu_time(tot_time)

! obtain current date and time
     call s_time_builder(date_time_string)

     write(mystd,'(2X,a,f10.2,a)') cname//' >>> total time spent:', tot_time, 's'
     write(mystd,*)

     write(mystd,'(2X,a)') cname//' >>> I am tired and want to go to bed. Bye!'
     write(mystd,'(2X,a)') cname//' >>> happy ending at '//date_time_string

     return
  end subroutine dmft_print_footer

!!
!! @sub dmft_print_summary
!!
!! print the running parameters, only for reference
!!
  subroutine dmft_print_summary()
     use constants, only : mystd

     use control ! ALL

     implicit none

     write(mystd,'(2X,a)') '[configuration parameters] -> core control'
     write(mystd,'(2X,a)') '-----------------------------------------------------'
     write(mystd,'(4X,a16,i10,  2X,a8)') 'model  / value :', model , 'type : i'

     write(mystd,'(2X,a)') '[configuration parameters] -> size control'
     write(mystd,'(2X,a)') '-----------------------------------------------------'
     write(mystd,'(4X,a16,i10,  2X,a8)') 'nsort  / value :', nsort , 'type : i'
     write(mystd,'(4X,a16,f10.5,2X,a8)') 'scale  / value :', scale , 'type : d'

     write(mystd,*)

     return
  end subroutine dmft_print_summary

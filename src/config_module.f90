module config_module
  implicit none
  private
  public :: simulation_config, read_config

  ! Holds all user‑defined simulation settings
  type :: simulation_config
     real(kind=8) :: diffusivity   ! How quickly heat spreads
     real(kind=8) :: x_min         ! Start of the rod
     real(kind=8) :: x_max         ! End of the rod
     integer      :: n_points      ! Number of positions along the rod
     real(kind=8) :: t_final       ! Total simulation time
     real(kind=8) :: dt            ! Time step size
     real(kind=8) :: temp_left     ! Fixed temperature at left end
     real(kind=8) :: temp_right    ! Fixed temperature at right end
  end type simulation_config

contains

  ! Reads simulation settings from a simple key/value config file
  subroutine read_config(cfg, filename, ierr)
    type(simulation_config), intent(out) :: cfg
    character(len=*),        intent(in)  :: filename
    integer,                 intent(out) :: ierr

    integer :: ios, unit
    character(len=32) :: key

    ierr = 0
    unit = 10

    ! Open the config file
    open(unit=unit, file=filename, status='old', action='read', iostat=ios)
    if (ios /= 0) then
       ierr = 1   ! Could not open file
       return
    end if

    ! Read key/value pairs in alternating lines
    do
       read(unit, *, iostat=ios) key
       if (ios /= 0) exit

       select case (trim(key))
       case ('diffusivity'); read(unit, *, iostat=ios) cfg%diffusivity
       case ('x_min');       read(unit, *, iostat=ios) cfg%x_min
       case ('x_max');       read(unit, *, iostat=ios) cfg%x_max
       case ('n_points');    read(unit, *, iostat=ios) cfg%n_points
       case ('t_final');     read(unit, *, iostat=ios) cfg%t_final
       case ('dt');          read(unit, *, iostat=ios) cfg%dt
       case ('temp_left');   read(unit, *, iostat=ios) cfg%temp_left
       case ('temp_right');  read(unit, *, iostat=ios) cfg%temp_right
       end select
    end do

    close(unit)

    ! Basic validation checks
    if (cfg%n_points <= 2) ierr = 2
    if (cfg%x_max <= cfg%x_min) ierr = 3
    if (cfg%dt <= 0.0d0 .or. cfg%t_final <= 0.0d0) ierr = 4

  end subroutine read_config

end module config_module

module io_module
  use grid_module, only: line_grid
  implicit none
  private
  public :: write_temperature_csv

contains

  subroutine write_temperature_csv(filename, g, temp)
    character(len=*), intent(in) :: filename
    type(line_grid),  intent(in) :: g
    real(kind=8),     intent(in) :: temp(:)

    integer :: unit, i

    unit = 20
    open(unit=unit, file=filename, status='replace', action='write')

    write(unit, '(A)') 'position,temperature'
    do i = 1, g%n_points
       write(unit, '(F15.8,1x,F15.8)') g%x(i), temp(i)
    end do

    close(unit)
  end subroutine write_temperature_csv

end module io_module

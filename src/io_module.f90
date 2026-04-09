module io_module
  use grid_module, only: line_grid
  implicit none
  private
  public :: write_temperature_csv

contains

  ! Writes the final temperature distribution to a CSV file
  subroutine write_temperature_csv(filename, g, temp)
    character(len=*), intent(in) :: filename
    type(line_grid),  intent(in) :: g
    real(kind=8),     intent(in) :: temp(:)

    integer :: unit, i

    unit = 20

    ! Create or overwrite the output file
    open(unit=unit, file=filename, status='replace', action='write')

    ! Header row for spreadsheet/plotting tools
    write(unit, '(A)') 'position,temperature'

    ! Write each position and its temperature
    do i = 1, g%n_points
       write(unit, '(F15.8,1x,F15.8)') g%x(i), temp(i)
    end do

    close(unit)
  end subroutine write_temperature_csv

end module io_module

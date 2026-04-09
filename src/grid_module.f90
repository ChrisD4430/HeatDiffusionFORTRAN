module grid_module
  implicit none
  private
  public :: line_grid, init_grid

  type :: line_grid
     real(kind=8), allocatable :: x(:)
     real(kind=8)              :: dx
     integer                   :: n_points
  end type line_grid

contains

  subroutine init_grid(g, x_min, x_max, n_points)
    type(line_grid), intent(out) :: g
    real(kind=8),    intent(in)  :: x_min, x_max
    integer,         intent(in)  :: n_points

    integer :: i

    g%n_points = n_points
    allocate(g%x(n_points))
    g%dx = (x_max - x_min) / real(n_points - 1, kind=8)

    do i = 1, n_points
       g%x(i) = x_min + real(i - 1, kind=8) * g%dx
    end do
  end subroutine init_grid

end module grid_module

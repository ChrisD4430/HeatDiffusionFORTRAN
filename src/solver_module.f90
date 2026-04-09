module solver_module
  use grid_module, only: line_grid
  implicit none
  private
  public :: initialize_temperature, step_diffusion

contains

  subroutine initialize_temperature(g, temp, temp_left, temp_right)
    type(line_grid), intent(in)  :: g
    real(kind=8),    intent(out) :: temp(:)
    real(kind=8),    intent(in)  :: temp_left, temp_right

    integer :: i
    real(kind=8) :: center, width

    center = 0.5d0 * (g%x(1) + g%x(g%n_points))
    width  = 0.1d0 * (g%x(g%n_points) - g%x(1))

    do i = 1, g%n_points
       temp(i) = exp(-((g%x(i) - center)**2) / (2.0d0 * width**2))
    end do

    temp(1)            = temp_left
    temp(g%n_points)   = temp_right
  end subroutine initialize_temperature

  subroutine step_diffusion(g, temp, diffusivity, dt)
    type(line_grid), intent(in)    :: g
    real(kind=8),    intent(inout) :: temp(:)
    real(kind=8),    intent(in)    :: diffusivity, dt

    integer :: i, n
    real(kind=8) :: factor
    real(kind=8), allocatable :: temp_new(:)

    n = g%n_points
    allocate(temp_new(n))
    temp_new = temp

    factor = diffusivity * dt / (g%dx**2)

    do i = 2, n - 1
       temp_new(i) = temp(i) + factor * (temp(i+1) - 2.0d0*temp(i) + temp(i-1))
    end do

    temp_new(1) = temp(1)
    temp_new(n) = temp(n)

    temp = temp_new
    deallocate(temp_new)
  end subroutine step_diffusion

end module solver_module

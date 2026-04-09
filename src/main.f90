program heat_diffusion_calculator
  use config_module, only: simulation_config, read_config
  use grid_module,   only: line_grid, init_grid
  use solver_module, only: initialize_temperature, step_diffusion
  use io_module,     only: write_temperature_csv
  implicit none

  type(simulation_config) :: cfg
  type(line_grid)         :: g
  real(kind=8), allocatable :: temp(:)
  integer :: ierr, nsteps, step
  real(kind=8) :: t

  ! Load simulation settings from config file
  call read_config(cfg, 'config/heat_config.in', ierr)
  if (ierr /= 0) stop "Configuration error"

  ! Build the grid (positions along the rod)
  call init_grid(g, cfg%x_min, cfg%x_max, cfg%n_points)
  allocate(temp(g%n_points))

  ! Create the initial temperature distribution
  call initialize_temperature(g, temp, cfg%temp_left, cfg%temp_right)

  ! Determine how many update steps to run
  nsteps = int(cfg%t_final / cfg%dt)
  t = 0.0d0

  ! Main simulation loop
  do step = 1, nsteps
     call step_diffusion(g, temp, cfg%diffusivity, cfg%dt)
     t = t + cfg%dt
  end do

  ! Save the final temperature profile
  call write_temperature_csv('output/final_temperature.csv', g, temp)

  deallocate(temp)
end program heat_diffusion_calculator

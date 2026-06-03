This is my case setup for simulating flow over a 2D circular cylinder with wall-resolved LES at Re_D=3,900. Recorded presentation can be found at: https://www.youtube.com/watch?v=F_OGBEyhJ2c&t=1s

The caes setup also includes the UDF for 1 circular nozzle SJAs control parameters under 0/U.

A few things to note:
- An auxiliary case to simulate the baseline unactuated flow with WR-LES was performed first, the developed field is then mapped over to initialize the actuated case. I do not recommend skipping this step (last time I tried, the time steps went down to nano seconds...).
- The SJA BC is based on the pulsing laminar pipe flow analystic Womersley solution, it is currently modulated at a duty cycle (DC) of 50%, the step input signal is tapered to avoid numerical instability. For proper implementation fo this BC, read and cite : Palumbo et al., 2022 (https://doi.org/10.1063/5.0128798) and Ho et al., 2024 (https://doi.org/10.1115/1.4064185).
- Due to the periodic nature of the SJA, varying time step can save significant computationl cost, but it intorduces numerical instability approaching every saved time step, therefore I suggest switching back to constant dt when sampling.
- Currently, there is no controlDict, I toggle/rename the controlDict-pre-sampling or controlDict-sampling before executing job. The pre-sampling is more relaxed with varying dt and only monitors C_D and C_L + probe data; the sampling controlDict includes time-averaging 
- For the patch names: jet_1 = SJA nozzle #1 (#2-5 were omitted from the setup); walls_sja = actuated cylinder surface (red zone from slide 4 of the video); walls = non-actauted surface (grey zone); neck_walls = sja neck side walls
- For increased accuracy, cubic root filter can be replaced with max dxdydz.
- Brief comment on the results - 1 SJA is not enough, debug with 1 then 5 SJAs, but use 9+ for the serious cases.

"Who owns the mesh, owns the solution" - Hrvoje Jasak 

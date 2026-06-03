This is my case setup for simulating flow over a 2D circular cylinder with wall-resolved LES at Re_D=3,900. The caes setup also includes the UDF for the 1 circular nozzle SJAs control parameters under 0/U.

A few things to note:
- An auxiliary case to simulate the baseline unactuated flow was performed first, the developed field is then mapped over to initialize the actuated case. I do not recommend skipping this step (last time I tried, the time steps went down to nano seconds...).
- The SJA BC is based on the pulsing laminar pipe flow analystic Womersley solution, it is currently modulated at a duty cycle (DC) of 50%, the step input signal is tapered to avoid numerical instability.
- Due to the periodic nature of the SJA, varying time step can save significant computationl cost, but it intorduces numerical instability approaching every saved time step, therefore I suggest switching back to constant dt when sampling.
- For increased accuracy, cubic root filter can be replaced with max dxdydz.
- Brief comment on the results - 1 SJA is not enough, debug with 1 then 5 SJAs, but start with 10 for the serious cases.

"Who owns the mesh, owns the solution". - Hrvoje Jasak 

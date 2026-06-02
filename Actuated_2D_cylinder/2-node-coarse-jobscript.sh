#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=192
#SBATCH --time=23:45:00
#SBATCH --job-name=## Input Job name##
#SBATCH --output=output/openmp_output_%j.txt
#SBATCH ##Input allocation name##
#SBATCH --dependency=singleton

cd $SCRATCH/sja-cylinder-cases/coarse-v4-half-dc-50

module load StdEnv/2023
module load gcc/12.3
module load openmpi/4.1.5
module load openfoam/v2412

mpirun -np 384 pimpleFoam -parallel > log-1
mpirun -np 384 pimpleFoam -parallel -postProcess -func yPlus > log-yPlus
mpirun -np 384 pimpleFoam -parallel -postProcess -func wallShearStress


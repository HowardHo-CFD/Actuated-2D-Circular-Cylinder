#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=192
#SBATCH --time=03:30:00
#SBATCH --job-name=pre-LES
#SBATCH --output=output/openmp_output_%j.txt
#SBATCH --mail-type=FAIL

cd $SCRATCH/sja-cylinder-cases/coarse-v4-half-dc-50

module load StdEnv/2023
module load gcc/12.3
module load openmpi/4.1.5
module load openfoam/v2412

fluent3DMeshToFoam coarse-v4-off-12M.msh > log-meshing
changeDictionary > log-changeDict
checkMesh -allGeometry > log-checkMesh
decomposePar -force > log-decompose
mapFields -sourceTime 'latestTime' ../coarse-v4-off -parallelSource -parallelTarget

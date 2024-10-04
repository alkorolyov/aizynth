#!/bin/bash

project_dir="/homes/alexander.korolyov/projects/aizynth"
config_file="$project_dir/config/config.yml"
nproc=28

run_aizynthcli() {
  local smiles_file=$1

  smiles_basename=$(basename "$smiles_file")
  output_file="$project_dir/results/${smiles_basename%.*}_az.json.gz"

  printf "Job started: %s\n" "$smiles_basename"

  rm -f *.log

  cmd="aizynthcli --smiles $smiles_file --output $output_file --config $config_file --nproc $nproc --cluster"
  
  start_time=$(date +%s)
  $cmd
  end_time=$(date +%s)

  total_count=$(cat *.log | grep -c "solved")
  not_solved_count=$(cat *.log | grep -c "not solved")
  solved_count=$((total_count - not_solved_count))

  printf "Solved [%d / %d]\n" $solved_count $total_count

  elapsed_time=$((end_time - start_time))
  hours=$((elapsed_time / 3600))
  minutes=$(( (elapsed_time % 3600) / 60 ))
  seconds=$((elapsed_time % 60))

  printf "Elapsed time for %s: %02d:%02d:%02d\n" "$smiles_basename" $hours $minutes $seconds
  printf "Results saved in $output_file\n"
  printf "==================================================================================\n"
}


run_aizynthcli "data/gdb_1000.smi"
#run_aizynthcli "data/chembl_10000.smi"

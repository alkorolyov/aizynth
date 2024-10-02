#!/bin/bash

run_aizynthcli() {
  local smiles_file=$1
  local output_file=$2
  local config_file="config/config.yml"
  local nproc=8

  smiles_basename=$(basename "$smiles_file")
  printf "Job started: %s\n" "$smiles_basename"

  rm *.log

  cmd="aizynthcli --smiles $smiles_file --output $output_file --config $config_file --nproc $nproc --cluster"
  
  start_time=$(date +%s)
  $cmd
  end_time=$(date +%s)

  total_count=$(cat *.log | grep "solved" | wc -l)
  not_solved_count=$(cat *.log | grep "not solved" | wc -l)
  solved_count=$((total_count - not_solved_count))

  printf "Solved [%d / %d]\n" $solved_count $total_count

  elapsed_time=$((end_time - start_time))
  hours=$((elapsed_time / 3600))
  minutes=$(( (elapsed_time % 3600) / 60 ))
  seconds=$((elapsed_time % 60))

  printf "Elapsed time for %s: %02d:%02d:%02d\n" "$smiles_basename" $hours $minutes $seconds
  printf "==================================================================================\n"
}

run_aizynthcli "data/gdb_8.smi" "results/gdb_8_az.json.gz"
run_aizynthcli "data/chembl_8.smi" "results/chembl_8_az.json.gz"

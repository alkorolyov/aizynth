cmd="aizynthcli --smiles data/gdb_1000.smi --output results/gdb_1000_az.json.gz --nproc 48 --cluster --config config/config.yml"

start_time=$(date +%s)
$cmd
end_time=$(date +%s)

elapsed_time=$((end_time - start_time))
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

printf "Elapsed time: %02d:%02d:%02d\n" $hours $minutes $seconds

cmd="aizynthcli --smiles data/chembl_1000.smi --output results/chembl_1000_az.json.gz --nproc 48 --cluster --config config/config.yml"

start_time=$(date +%s)
$cmd
end_time=$(date +%s)

elapsed_time=$((end_time - start_time))
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

printf "Elapsed time: %02d:%02d:%02d\n" $hours $minutes $seconds

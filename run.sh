cmd="aizynthcli --smiles data/100_rnd.smi --config config/config.yml --stocks molport_7d --nproc 48"

# Record the start time
start_time=$(date +%s)

# Your script or commands go here
$cmd

# Record the end time
end_time=$(date +%s)

# Calculate the time difference
elapsed_time=$((end_time - start_time))

# Convert seconds to hours, minutes, and seconds
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

# Print the elapsed time
printf "Elapsed time: %02d:%02d:%02d\n" $hours $minutes $seconds

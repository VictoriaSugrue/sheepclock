module load BEDTools

readarray folders < folders.txt # Each folder has a fraction of the total BED files from the Cistrome database
for i in ${folders[@]}
do
	intersectBed -a random_probes/filename_temp.bed -b human_factor_split/human_factor_$i/*bed -wa -wb -filenames > analysis_raw_results/filename_temp_intersect_$i.bed
done

cat analysis_raw_results/filename_temp_intersect_* > analysis_raw_results/filename_temp_results.bed
rm analysis_raw_results/filename_temp_intersect_*


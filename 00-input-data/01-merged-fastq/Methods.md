# Merge fastq files from the same sample that were sequenced across 2 lanes 
```
# Get a list of the sample ID's 
# list the fastq files
# use awk to seperate the path by '/' and print the last item, which is the file name 
# Then use awk to split the file name to get just the sample number 
# print the uniq values sorted to a file named ID 
ls ../../../../rawdata/pmex/pmex_tagseq/fastq/EFR* | awk -F '/' '{print $9}' | awk -F '_' '{print $1}' | sort | uniq > ID
```

Then, loop through the ID file and merge lanes 1 and 2 for each sample
```
for i in `cat ./ID`; 
do 
cat ../../../../rawdata/pmex/pmex_tagseq/fastq/${i}_*_L001_R1_001.fastq.gz ../../../../rawdata/pmex/pmex_tagseq/fastq/${i}_*_L002_R1_001.fastq.gz > merged_reads/${i}_merged_R1_1.fastq.gz;
done
```


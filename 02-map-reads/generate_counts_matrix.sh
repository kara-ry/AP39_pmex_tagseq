#confirm samples file has all samples
for sample in `cat samples`; do echo ${sample}; done
wc -l samples

mkdir 03-counts 
mkdir 03-counts/tmp

# get column of counts 
for sample in `cat samples`; 
do 
echo ${sample}
cat 02-star-out/${sample}_ReadsPerGene.out.tab | tail -n +5 | cut -f 2 > 03-counts/tmp/${sample}.counts;
done

# get gene ids - all gene ids are the same across files and in the same order 
tail -n +5  02-star-out/EFR22-203_ReadsPerGene.out.tab | cut -f1 > 03-counts/tmp/geneids.txt
head 03-counts/tmp/geneids.txt

# combine columns 
paste 03-counts/tmp/geneids.txt 03-counts/tmp/*.counts > 03-counts/tmp/tmp.out

# create header and create final counts file 
cat <(cat samples | sort | paste -s) 03-counts/tmp/tmp.out > 03-counts/tagseq_counts.txt
# if file looks good, remove tmp folder 
head 03-counts/tagseq_counts.txt
rm -rf 03-counts/tmp

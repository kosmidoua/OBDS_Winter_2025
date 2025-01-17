READ ME FILE UPDATED 17012025 Kosmidou A
################################################
##How to push slurm file to github?
#copy the file to the github working space
 cp slurm_samtool.sh /project/wolf7078/git/OBDS_Winter_2025
#go to github working directory
cd /project/wolf7078/git/OBDS_Winter_2025
#check content
ls
#check status
git status
#add updates
git add .
#commit to updates with message
git commit -m "Adding slurm file about XY"
#push to github
git hub
#check status again to make sure updates are on github
git status

#####################
#DAY5EXERCISES on Mapping QC and Quantification

#Ex1: Use SAMtools to generate mapping QC: samtools view, sort, index; flagstat; idxstats
##Generate slurm job file including the following --> see slurm_samtool.sh
samtools sort /project/wolf7078/1_linux/2_rnaseq/3_analysis/2_hisat2/aln-pe.sam\
 -o /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam\
 --threads 12
 
samtools index /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam

samtools idxstats \
 /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam\
 > /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/cd4_rep2.sorted.idxstat

samtools flagstat \
  /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam\
 > /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/cd4_rep2.sorted.flagstat
##run slurm job
sbatch slurm_samtools.sh
##check squeue
squeue
squeue -me
watch squeue

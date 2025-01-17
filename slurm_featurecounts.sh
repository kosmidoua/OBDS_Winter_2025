#!/bin/bash
##########################################################################
## A script template for submitting batch jobs. To submit a batch job, 
## please type
##
##    sbatch script_name.sh
##
## Please note that anything after the characters "#SBATCH" on a line
## will be treated as a Slurm option.
##########################################################################

## Specify a partition. Check available partitions using sinfo Slurm command.
#SBATCH --partition=long

## The following line will send an email notification to your registered email
## address when the job ends or fails.
#SBATCH --mail-type=END,FAIL

## Specify the amount of memory that your job needs. This is for the whole job.
## Asking for much more memory than needed will mean that it takes longer to
## start when the cluster is busy.
#SBATCH --mem=10G

## Specify the number of CPU cores that your job can use. This is only relevant for
## jobs which are able to take advantage of additional CPU cores. Asking for more
## cores than your job can use will mean that it takes longer to start when the
## cluster is busy.
#SBATCH --ntasks=12

## Specify the maximum amount of time that your job will need to run. Asking for
## the correct amount of time can help to get your job to start quicker. Time is
## specified as DAYS-HOURS:MINUTES:SECONDS. This example is one hour.
#SBATCH --time=0-01:00:00

## Provide file name (files will be saved in directory where job was ran) or path
## to capture the terminal output and save any error messages. This is very useful
## if you have problems and need to ask for help.
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err

## ################### CODE TO RUN ##########################
# Load modules (if required - e.g. when not using conda) 
# module load R-base/4.3.0

# Execute these commands 

#fastqc  --nogroup --threads 2 --noextract \
# -o /project/wolf7078/1_linux/2_rnaseq/3_analysis/1_fastqc\
 #/project/wolf7078/1_linux/2_rnaseq/1_fastq/cd4_rep2_read1.fastq.gz\
 #/project/wolf7078/1_linux/2_rnaseq/1_fastq/cd4_rep2_read2.fastq.gz


#hisat2\
 #--threads 12\
 #-x /project/shared/1_linux/5_rnaseq/hisat2_index/mm10\
 #-1  /project/wolf7078/1_linux/2_rnaseq/1_fastq/cd4_rep2_read1.fastq.gz\
 #-2  /project/wolf7078/1_linux/2_rnaseq/1_fastq/cd4_rep2_read2.fastq.gz\
 #--rna-strandness RF\
 #--summary-file stats.txt\
 #-S aln-pe.sam\

#samtools sort /project/wolf7078/1_linux/2_rnaseq/3_analysis/2_hisat2/aln-pe.sam\
 #-o /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam\
 #--threads 12
 
#samtools index /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam

#samtools idxstats \
 #/project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam\
 #> /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/cd4_rep2.sorted.idxstat

#samtools flagstat \
 # /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam\
 #> /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/cd4_rep2.sorted.flagstat


featureCounts \
 -T 12 \
 -p \
 -s 2 \
 --countReadPairs \
 -t exon -g gene_id \
 -a /project/shared/1_linux/5_rnaseq/genomes/gtf/Mus_musculus.GRCm38.102.gtf \
 -o /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/counts.txt \
 /project/wolf7078/1_linux/2_rnaseq/3_analysis/3_samtools/sorted.bam 




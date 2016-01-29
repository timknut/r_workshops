#!/bin/bash
#SBATCH -N 1
#SBATCH -n 10
#SBATCH -J salmon

TASK=$SLURM_ARRAY_TASK_ID
SAMPLES=$1

   READ1=$(awk ' NR=='$TASK' { print $1 ; }' $SAMPLES)
   READ2=$(awk ' NR=='$TASK' { print $2 ; }' $SAMPLES)
   SAMPLE=$(awk ' NR=='$TASK' { print $3 ; }' $SAMPLES)

salmon=~/bioinf_tools/salmon/SalmonBeta-0.6.1_DebianSqueeze/bin/salmon
transcripts=/mnt/users/tikn/seqdata1/bovine/reference/Bos_taurus.UMD3.1.cds.all.fa
#READ1=/mnt/users/tikn/SeqData3/rna-seq-SMC/4-sample_pilot_project/fastq_trimPE/5725_S2_L001_R1_001.fastq
#READ2=/mnt/users/tikn/SeqData3/rna-seq-SMC/4-sample_pilot_project/fastq_trimPE/5725_S2_L001_R2_001.fastq


#$salmon index -p 10 -t $transcripts -i transcripts_index/index_ensembl_fasta --type quasi -k 31
$salmon quant -i transcripts_index/index_ensembl_fasta -p 10 -l ISR -1 $READ1 -2 $READ2 -o ${SAMPLE}_quant

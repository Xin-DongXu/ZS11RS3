fastp -i ZS11_ChIP_r1.fq.gz \
      -I ZS11_ChIP_r2.fq.gz \
      -o ZS11_ChIP_clean_r1.fq.gz \
      -O ZS11_ChIP_clean_r2.fq.gz \
      -w 16

fastp -i ZS11_Input_r1.fq.gz \
      -I ZS11_Input_r2.fq.gz \
      -o ZS11_Input_clean_r1.fq.gz \
      -O ZS11_Input_clean_r2.fq.gz \
      -w 16

bowtie2-build ZS11RS3.fasta ZS11RS3

bowtie2 \
    --very-sensitive \
    --no-mixed \
    --no-discordant \
    -k 10 \
    --threads 72 \
    -x ZS11RS3 \
    -1 ZS11_ChIP_clean_r1.fq.gz \
    -2 ZS11_ChIP_clean_r2.fq.gz \
    -S ZS11_ChIP_aligned.sam

bowtie2 \
    --very-sensitive \
    --no-mixed \
    --no-discordant \
    -k 10 \
    --threads 72 \
    -x ZS11RS3 \
    -1 ZS11_Input_clean_r1.fq.gz \
    -2 ZS11_Input_clean_r2.fq.gz \
    -S ZS11_Input_aligned.sam

samtools view -@ 72 -bS ZS11_ChIP_aligned.sam > ZS11_ChIP_aligned.bam
samtools view -@ 72 -bS ZS11_Input_aligned.sam > ZS11_Input_aligned.bam

samtools view -@ 72 -b -q 10 ZS11_ChIP_aligned.bam  > ZS11_ChIP_mapq10.bam
samtools view -@ 72 -b -q 10 ZS11_Input_aligned.bam  > ZS11_Input_mapq10.bam

samtools sort -@ 72 ZS11_ChIP_mapq10.bam -o  ZS11_ChIP_mapq10_sorted.bam
samtools sort -@ 72 ZS11_Input_mapq10.bam -o  ZS11_Input_mapq10_sorted.bam

samtools rmdup ZS11_ChIP_mapq10_sorted.bam ZS11_ChIP_mapq10_sorted_rmdup.bam
samtools rmdup ZS11_Input_mapq10_sorted.bam ZS11_Input_mapq10_sorted_rmdup.bam

samtools index ZS11_ChIP_mapq10_sorted_rmdup.bam
samtools index ZS11_Input_mapq10_sorted_rmdup.bam

bamCompare -b1 ZS11_ChIP_mapq10_sorted_rmdup.bam \
           -b2 ZS11_Input_mapq10_sorted_rmdup.bam \
           -o ZS11RS3_log2.bedgraph \
           --binSize 10000 \
           -p 72 \
           --effectiveGenomeSize 1017632034 \
           --normalizeUsing BPM \
           --operation log2 \
           --scaleFactorsMethod None \
           --outFileFormat bedgraph
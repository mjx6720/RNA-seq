# data from http://genomedata.org/rnaseq-tutorial/results/cbw2020/workspace/
# chr22 data
# bowtie2/bwa/DESeq2/fastqc/htseq-count/Integrated Genomics Viewer/ R /samtools/trim_galore 
bwa index chr22_with_ERCC92.fa

trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1.fastq.gz HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2.fastq.gz --gzip &&
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz --gzip &&
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz --gzip &&
trim_galore -q 20 --phred33 --stringency 3 --length 20 -e 0.1 --paired UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1.fastq.gz UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2.fastq.gz --gzip 

#bwa mem
bwa mem chr22_with_ERCC92.fa HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1_val_1.fq.gz HBR_Rep1_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2_val_2.fq.gz > HBR_Rep1.sam &&
bwa mem chr22_with_ERCC92.fa HBR_Rep2_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1_val_1.fq.gz HBR_Rep2_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2_val_2.fq.gz > HBR_Rep2.sam &&
bwa mem chr22_with_ERCC92.fa HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22.read1_val_1.fq.gz HBR_Rep3_ERCC-Mix2_Build37-ErccTranscripts-chr22.read2_val_2.fq.gz > HBR_Rep3.sam &&
bwa mem chr22_with_ERCC92.fa UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1_val_1.fq.gz UHR_Rep1_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2_val_2.fq.gz > UHR_Rep1.sam &&
bwa mem chr22_with_ERCC92.fa UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1_val_1.fq.gz UHR_Rep2_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2_val_2.fq.gz > UHR_Rep2.sam &&
bwa mem chr22_with_ERCC92.fa UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22.read1_val_1.fq.gz UHR_Rep3_ERCC-Mix1_Build37-ErccTranscripts-chr22.read2_val_2.fq.gz > UHR_Rep3.sam &&

#samtools view 
samtools view -bq 50 HBR_Rep1.sam > HBR_Rep1.bam &&
samtools view -bq 50 HBR_Rep2.sam > HBR_Rep2.bam &&
samtools view -bq 50 HBR_Rep3.sam > HBR_Rep3.bam &&
samtools view -bq 50 UHR_Rep1.sam > UBR_Rep1.bam &&
samtools view -bq 50 UHR_Rep2.sam > UBR_Rep2.bam &&
samtools view -bq 50 UHR_Rep3.sam > UBR_Rep3.bam

#samtools sort
samtools sort HBR_Rep1.bam -o HBR_Rep1_sorted.bam && samtools index HBR_Rep1_sorted.bam &&
samtools sort HBR_Rep2.bam -o HBR_Rep2_sorted.bam && samtools index HBR_Rep2_sorted.bam &&
samtools sort HBR_Rep3.bam -o HBR_Rep3_sorted.bam && samtools index HBR_Rep3_sorted.bam &&
samtools sort UBR_Rep1.bam -o UBR_Rep1_sorted.bam && samtools index UBR_Rep1_sorted.bam &&
samtools sort UBR_Rep2.bam -o UBR_Rep2_sorted.bam && samtools index UBR_Rep2_sorted.bam &&
samtools sort UBR_Rep3.bam -o UBR_Rep3_sorted.bam && samtools index UBR_Rep3_sorted.bam

#htseq-count
htseq-count -f bam HBR_Rep1_sorted.bam chr22_with_ERCC92.gtf > HBR_Rep1.counts.txt &&
htseq-count -f bam HBR_Rep2_sorted.bam chr22_with_ERCC92.gtf > HBR_Rep2.counts.txt &&
htseq-count -f bam HBR_Rep3_sorted.bam chr22_with_ERCC92.gtf > HBR_Rep3.counts.txt &&
htseq-count -f bam UBR_Rep1_sorted.bam chr22_with_ERCC92.gtf > UBR_Rep1.counts.txt &&
htseq-count -f bam UBR_Rep2_sorted.bam chr22_with_ERCC92.gtf > UBR_Rep2.counts.txt &&
htseq-count -f bam UBR_Rep3_sorted.bam chr22_with_ERCC92.gtf > UBR_Rep3.counts.txt

#HBR_Rep1.counts.txt
#HBR_Rep2.counts.txt
#HBR_Rep3.counts.txt
#UBR_Rep1.counts.txt
#UBR_Rep2.counts.txt
#UBR_Rep3.counts.txt

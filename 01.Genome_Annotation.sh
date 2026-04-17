EDTA.pl --genome ZS11RS3.fasta --anno 1 --threads 72

singularity exec --nv ~/software/Helixer/helixer-docker_helixer_v0.3.3_cuda_11.8.0-cudnn8.sif Helixer.py \
                 --lineage land_plant \
                 --fasta-path ZS11RS3.fasta \
                 --species Brassica_napus \
                 --gff-output-path ZS11RS3_helixer.gff3

lifton -g ZS11_v0.gff \
       -o ZS11RS3_lifton.gff3 \
       -copies ZS11RS3.fasta ZS11_v0.fasta

compleasm.py run -a ZS11RS3.fasta \
                 -o output_dir \
                 -t 72 \
                 --autolineage
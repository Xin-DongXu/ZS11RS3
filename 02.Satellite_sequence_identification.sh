bash -x TRASH_run.sh ZS11RS3.fasta \
     --o ZS11RS3 \
     --par 72

bash -x TRASH_run.sh A01_Fun_CEN.fasta \
     --o A01_Fun_CEN_HOR \
     --seqt template.csv \
     --horclass CEN176 \
     --par 72 \
     --minhor 1

moddotplot static -f ZS11RS3.fasta \
                  --color "#132D88" "#6E4698" "#459567" "#EFEA3A" "#E73119" \
                  -id 0 \
                  -w 10000

trf ZS11RS3.fasta 2 7 7 80 10 50 500 -f -d -m

python TRF2GFF.py -d trf_output.dat -o ZS11RS3_trf.gff3
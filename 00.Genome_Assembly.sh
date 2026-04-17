hifiasm -o ZS11RS3 \
        -t72 \
        --ul ZS11.ONT.fq.gz ZS11.HiFi.fq.gz

hifiasm -o ZS11RS3 \
        --ont -t72 \
        ZS11.ONT.fq.gz

nohup nextDenovo run.cfg &
#!/bin/sh
set -xe
if [ ! -f DeepSpeech.py ]; then
    echo "Please make sure you run this from DeepSpeech's top level directory."
    exit 1
fi;

LD_LIBRARY_PATH=/usr/local/lib:/home/DeepSpeech/native_client

python -u DeepSpeech.py \
  --train_files data/cutecare/cutecare-train.csv \
  --dev_files data/cutecare/cutecare-dev.csv \
  --test_files data/cutecare/cutecare-test.csv \
  --checkpoint_dir /work/checkpoint \
  --export_dir /work/export \
  --lm_binary_path /work/lm.binary \
  --lm_trie_path /work/trie
  --train_batch_size 13 \
  --dev_batch_size 13 \
  --test_batch_size 13 \
  --epoch 60 \
  --learning_rate 0.0001 \
  --display_step 10 \
  --validation_step 1 \
  --dropout_rate 0.15 \
  --default_stddev 0.046875 \
  --checkpoint_step 1 \
  --wer_log_pattern "GLOBAL LOG: logwer('${COMPUTE_ID}', '%s', '%s', %f)"\
  "$@"
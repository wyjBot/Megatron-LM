#!/bin/bash

set -u
unset NCCL_DEBUG

NPROCS=16 # NPROCS must be <= number of GPUs.

######## Environment vars. ########
DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
. ${DIR}/get_preprocess_cmd.sh

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "DIR = '$DIR'."
echo "RETRO_PREPROCESS_CMD = '$RETRO_PREPROCESS_CMD'."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"

######## Command. ########
FULL_CMD="\
    pwd && cd ${REPO_DIR} && pwd && \
    export PYTHONPATH=$PYTHONPATH:${REPO_DIR} && \
    python -m torch.distributed.launch \
    --nproc_per_node ${NPROCS} \
    --nnodes 1 \
    --node_rank ${NODE_RANK} \
    --master_addr ${MASTER_ADDR} \
    --master_port 6000 \
    $RETRO_PREPROCESS_CMD \
"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "FULL_CMD = '$FULL_CMD'."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~"
eval $FULL_CMD

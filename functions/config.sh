#!/bin/bash

RPC=''
ORE_CLI='../ore/ore-cli-master/target/release/ore'
KEYS_DIR='../keys/private'
COMMON_COMMAND="${ORE_CLI} --rpc ${RPC} --keypair"

export COMMON_COMMAND
export KEYS_DIR

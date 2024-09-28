#!/bin/bash

set -e # exits on non-zero RC
set -u # exits on undefined vars

kind delete cluster


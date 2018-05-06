#!/bin/bash
set -ex

export PYTHONUNBUFFERED=1

likwid-create-bench-sets
likwid-run-bench-tests

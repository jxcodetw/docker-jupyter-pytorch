#!/usr/bin/env bash

jupyter tensorboard enable --user
jupyter lab --allow-root --no-browser --ip=0.0.0.0 --port=8888

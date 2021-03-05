#!/bin/bash

xvfb-run -a -s '-screen 0 1024x768x24' julia -t 2 /plot.jl

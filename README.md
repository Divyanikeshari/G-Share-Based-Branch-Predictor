# G-Share-Based-Branch-Predictor

This project implements a G-share (Global Share) branch predictor, a dynamic branch prediction algorithm used in modern processors to reduce control hazards and improve pipeline efficiency. It combines global branch history with the program counter (PC) to generate an index for the pattern history table (PHT), offering better accuracy than simple predictors like bimodal or local predictors.

#  Features
XOR-based indexing of Global History Register (GHR) and PC

Configurable GHR length and PHT size

2-bit saturating counters for prediction confidence

Simulation of branch outcomes to measure accuracy

Testbench with multiple branching patterns

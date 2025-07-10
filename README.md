# G-Share-Based-Branch-Predictor

This project implements a G-share (Global Share) branch predictor, a dynamic branch prediction algorithm used in modern processors to reduce control hazards and improve pipeline efficiency. It combines global branch history with the program counter (PC) to generate an index for the pattern history table (PHT), offering better accuracy than simple predictors like bimodal or local predictors.

#  Features
1. XOR-based indexing of Global History Register (GHR) and PC
2. Configurable GHR length and PHT size
3. 2-bit saturating counters for prediction confidence
4. Simulation of branch outcomes to measure accuracy
5. Testbench with multiple branching patterns

# Learning-based Visual SLAM – From Scratch to Deep Learning

This repository documents my journey from classical Visual SLAM to learning-based SLAM. It was built to show the transition from manual feature engineering (Octave) to neural approaches (PyTorch) for PhD application.

### 🔹 Phase 1: Classical SLAM (Octave)
- Implemented Sobel filter, FAST/ORB feature detection from scratch
- Binary descriptor creation and Hamming distance matching
- Trajectory estimation and smoothing with movmean

### 🔹 Phase 2: Learning-based Loop Closure (PyTorch)
- Designed `LoopClosureNet`: `nn.Linear(8,16) + ReLU + Linear(16,1) + Sigmoid`
- Replaces manual Hamming matching with a learnable similarity score
- Goal: Robust place recognition under illumination changes

### 🔹 Phase 3: Real-time Deployment (Raspberry Pi 4)
- Porting the pipeline for real-time inference on RPi
- Optimization for edge devices

**Future Work:** Transformer-based feature matching (SuperGlue) and DROID-SLAM.

**Author:** Ainee Rafi
**Focus:** Visual Navigation | Deep Learning for SLAM | Edge AI
**Contact:** ainee.rafi1@gmail.com

# Learning SLAM From Scratch
by Ainee Rafi

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Python 3.8+](https://img.shields.io/badge/Python-3.8%2B-blue.svg)
![MATLAB R2023b+](https://img.shields.io/badge/MATLAB-R2023b%2B-orange.svg)
![PyTorch 2.0+](https://img.shields.io/badge/PyTorch-2.0%2B-red.svg)
![Raspberry Pi 4](https://img.shields.io/badge/Raspberry%20Pi-4-C51A4A.svg)

A hands-on project to build a Simultaneous Localization & Mapping (SLAM) pipeline from scratch, covering classical methods in MATLAB/Octave, learning-based loop closure in PyTorch, and real-time deployment on Raspberry Pi 4 for edge robotics.

## Project Structure

<table>
<tr>
<td width="60%">

### Phase 1: Classical SLAM (Octave)
- Implements feature detection using **Sobel** edge detector for image preprocessing
- Extracts keypoints using **FAST** and **ORB** for robust feature matching
- Matches features using **Hamming** distance for efficient binary descriptor comparison

### Phase 2: Learning-based Loop Closure (PyTorch)
- Model: **LoopClosureNet**: Lightweight neural network for loop closure detection
- Architecture: `Linear(8, 16) -> ReLU -> Linear(16, 1) -> Sigmoid`
- Outputs a loop closure probability between 0-1, trained with binary cross-entropy loss on image descriptor

### Phase 3: Real-time Deployment (Raspberry Pi 4)
- Porting pipeline for real-time inference on RPi
- Optimization for edge devices

</td>
<td width="40%">

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Oxford_map.png/400px-Oxford_map.png" width="100%" />

<small>*Field testing area: Oxford - Urban Themes and city center, used for real-world outdoor SLAM evaluation and dataset collection*</small>

</td>
</tr>
</table>

### Future Work
- Integrate **SuperGlue** for learned feature matching and robust keypoint correspondence
- Explore **DROID-SLAM** for dense visual SLAM comparison and evaluation
- Add multi-session map management and long-term loop closure improvements

### Author
**Ainee Rafi** - Focus: Visual Navigation | Deep Learning for SLAM | Edge AI  
Contact: ainee.rafi1@gmail.com • GitHub: @aineerafi


**Python - Learning-based Loop Closure**

**Python - Learning-based Loop Closure**

### How to Run

**MATLAB/Octave - Classical SLAM**

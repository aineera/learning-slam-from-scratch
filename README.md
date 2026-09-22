Learning SLAM From Scratch
by Ainee Rafi

A hands-on project to build a SLAM pipeline from scratch - classical in MATLAB/Octave, learning-based loop closure in PyTorch, and real-time deployment on Raspberry Pi 4.

Project Structure
Learning-SLAM-From-Scratch/
├── matlab/       # Phase 1: Classical SLAM in Octave/MATLAB
├── python/       # Phase 2: Learning-based loop closure (PyTorch)
└── RaspberryPi/  # Phase 3: Real-time deployment on RPi 4

Phase 1: Classical SLAM (Octave)
- Implements Sobel filter, FAST/ORB from scratch
- Binary descriptor + Hamming distance matching
- Trajectory estimation with movmean

Phase 2: Learning-based Loop Closure (PyTorch)
- Model: LoopClosureNet: Linear(8,16) -> ReLU -> Linear(16,1) -> Sigmoid
- Replaces manual Hamming with learnable similarity score

Phase 3: Real-time Deployment (Raspberry Pi 4)
- Porting pipeline for real-time inference on RPi
- Optimization for edge devices

How to Run

MATLAB / Octave - Classical SLAM
cd matlab/
octave --eval "run('main_slam.m')"

Python - Learning-based Loop Closure
cd python/
pip install -r requirements.txt
python train_loop_closure.py --epochs 30 --batch-size 32
python eval_loop_closure.py --checkpoint models/LoopClosureNet.pth

Future Work
- SuperGlue for learned feature matching
- DROID-SLAM for dense SLAM

Author
**Ainee Rafi** - Focus: Visual Navigation | Deep Learning for SLAM | Edge AI
Contact: ainee.rafi1@gmail.com
Isme `How to Run` maine sab se neeche add kar diya hai jese tum chah rahi thi.

Ho jaye to screenshot bhejna, final look dekhna hai mujhe!

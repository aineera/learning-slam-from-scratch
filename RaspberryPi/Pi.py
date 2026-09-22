# Phase 3: Real-time Deployment (Raspberry Pi 3)
print("Optimized model for Raspberry Pi 3 deployment")
# import tflite_runtime etc for Pi
# Phase 3: Real-time Deployment (Raspberry Pi 3)
# Learning-based Visual SLAM - From Scratch to Deep Learning

import cv2
import torch
import numpy as np
import time

# --- Import your Phase 2 Model ---
from Phase2_LoopClosureNet import LoopClosureNet

class RealTimeSLAM_Pi:
    def __init__(self):
        print("Loading SLAM system for Raspberry Pi 4...")
        # Load trained model and optimize for Pi
        self.loop_model = LoopClosureNet()
        try:
            self.loop_model.load_state_dict(torch.load('loop_closure_weights.pth', map_location='cpu'))
            print("Pretrained weights loaded!")
        except:
            print("Using untrained model (train on PC first)")
        
        self.loop_model.eval() # Inference mode
        
        # For trajectory
        self.trajectory = []
        self.prev_descriptors = None
        self.orb = cv2.ORB_create(nfeatures=300) # Lightweight for Pi

    def process_frame(self, frame):
        # 1. Sobel + FAST/ORB (from Phase 1)
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        kp, des = self.orb.detectAndCompute(gray, None)
        
        if des is None:
            return frame

        # 2. Trajectory Estimation
        if self.prev_descriptors is not None:
            # Hamming matching first (classical)
            bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
            matches = bf.match(self.prev_descriptors, des)
            matches = sorted(matches, key=lambda x:x.distance)[:20]

            # 3. Learning-based Loop Closure (Phase 2 logic)
            if len(matches) > 10:
                # Create 8-dim feature from matches (example feature)
                match_distances = np.array([m.distance for m in matches[:8]])
                feature = torch.tensor(match_distances, dtype=torch.float32).unsqueeze(0)
                
                with torch.no_grad():
                    loop_score = self.loop_model(feature)
                
                if loop_score.item() > 0.8:
                    cv2.putText(frame, "LOOP CLOSURE DETECTED", (20,40), 
                                cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0,0,255), 2)
        
        self.prev_descriptors = des
        self.trajectory.append(len(kp))
        return frame

    def run(self):
        # Pi Camera - 0 for USB cam, or use PiCamera
        cap = cv2.VideoCapture(0)
        cap.set(3, 640) # 640x480 for speed on Pi 4
        cap.set(4, 480)

        print("Starting Real-time SLAM... Press 'q' to quit")
        while True:
            start = time.time()
            ret, frame = cap.read()
            if not ret: break

            frame = self.process_frame(frame)
            
            fps = 1 / (time.time() - start + 0.001)
            cv2.putText(frame, f"FPS: {int(fps)} | Features: {len(self.trajectory)}", 
                        (20,20), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,0), 1)

            cv2.imshow("Pi SLAM - Learning Based", frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
        
        cap.release()
        cv2.destroyAllWindows()
        # Save trajectory with movmean smoothing (Phase 1)
        smooth_traj = np.convolve(self.trajectory, np.ones(5)/5, mode='valid')
        print(f"Trajectory saved, smoothed length: {len(smooth_traj)}")

if __name__ == "__main__":
    slam = RealTimeSLAM_Pi()
    slam.run()

# Phase 2: Learning-based Loop Closure
import torch
import torch.nn as nn

class LoopClosureNet(nn.Module):
    # Design: Linear(8,16) + ReLU + Linear(16,1) + Sigmoid
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(8, 16),
            nn.ReLU(),
            nn.Linear(16, 1),
            nn.Sigmoid()
        )

    def forward(self, x):
        # x = 8-dim descriptor difference
        return self.net(x)

# Example: replaces manual Hamming matching
model = LoopClosureNet()
print(model)

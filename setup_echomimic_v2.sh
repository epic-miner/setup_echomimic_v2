#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
REPO_URL="https://github.com/antgroup/echomimic_v2"
PRETRAINED_WEIGHTS_URL="https://huggingface.co/BadToBest/EchoMimicV2"
FFMPEG_URL="https://www.johnvansickle.com/ffmpeg/old-releases/ffmpeg-4.4-amd64-static.tar.xz"
FFMPEG_DIR="ffmpeg-4.4-amd64-static"
FFMPEG_TAR="${FFMPEG_DIR}.tar.xz"
FFMPEG_PATH="$(pwd)/$FFMPEG_DIR"

# Clone the main repository into the current directory
echo "Cloning EchoMimic V2 repository..."
git clone $REPO_URL .

# Upgrade pip and install dependencies
echo "Upgrading pip..."
pip install pip -U
echo "Installing dependencies..."
pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 xformers==0.0.28.post3 --index-url https://download.pytorch.org/whl/cu124
pip install torchao --index-url https://download.pytorch.org/whl/nightly/cu124
pip install numpy pandas matplotlib tqdm scipy librosa opencv-python
pip install --no-deps facenet_pytorch==2.6.0

# Download and extract FFMPEG in the current directory
echo "Downloading and extracting FFMPEG..."
wget $FFMPEG_URL
tar -xvf $FFMPEG_TAR

# Set FFMPEG_PATH environment variable
export FFMPEG_PATH=$FFMPEG_PATH
echo "FFMPEG_PATH set to $FFMPEG_PATH"

# Initialize Git LFS and clone pretrained weights into the current directory
echo "Setting up Git LFS..."
git lfs install
echo "Cloning pretrained weights from Hugging Face..."
git clone $PRETRAINED_WEIGHTS_URL pretrained_weights

# Completion message
echo "Setup completed successfully in the current directory!"

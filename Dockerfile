FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-devel
RUN apt-get update && apt-get install wget
RUN wget -qO - https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub | sudo apt-key add -
RUN wget -qO - https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub | sudo apt-key add -
RUN apt-get install ffmpeg libsm6 libxext6 -y
RUN apt-get update && apt-get install libgl1
#Optional. I prefer creating this so that its easy to track root path for mounting
RUN mkdir train
WORKDIR train
COPY . yolov7
RUN pip install -r yolov7/requirements.txt
ENTRYPOINT ["python", "-m", "torch.distributed.run"]

ARG BASE=hieupth/mamba
ARG GPU=
ARG CUDA=11.8
ARG OPENCV=4.9.0
ARG ONNXRUNTIME=1.18.0

FROM ${BASE}
# Recall build arguments.
ARG GPU
ARG CUDA
ARG OPENCV
ARG ONNXRUNTIME
# Copy source.
WORKDIR /cinnamon
COPY environment.yml environment.yml
COPY install_deps.py install_deps.py
# Create environment.
RUN conda env create -f environment.yml && conda clean -ay
SHELL ["conda", "run", "-n", "cinnamon", "/bin/bash", "-lc"]
# Install onnxruntime.
RUN python -u install_deps.py ort --v ${ONNXRUNTIME} ${GPU} --cuda ${CUDA} && \
    rm -rf _deps && \
    mamba clean -ay
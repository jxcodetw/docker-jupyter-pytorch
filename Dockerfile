FROM pytorch/pytorch:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
         libsm6 \
         libxext6 \
         libxrender-dev \
         ffmpeg && \
     rm -rf /var/lib/apt/lists/*

RUN /opt/conda/bin/conda install -y opencv Cython pandas scikit-learn matplotlib seaborn jupyter jupyterlab && \
    /opt/conda/bin/conda clean -ya

RUN pip install torchvision scikit-image scikit-learn-intelex

RUN mkdir -p /home/me && chmod 1777 /home/me

ENV HOME /home/me

# jupyter notebook
EXPOSE 8888

COPY start.sh /

CMD ["/start.sh"]


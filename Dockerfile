FROM pytorch/pytorch:latest

RUN /opt/conda/bin/conda install -y tensorflow pandas matplotlib seaborn jupyter && \
    /opt/conda/bin/conda clean -ya

RUN pip install tensorboardx

RUN mkdir -p /home/me && chmod 1777 /home/me

ENV HOME /home/me

# tensorboard
EXPOSE 6006
# jupyter notebook
EXPOSE 8888

COPY start.sh /

CMD ["/start.sh"]


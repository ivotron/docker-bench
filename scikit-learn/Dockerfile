FROM continuumio/miniconda

RUN conda install --yes scikit-learn ujson && \
    conda clean -yt

ADD entrypoint.py /root/

ENTRYPOINT ["/root/entrypoint.py"]

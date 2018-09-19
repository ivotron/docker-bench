FROM python:2.7.15-slim-stretch

#RUN apt update -y \
# && apt install -y --no-install-recommends \
#      gcc python-dev python-virtualenv \ 
RUN pip --no-cache-dir install virtualenv \
 && virtualenv /root/venv \
 && bash -c "source /root/venv/bin/activate && pip --no-cache-dir install numpy pandas scikit-learn==0.18.1 ujson"

ADD entrypoint.py /root/

ENTRYPOINT ["/root/entrypoint.py"]

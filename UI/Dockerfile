FROM python:alpine3.7

COPY . /app

WORKDIR /app

RUN pip install -r libs/requirements.txt

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]
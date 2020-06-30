FROM python:alpine3.7

# We copy just the requirements.txt first to leverage Docker cache
COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]
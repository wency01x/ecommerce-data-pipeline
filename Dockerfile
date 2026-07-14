FROM python:3.9-slim

RUN pip install sqlalchemy pandas psycopg2-binary

WORKDIR /app

COPY ingest_sales.py ingest_sales.pdy
COPY online_retail_II_dataset.csv online_retail_II_dataset.csv

ENTRYPOINT ["python", "ingest_sales.py"]
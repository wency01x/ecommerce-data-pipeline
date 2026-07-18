FROM python:3.11-slim

RUN pip install pandas pandas-gbq db-dtypes

WORKDIR /app

COPY ingest_sales.py ingest_sales.py
COPY online_retail_II_dataset.csv online_retail_II_dataset.csv

ENTRYPOINT ["python", "ingest_sales.py"]
import pandas as pd
import pandas_gbq
import argparse, os
from time import time

def main(params):
    table_name = params.table_name
    csv_name = params.csv_name

    print(f"Connecting to Google Cloud BigQuery project: {os.getenv('GCP_PROJECT')}...")

    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000)   # set up pandas iterator to read the CSV file in chunks

    # loop through the remaining chunks and insert them into the database
    while True:
        try:
            t_start = time()
            df = next(df_iter) # get the next chunk
            pandas_gbq.to_gbq(
                df,
                destination_table=f"{os.getenv('GCP_PROJECT')}.ecommerce_sales_dataset.{table_name}",
                project_id=os.getenv('GCP_PROJECT'),
                if_exists='append'
            )
            t_end = time()
            print(f"Inserted another chunk of data into the database in {t_end - t_start:.3f} seconds.")
        
        except StopIteration:
            print("Finished ingesting all data into Google Cloud BigQuery!")
            break 

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Google Cloud BigQuery')
    parser.add_argument('--table_name', required=True, help='name of the table to insert data into')
    parser.add_argument('--csv_name', required=True, help='name of the CSV file to ingest')

    params = parser.parse_args()
    main(params)

import pandas as pd
from sqlalchemy import create_engine
import argparse
from time import time

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    csv_name = params.csv_name

    print(f"Connecting to database {db} on {host}:{port} as user {user}...")

    # create the database engine
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # set up pandas iterator to read the CSV file in chunks
    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000)

    # grab the very first chunk to get the column headers
    df = next(df_iter)

    # create the empty table in the database
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    # insert the first chunk of data into the database
    df.to_sql(name=table_name, con=engine, if_exists='append')
    print("Inserted the first chunk of data into the database.")

    # loop through the remaining chunks and insert them into the database
    while True:
        try:
            t_start = time()
            df = next(df_iter) # get the next chunk
            df.to_sql(name=table_name, con=engine, if_exists='append') # insert the chunk into the database
            t_end = time()
            print(f"Inserted another chunk of data into the database in {t_end - t_start:.3f} seconds.")
        
        except StopIteration:
            print("Finished ingesting all data into Postgres database!")
            break 

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')
    parser.add_argument('--user', required=True, help='username for postgres')
    parser.add_argument('--password', required=True, help='password for postgres')
    parser.add_argument('--host', required=True, help='host for postgres')
    parser.add_argument('--port', required=True, help='port for postgres')
    parser.add_argument('--db', required=True, help='database name for postgres')
    parser.add_argument('--table_name', required=True, help='name of the table to insert data into')
    parser.add_argument('--csv_name', required=True, help='name of the CSV file to ingest')

    params = parser.parse_args()
    main(params)

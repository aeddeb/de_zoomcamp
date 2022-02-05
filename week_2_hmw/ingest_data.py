
import pandas as pd
from sqlalchemy import create_engine
from time import time
import os

def ingest_callable(user, password, host, port, db, table_name, csv_file):

    print(table_name, csv_file)

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    engine.connect()

    print('Connection to db established sucesfully, inserting data...')

    df_iter = pd.read_csv(csv_file, iterator=True, chunksize=100000)

    start = True

    while True:

        try:
            t_start = time()
            
            df = next(df_iter)

            if start:
                df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')
                start = False

            df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
            df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

            df.to_sql(name=table_name, con=engine, if_exists='append')

            t_end = time()

            print(f'Inserted another chunk. Took {t_end - t_start} seconds')
        
        except StopIteration:
            print('Completed')
            break

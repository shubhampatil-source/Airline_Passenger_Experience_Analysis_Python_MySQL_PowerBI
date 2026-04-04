import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError

CSV_FILE_PATH = "C:/Projects/Airline_Customer_Satisfication_Python+SQL+Tableau/airline_passenger_cleaned.csv"
DB_USER = "root"
DB_PASSWORD = "shubham%401999"
DB_HOST = "127.0.0.1"
DB_PORT = "3306"
DB_NAME = "airline_project"
TABLE_NAME = "airline_passenger_experience"

connection_string = (
    f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

try:
    engine = create_engine(connection_string)
    df = pd.read_csv(CSV_FILE_PATH)

    df.to_sql(
        name=TABLE_NAME,
        con=engine,
        if_exists="append",
        index=False,
        chunksize=1000,
        method="multi"
    )

    print("Data inserted successfully.")

except FileNotFoundError:
    print("CSV file not found.")
except SQLAlchemyError as e:
    print("Database error:", e)
except Exception as e:
    print("Unexpected error:", e)
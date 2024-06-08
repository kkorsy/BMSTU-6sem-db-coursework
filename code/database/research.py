import psycopg2
from psycopg2 import sql
import pandas as pd
from faker import Faker
import random

def connect_to_db():
    try:
        conn = psycopg2.connect(
            dbname="serials",
            user="postgres",
            password="5454038",
            host="localhost",
            port="5432"
        )
        return conn
    except Exception as e:
        print(f"Error connecting to the database: {e}")
        return None

def setup_users_table(conn):
    try:
        cursor = conn.cursor()
        cursor.execute("DROP TABLE IF EXISTS Users CASCADE")
        create_table_query = """
        CREATE TABLE Users (
            u_id SERIAL NOT NULL PRIMARY KEY,
            u_idFavourites INT NOT NULL,
            u_login TEXT NOT NULL,
            u_password TEXT NOT NULL,
            u_role TEXT NOT NULL CHECK (u_role = 'user' OR u_role = 'admin'),
            u_name TEXT NOT NULL,
            u_surname TEXT NOT NULL,
            u_gender TEXT NOT NULL CHECK (u_gender = 'мужской' OR u_gender = 'женский'),
            u_bdate DATE NOT NULL
        );
        CREATE INDEX users_name_index
        ON users USING btree(u_name);
        SET enable_seqscan TO off;
        """
        cursor.execute(create_table_query)
        conn.commit()
        cursor.close()
    except Exception as e:
        print(f"Error setting up Users table: {e}")

def populate_users_table(conn, n):
    fake = Faker()
    try:
        cursor = conn.cursor()
        for _ in range(n):
            cursor.execute(
                "INSERT INTO Users (u_idFavourites, u_login, u_password, u_role, u_name, u_surname, u_gender, u_bdate) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
                (
                    1,
                    fake.user_name(),
                    fake.password(),
                    random.choice(['user', 'admin']),
                    fake.first_name(),
                    fake.last_name(),
                    random.choice(['мужской', 'женский']),
                    fake.date_of_birth(minimum_age=18, maximum_age=90)
                )
            )
        conn.commit()
        cursor.close()
    except Exception as e:
        print(f"Error populating Users table: {e}")

def measure_query_time(conn):
    try:
        cursor = conn.cursor()
        cursor.execute("EXPLAIN ANALYSE SELECT * FROM Users ORDER BY u_name")
        result = cursor.fetchall()
        for row in result:
            if "Execution Time" in row[0]:
                time_taken = float(row[0].split(": ")[1].split(" ")[0])
                return time_taken
        cursor.close()
    except Exception as e:
        print(f"Error measuring query time: {e}")
        return None

def main():
    conn = connect_to_db()
    if not conn:
        return
    
    results = []
    
    for n in range(1, 100002, 5000):
        query_time = 0
        setup_users_table(conn)
        populate_users_table(conn, n)
        for _ in range(10):
            query_time += measure_query_time(conn)
        query_time /= 10
        if query_time is not None:
            results.append((n, query_time))
        print(f"n={n}, time={query_time}")
    
    conn.close()
    
    filename = "time_index.csv"
    df = pd.DataFrame(results, columns=["n", "time"])
    df.to_csv(filename, index=False)
    print(f"Results saved to {filename}")

if __name__ == "__main__":
    main()

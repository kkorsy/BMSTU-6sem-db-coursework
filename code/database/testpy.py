import psycopg2
import pandas as pd
from faker import Faker
import random
from datetime import timedelta

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

def setup_database(conn):
    try:
        cursor = conn.cursor()
        setup_query = """
        DROP TABLE IF EXISTS Serials CASCADE;
        CREATE TABLE Serials (
            s_id SERIAL NOT NULL PRIMARY KEY,
            s_idProducer INT NOT NULL,
            s_img TEXT NOT NULL,
            s_name TEXT NOT NULL,
            s_description TEXT NOT NULL,
            s_year INT NOT NULL CHECK (s_year > 1800),
            s_genre TEXT NOT NULL,
            s_rating FLOAT NOT NULL CHECK (s_rating BETWEEN 0 AND 10),
            s_seasons INT NOT NULL CHECK (s_seasons >= 0),
            s_state TEXT NOT NULL CHECK (s_state = 'завершен' OR s_state = 'продолжается'),
            s_duration INTERVAL NOT NULL
        );
        DROP TABLE IF EXISTS Producers CASCADE;
        CREATE TABLE Producers (
            p_id SERIAL NOT NULL PRIMARY KEY,
            p_name TEXT NOT NULL,
            p_surname TEXT NOT NULL
        );
        ALTER TABLE Serials ADD FOREIGN KEY (s_idProducer) REFERENCES Producers(p_id);

        DROP TABLE IF EXISTS Seasons CASCADE;
        CREATE TABLE Seasons (
            ss_id SERIAL NOT NULL PRIMARY KEY,
            ss_idSerial INT NOT NULL,
            ss_name TEXT NOT NULL,
            ss_num INT NOT NULL CHECK (ss_num > 0),
            ss_cntEpisodes INT NOT NULL CHECK (ss_cntEpisodes > 0),
            ss_date DATE NOT NULL
        );
        ALTER TABLE Seasons ADD FOREIGN KEY (ss_idSerial) REFERENCES Serials(s_id);

        DROP TABLE IF EXISTS Episodes CASCADE;
        CREATE TABLE Episodes (
            e_id SERIAL NOT NULL PRIMARY KEY,
            e_idSeason INT NOT NULL,
            e_name TEXT NOT NULL,
            e_num INT NOT NULL CHECK (e_num > 0),
            e_duration INTERVAL NOT NULL,
            e_date DATE NOT NULL
        );
        ALTER TABLE Episodes ADD FOREIGN KEY (e_idSeason) REFERENCES Seasons(ss_id);

        DROP TABLE IF EXISTS Users CASCADE;
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

        DROP TABLE IF EXISTS Favourites CASCADE;
        CREATE TABLE Favourites (
            f_id SERIAL NOT NULL PRIMARY KEY,
            f_cntSerials INT NOT NULL CHECK (f_cntSerials >= 0)
        );
        ALTER TABLE Users ADD FOREIGN KEY (u_idFavourites) REFERENCES Favourites(f_id);

        DROP TABLE IF EXISTS Serials_Favourites CASCADE;
        CREATE TABLE Serials_Favourites (
            sf_id SERIAL NOT NULL PRIMARY KEY,
            sf_idSerial INT NOT NULL,
            sf_idFavourite INT NOT NULL
        );
        ALTER TABLE Serials_Favourites ADD FOREIGN KEY (sf_idSerial) REFERENCES Serials(s_id);
        ALTER TABLE Serials_Favourites ADD FOREIGN KEY (sf_idFavourite) REFERENCES Favourites(f_id);
        """
        cursor.execute(setup_query)
        conn.commit()
        cursor.close()
        print("Database setup completed.")
    except Exception as e:
        print(f"Error setting up the database: {e}")

def populate_database(conn):
    fake = Faker()
    try:
        cursor = conn.cursor()

        # Create producers
        cursor.execute(
            "INSERT INTO Producers (p_name, p_surname) VALUES (%s, %s) RETURNING p_id",
            (fake.first_name(), fake.last_name())
        )
        producer_id = cursor.fetchone()[0]

        # Create favourites
        cursor.execute(
            "INSERT INTO Favourites (f_cntSerials) VALUES (%s) RETURNING f_id",
            (0,)
        )
        favourites_id = cursor.fetchone()[0]

        # Create user
        cursor.execute(
            "INSERT INTO Users (u_idFavourites, u_login, u_password, u_role, u_name, u_surname, u_gender, u_bdate) VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING u_id",
            (favourites_id, fake.user_name(), fake.password(), 'user', fake.first_name(), fake.last_name(), random.choice(['мужской', 'женский']), fake.date_of_birth(minimum_age=18, maximum_age=80))
        )
        user_id = cursor.fetchone()[0]

        expected_results = []

        # Create serials for each class of equivalence
        # Class 1: 1 сериал
        serial_id = create_serial(cursor, producer_id, favourites_id, fake, serial_name="Class 1 Serial", num_seasons=1, num_episodes=[5], duration_per_episode=[timedelta(minutes=20)])
        expected_results.append((serial_id, "Class 1 Serial", "Class 1 Serial Description", timedelta(minutes=100)))

        # Class 2: несколько сериалов
        serial_id1 = create_serial(cursor, producer_id, favourites_id, fake, serial_name="Class 2 Serial 1", num_seasons=1, num_episodes=[5], duration_per_episode=[timedelta(minutes=20)])
        serial_id2 = create_serial(cursor, producer_id, favourites_id, fake, serial_name="Class 2 Serial 2", num_seasons=2, num_episodes=[3, 3], duration_per_episode=[timedelta(minutes=30), timedelta(minutes=30)])
        expected_results.append((serial_id1, "Class 2 Serial 1", "Class 2 Serial 1 Description", timedelta(minutes=100)))
        expected_results.append((serial_id2, "Class 2 Serial 2", "Class 2 Serial 2 Description", timedelta(minutes=180)))

        # Class 3: нет сериалов
        # No action needed, the user has no serials that fit in the weekend time

        # Class 4: сериал из 1 сезона и 1 серии
        serial_id = create_serial(cursor, producer_id, favourites_id, fake, serial_name="Class 4 Serial", num_seasons=1, num_episodes=[1], duration_per_episode=[timedelta(minutes=40)])
        expected_results.append((serial_id, "Class 4 Serial", "Class 4 Serial Description", timedelta(minutes=40)))

        # Class 5: сериал из 1 сезона
        serial_id = create_serial(cursor, producer_id, favourites_id, fake, serial_name="Class 5 Serial", num_seasons=1, num_episodes=[8], duration_per_episode=[timedelta(minutes=30)])
        expected_results.append((serial_id, "Class 5 Serial", "Class 5 Serial Description", timedelta(minutes=240)))

        conn.commit()
        cursor.close()
        print("Database population completed.")
        return user_id, expected_results
    except Exception as e:
        print(f"Error populating the database: {e}")
        return None, None

def create_serial(cursor, producer_id, favourites_id, fake, serial_name, num_seasons, num_episodes, duration_per_episode):
    cursor.execute(
        "INSERT INTO Serials (s_idProducer, s_img, s_name, s_description, s_year, s_genre, s_rating, s_seasons, s_state, s_duration) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING s_id",
        (
            producer_id,
            fake.image_url(),
            serial_name,
            f"{serial_name} Description",
            random.randint(1900, 2023),
            random.choice(['Drama', 'Comedy', 'Action']),
            round(random.uniform(0, 10), 1),
            num_seasons,
            'завершен',
            '00:00:00'
        )
    )
    serial_id = cursor.fetchone()[0]

    total_duration = timedelta()
    for season_num in range(1, num_seasons + 1):
        cursor.execute(
            "INSERT INTO Seasons (ss_idSerial, ss_name, ss_num, ss_cntEpisodes, ss_date) VALUES (%s, %s, %s, %s, %s) RETURNING ss_id",
            (
                serial_id,
                f"Season {season_num}",
                season_num,
                num_episodes[season_num - 1],
                fake.date_between(start_date='-5y', end_date='today')
            )
        )
        season_id = cursor.fetchone()[0]

        for episode_num in range(1, num_episodes[season_num - 1] + 1):
            episode_duration = duration_per_episode[season_num - 1]
            total_duration += episode_duration
            cursor.execute(
                "INSERT INTO Episodes (e_idSeason, e_name, e_num, e_duration, e_date) VALUES (%s, %s, %s, %s, %s)",
                (
                    season_id,
                    f"Episode {episode_num}",
                    episode_num,
                    str(episode_duration),
                    fake.date_between(start_date='-5y', end_date='today')
                )
            )

    cursor.execute(
        "UPDATE Serials SET s_duration = %s WHERE s_id = %s",
        (str(total_duration), serial_id)
    )

    cursor.execute(
        "INSERT INTO Serials_Favourites (sf_idSerial, sf_idFavourite) VALUES (%s, %s)",
        (serial_id, favourites_id)
    )

    return serial_id

def export_db_to_excel(conn, filename):
    try:
        query = """
        SELECT Serials.s_id, Serials.s_name, Serials.s_description, Serials.s_duration, Favourites.f_id
        FROM Serials
        JOIN Serials_Favourites ON Serials.s_id = Serials_Favourites.sf_idSerial
        JOIN Favourites ON Serials_Favourites.sf_idFavourite = Favourites.f_id
        """
        df = pd.read_sql_query(query, conn)
        df.to_excel(filename, index=False)
        print(f"Database exported to {filename}")
    except Exception as e:
        print(f"Error exporting database to Excel: {e}")

def call_stored_procedure(conn, user_id):
    try:
        cursor = conn.cursor()
        cursor.callproc('get_weekend_serials', [user_id])
        result = cursor.fetchall()
        conn.commit()
        cursor.close()
        return result
    except Exception as e:
        print(f"Error calling stored procedure: {e}")
        return None

def compare_excel_files(file1, file2):
    try:
        df1 = pd.read_excel(file1)
        df2 = pd.read_excel(file2)
        comparison = df1.equals(df2)
        return comparison
    except Exception as e:
        print(f"Error comparing Excel files: {e}")
        return False

def main():
    conn = connect_to_db()
    if not conn:
        return False

    setup_database(conn)
    user_id, expected_results = populate_database(conn)
    if user_id is None:
        return False

    export_db_to_excel(conn, 'old.xlsx')

    result = call_stored_procedure(conn, user_id)
    if result is None:
        print("Failed to call stored procedure.")
        return False

    expected_serials = {str(res[0]): res[1:] for res in expected_results}
    returned_serials = {str(serial[0]): serial[1:] for serial in result}

    print(expected_serials)
    print(returned_serials)

    if expected_serials != returned_serials:
        print(f"Test failed. Expected: {expected_serials}, Got: {returned_serials}")
        return False

    export_db_to_excel(conn, 'new.xlsx')

    if compare_excel_files('old.xlsx', 'new.xlsx'):
        print("The files old.xlsx and new.xlsx are identical.")
        return True
    else:
        print("The files old.xlsx and new.xlsx are different.")
        return False

if __name__ == "__main__":
    success = main()
    print(f"Operation successful: {success}")

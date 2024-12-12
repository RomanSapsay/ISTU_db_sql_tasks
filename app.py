import psycopg2
from psycopg2 import sql

def main():
    HOST = 'autorack.proxy.rlwy.net'
    PORT = '56784'
    DATABASE = 'railway'
    USER = 'postgres'
    PASSWORD = 'EfOFAAZabDkkMOuuBrvHpwFILlrPUsHF'

    connection = connect_to_database(HOST, PORT, DATABASE, USER, PASSWORD)

    if connection:
        try:
            tables = check_tables(connection)

        except Exception as e:
            print(f"Виникла помилка: {e}")

        finally:
            if connection:
                connection.close()
                print("\nПідключення до БД закрито.")

def connect_to_database(host, port, database, user, password):
    try:
        connection = psycopg2.connect(
            host=host,
            port=port,
            database=database,
            user=user,
            password=password
        )
        return connection
    except (Exception, psycopg2.Error) as error:
        print(f"Помилка підключення до PostgreSQL: {error}")
        return None


def check_tables(connection):
    try:
        cursor = connection.cursor()
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public'
        """)
        tables = cursor.fetchall()

        if not tables:
            print("Таблиці відсутні в базі даних.")
            return []

        print("Таблиці в базі даних:")
        for table in tables:
            print(f"- {table[0]}")
        return [table[0] for table in tables]

    except (Exception, psycopg2.Error) as error:
        print(f"Помилка перевірки таблиць: {error}")
        return []

if __name__ == "__main__":
    main()
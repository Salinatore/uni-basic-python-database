## Getting Started

Assuming you have [uv](https://docs.astral.sh/uv/) installed, you can run the following command to install the dependencies:

```bash
uv sync
```

Before running the application,
make sure to set up your database configuration file in model/config.py and create the database from seed.sql.
You need to provide your database credentials in the `model/config.py` file.
The database connection string should be formatted as follows:

```python
from urllib.parse import quote_plus

DB_USERNAME = "your_username"  # Replace with your database username
DB_PASSWORD = "your_password"  # Replace with your database password
DB_PORT = 3306  # Default MySQL port
DB_HOST = "localhost"  # Replace with your database host
DB_NAME = "brand_di_moda"  # Replace with your database name

password_enc = quote_plus(DB_PASSWORD)

DATABASE_URL = f"mysql+pymysql://{DB_USERNAME}:{password_enc}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
```

Before running the application, make sure to set up your database configuration file in model/config.py. Then, create the database by executing the seed.sql file using the following command:
```bash
mysql -u root -p  < seed.sql
```

To run the application, use the following command:

```bash
uv run main.py
```
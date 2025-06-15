## Getting Started

Assuming you have [uv](https://docs.astral.sh/uv/) installed, you can run the following command to install all the dependencies:

```bash
uv sync
```

Before running the application,
make sure to set up your database configuration file in model/config.py.
As an example, you can use the following configuration:

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

Create the database by executing the seed.sql.
You can do that using the following command:

```bash
mysql -u root -p  < seed.sql
```

To run the application, you can use the following command:

```bash
uv run main.py
```

To log in as an admin user, you can use the following credentials:
```plaintext
Codice Aziendale: 1
Password: abc12
```
To log in as a regular user, you can use the following credentials:
```plaintext
Codice Aziendale: 2
Password: def34
```
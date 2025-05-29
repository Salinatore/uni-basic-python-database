## Getting Started

Assuming you have [uv](https://docs.astral.sh/uv/) installed, you can run the following command to install the dependencies:

```bash
uv sync
```

Before running the application, make sure to set up your database configuration file in model/config.py.
Here an example:

```python
from urllib.parse import quote_plus

DB_USERNAME = ""
DB_PASSWORD = ""
DB_PORT = ""
DB_HOST = ""
DB_NAME = ""

password_enc = quote_plus(DB_PASSWORD)

DATABASE_URL = f"mysql+pymysql://{DB_USERNAME}:{password_enc}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
```

To run the application, use the following command:

```bash
uv run main.py
```
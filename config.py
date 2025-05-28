from urllib.parse import quote_plus

DB_USERNAME = "root"
DB_PASSWORD = "Mattarella@0543"
DB_HOST = "localhost"
DB_PORT = 3306
DB_NAME = "brand_di_moda"

password_enc = quote_plus(DB_PASSWORD)

DATABASE_URL = f"mysql+pymysql://{DB_USERNAME}:{password_enc}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

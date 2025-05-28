from sqlalchemy import create_engine, MetaData, inspect
from sqlalchemy.orm import sessionmaker
from config import DATABASE_URL

engine = create_engine(DATABASE_URL)
Session = sessionmaker(bind=engine)
session = Session()
metadata = MetaData()
metadata.reflect(bind=engine)

def get_all_tables():
    inspector = inspect(engine)
    tables = inspector.get_table_names()
    return tables

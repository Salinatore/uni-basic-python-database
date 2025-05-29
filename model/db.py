from sqlalchemy import create_engine, MetaData, text
from sqlalchemy.orm import sessionmaker
from model.config import DATABASE_URL
import atexit

# Create engine and session ONCE
engine = create_engine(DATABASE_URL)
Session = sessionmaker(bind=engine)
session = Session()

# Reflect metadata once
metadata = MetaData()
metadata.reflect(bind=engine)


@atexit.register
def _shutdown_connection():
    session.close()


def _query_with_input(query_text, code_id):
    result = session.execute(query_text, {"id": code_id})
    rows = [dict(row) for row in result.mappings()]
    return rows


def get_rooms_by_building_code(building_code):
    query = text(
        """
                    SELECT *
                    FROM stanza s
                    WHERE s.Div_numero_immobile = :id;
                """
    )
    return _query_with_input(query, building_code)


def get_material_by_dress_code(dress_code):
    query = text(
        """
                    SELECT m.*, c.quantita_usata
                    FROM composto c, abito a, materiale m
                    WHERE c.codice_materiale = m.codice_materiale
                    AND c.codice_abito = a.codice_abito
                    AND c.codice_abito = :id;
                 """
    )
    return _query_with_input(query, dress_code)

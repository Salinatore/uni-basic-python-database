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


def get_userinfo_from_company_code(company_code):
    query = text(
        """
            SELECT p.password_applicativo, p.amministratore_sistema
            FROM PERSONALE p
            WHERE p.codice_aziendale = :id
        """
    )
    results = _query_with_input(query, company_code)
    if results:
        return results[0]
    else:
        return None


def get_rooms_from_building_code(building_code):
    query = text(
        """
            SELECT *
            FROM stanza s
            WHERE s.Div_numero_immobile = :id;
        """
    )
    return _query_with_input(query, building_code)


def get_materials_from_dress_code(dress_code):
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


def insert_work_group(start_work_date, description, group_type):
    query = text(
        """
            INSERT INTO GRUPPO_DI_LAVORO (data_inizio_lavoro, data_fine_lavoro, descrizione, tipo_gruppo)
            VALUES (:start_work_date, NULL, :description, :group_type);
        """
    )
    session.execute(query, {"start_work_date": start_work_date, "description": description, "group_type": group_type})
    session.commit()


def get_dresses_from_model_code(model_code):
    query = text(
        """
            SELECT a.* 
            FROM modella m, spesa s, turno_della_modella_nella_sfilata t, abito a
            WHERE m.CF = s.CF
            AND s.codice_contrattuale = t.codice_contrattuale
            AND t.codice_abito = :id;  
        """
    )
    return _query_with_input(query, model_code)


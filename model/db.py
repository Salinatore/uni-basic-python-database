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

def _query_with_input(query_text, params):
    if not isinstance(params, dict):
        params = {"id": params}
    result = session.execute(query_text, params)
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
    results = _query_with_input(query, {"id": company_code})
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
    return _query_with_input(query, {"id": building_code})

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
    return _query_with_input(query, {"id": dress_code})

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
    return _query_with_input(query, {"id": model_code})

def insert_participation(event_code, person_cf, cost):
    query = text(
        """
            INSERT INTO partecipazione (codice_evento, CF, costo)
            VALUES (:event_code, :person_cf, :cost);
        """
    )
    session.execute(query, {
        "event_code": event_code,
        "person_cf": person_cf,
        "cost": cost
    })
    session.commit()

def get_work_groups_from_room_number(room_number):
    query = text(
        """
            SELECT t.codice_lavoro 
            FROM TURNO_di_LAVORO t, STANZA s
            WHERE t.Div_numero_immobile = s.Div_numero_immobile
            AND t.Div_numero = s.Div_numero
            AND t.numero = s.numero
            AND s.numero = :id;
        """
    )
    return _query_with_input(query, {"id": room_number})

def get_max_paid_model_contract():
    query = text(
        """
            SELECT MAX(s.costo) AS contratto_modella_massimo
            FROM SPESA s
            WHERE s.CF IS NOT NULL;
        """
    )
    result = session.execute(query).scalar()
    return result

def get_event_with_most_participants():
    query = text(
        """
            SELECT e.codice_evento
            FROM EVENTO e
            WHERE e.partecipanti = (
                SELECT MAX(ei.partecipanti)
                FROM EVENTO ei
            );
        """
    )
    results = session.execute(query).scalars().all()
    return results

def get_dresses_from_event_code(event_code):
    query = text(
        """
            SELECT a.*
            FROM TURNO_della_MODELLA_nella_SFILATA t, ABITO a
            WHERE t.codice_abito = a.codice_abito
            AND t.codice_evento = :id;
        """
    )
    return _query_with_input(query, {"id": event_code})

def insert_work_shift(new_start, new_end, building_code, floor_code, room_code, codice_lavoro):
    query = text(
        """
            INSERT INTO TURNO_di_LAVORO (
                data_inizio, 
                data_fine, 
                descrizione, 
                cancellato, 
                Div_numero_immobile, 
                Div_numero, 
                numero, 
                codice_lavoro
            )
            VALUES (
                :new_start, 
                :new_end, 
                'Cucire', 
                '0', 
                :building_code, 
                :floor_code, 
                :room_code, 
                :codice_lavoro
            );
        """
    )
    session.execute(query, {
        "new_start": new_start,
        "new_end": new_end,
        "building_code": building_code,
        "floor_code": floor_code,
        "room_code": room_code,
        "codice_lavoro": codice_lavoro
    })
    session.commit()

def insert_new_expense(id_spesa, data_ora, costo, cf=None, codice_contrattuale=None, codice_materiale=None, altro_campo=None):
    query = text(
        """
            INSERT INTO SPESE
            VALUES (:id_spesa, :data_ora, :costo, :cf, :altro_campo1, :codice_materiale, :altro_campo2);
        """
    )
    session.execute(query, {
        "id_spesa": id_spesa,
        "data_ora": data_ora,
        "costo": costo,
        "cf": cf,
        "altro_campo1": altro_campo,
        "codice_materiale": codice_materiale,
        "altro_campo2": None
    })
    session.commit()

def get_total_hours_worked_by_employee(cf):
    query = text(
        """
            SELECT SUM(TIMESTAMPDIFF(HOUR, t.data_inizio, t.data_fine)) AS numero_ore
            FROM partecipanti_turno pt
            JOIN PERSONALE p ON pt.CF = p.CF
            JOIN TURNO_di_LAVORO t ON pt.codice_lavoro = p.codice_lavoro AND pt.codice_lavoro = t.codice_lavoro AND pt.data_inizio = t.data_inizio
            WHERE p.CF = :cf;
        """
    )
    result = session.execute(query, {"cf": cf}).scalar()
    return result

def get_highest_paid_work_group():
    query = text(
        """
        WITH stipendi AS (
            SELECT 
                p.codice_lavoro,
                SUM(c.stipendio_mensile) AS totale_stipendio
            FROM PERSONALE p
            JOIN OCCUPAZIONE o ON p.CF = o.CF
            JOIN CONTRATTO_PERSONALE c ON o.codice_tipologia_contratto = c.codice_tipologia_contratto
            WHERE o.fine_validita IS NULL
            GROUP BY p.codice_lavoro
        )
        SELECT codice_lavoro, totale_stipendio
        FROM stipendi
        WHERE totale_stipendio = (SELECT MAX(totale_stipendio) FROM stipendi);
        """
    )
    results = session.execute(query).mappings().all()
    return results

def change_employee_work_group(cf, new_codice_lavoro):
    with session.begin():
        current_data = session.execute(
            text("SELECT codice_lavoro, occupazione_presente_inizio FROM PERSONALE WHERE CF = :cf"),
            {"cf": cf}
        ).mappings().first()

        if not current_data:
            raise ValueError(f"Dipendente con CF {cf} non trovato")

        codice_lavoro_vecchio = current_data["codice_lavoro"]
        inizio_lavoro_vecchio = current_data["occupazione_presente_inizio"]

        session.execute(
            text("""
                INSERT INTO OCCUPAZIONE_PASSATA (codice_lavoro, occupazione_presente_inizio, CF, data_fine)
                VALUES (:codice_lavoro_vecchio, :inizio_lavoro_vecchio, :cf, NOW())
            """),
            {
                "codice_lavoro_vecchio": codice_lavoro_vecchio,
                "inizio_lavoro_vecchio": inizio_lavoro_vecchio,
                "cf": cf
            }
        )

        session.execute(
            text("""
                UPDATE PERSONALE
                SET occupazione_presente_inizio = NOW(), codice_lavoro = :new_codice_lavoro
                WHERE CF = :cf
            """),
            {
                "new_codice_lavoro": new_codice_lavoro,
                "cf": cf
            }
        )
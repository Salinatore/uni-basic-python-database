from typing import Any

from sqlalchemy import create_engine, MetaData, text, Result
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


def compress_to_dict_list(query_results: Result[Any]) -> list[dict[str, Any]]:
    return [dict(row) for row in query_results.mappings()]


def _query_with_input(
    query_text, params, default_key: str = "id"
) -> list[dict[str, Any]]:
    if not isinstance(params, dict):
        params = {default_key: params}
    results: Result = session.execute(query_text, params)
    return compress_to_dict_list(results)


def get_userinfo_from_company_code(
    company_code,
) -> tuple[None, None] | tuple[str, str]:
    try:
        company_code = int(company_code)
    except ValueError:
        return None, None
    query = text(
        """
            SELECT password_applicativo, codice_lavoro
            FROM PERSONALE
            WHERE codice_aziendale = :id
        """
    )
    results = _query_with_input(query, {"id": company_code})
    if not results:
        return None, None

    if len(results) > 1:
        raise ValueError("Il codice aziendale non è univoco.")
    result = results[0]
    password, company_code = result.values()
    query = text(
        """
        SELECT tipo_gruppo
        FROM GRUPPO_DI_LAVORO
        WHERE codice_lavoro = :id
        """
    )
    results = _query_with_input(query, {"id": company_code})
    if len(results) != 1:
        raise ValueError("Il codice aziendale non è univoco.")
    group_type = results[0]["tipo_gruppo"]
    return group_type, password


def get_rooms_from_building_code(building_code) -> list[dict[str, str]]:
    query = text(
        """
            SELECT Div_numero_immobile AS numero_immobile, Div_numero AS numero_piano, numero AS numero_stanza, partecipanti_massimi, tipo_stanza, capienza, codice_lavoro AS codice_gruppo_lavoro
            FROM stanza s
            WHERE s.Div_numero_immobile = :id;
        """
    )
    return _query_with_input(query, {"id": building_code})


def get_materials_from_dress_code(dress_code) -> list[dict[str, str]]:
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


def insert_work_group(start_work_date, description, group_type) -> None:
    query = text(
        """
            INSERT INTO GRUPPO_DI_LAVORO (data_inizio_lavoro, data_fine_lavoro, descrizione, tipo_gruppo)
            VALUES (:start_work_date, NULL, :description, :group_type);
        """
    )
    session.execute(
        query,
        {
            "start_work_date": start_work_date,
            "description": description,
            "group_type": group_type,
        },
    )
    session.commit()


def get_dresses_from_model_code(model_code) -> list[dict[str, str]]:
    query = text(
        """
            SELECT a.* 
            FROM modella m, spesa s, turno_della_modella_nella_sfilata t, abito a
            WHERE m.CF = s.CF
            AND s.codice_contrattuale = t.codice_contrattuale
            AND t.codice_abito = :id;  
        """
    )  # TODO: check if this query is correct
    return _query_with_input(query, {"id": model_code})


def insert_participation(event_code, person_cf, cost) -> None:
    query = text(
        """
            INSERT INTO partecipazione (codice_evento, CF, costo)
            VALUES (:event_code, :person_cf, :cost);
        """
    )
    session.execute(
        query, {"event_code": event_code, "person_cf": person_cf, "cost": cost}
    )
    session.commit()


def get_work_groups_from_room_number(room_number) -> list[dict[str, str]]:
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


def get_max_paid_model_contract() -> list[dict[str, str]]:
    query = text(
        """
            SELECT MAX(s.costo) AS contratto_modella_massimo
            FROM SPESA s
            WHERE s.CF IS NOT NULL;
        """
    )
    result = session.execute(query)
    return compress_to_dict_list(result)


def get_event_with_most_participants() -> list[dict[str, str]]:
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
    results = session.execute(query)
    return compress_to_dict_list(results)


def get_dresses_from_event_code(event_code) -> list[dict[str, str]]:
    query = text(
        """
            SELECT a.*
            FROM TURNO_della_MODELLA_nella_SFILATA t, ABITO a
            WHERE t.codice_abito = a.codice_abito
            AND t.codice_evento = :id;
        """
    )
    return _query_with_input(query, {"id": event_code})


def insert_work_shift(
    new_start,
    new_end,
    building_code,
    floor_code,
    room_code,
    codice_lavoro,
    description,
) -> None:
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
                :description, 
                '0', 
                :building_code, 
                :floor_code, 
                :room_code, 
                :codice_lavoro
            );
        """
    )
    session.execute(
        query,
        {
            "new_start": new_start,
            "new_end": new_end,
            "building_code": building_code,
            "floor_code": floor_code,
            "room_code": room_code,
            "codice_lavoro": codice_lavoro,
            "description": description,
        },
    )
    session.commit()


def insert_new_expense(
    contract_code,
    date,
    cost,
    address_street=None,
    address_street_number=None,
    job_code=None,
    fiscal_code=None,
) -> None:
    query = text(
        """
            INSERT INTO SPESE(codice_contrattuale, data, costo, indirizzo___via, indirizzo___nuemro_civico, codice_lavoro, CF) 
            VALUES (:contract_code, :date, :cost, :address_street, :address_street_number, :job_code, :CF);
        """
    )
    session.execute(
        query,
        {
            "contract_code": contract_code,
            "date": date,
            "cost": cost,
            "address_street": address_street if address_street else "NULL",
            "address_street_number": address_street_number
            if address_street_number
            else "NULL",
            "job_code": job_code if job_code else "NULL",
            "CF": fiscal_code if fiscal_code else "NULL",
        },
    )
    session.commit()


def get_total_hours_worked_by_employee(cf) -> list[dict[str, str]]:
    query = text(
        """
            SELECT SUM(TIMESTAMPDIFF(HOUR, t.data_inizio, t.data_fine)) AS numero_ore
            FROM partecipanti_turno pt
            JOIN PERSONALE p ON pt.CF = p.CF
            JOIN TURNO_di_LAVORO t ON pt.codice_lavoro = p.codice_lavoro AND pt.codice_lavoro = t.codice_lavoro AND pt.data_inizio = t.data_inizio
            WHERE p.CF = :cf;
        """
    )
    result = session.execute(query, {"cf": cf})
    result_list = compress_to_dict_list(result)
    if result_list and len(result_list) > 1:
        raise ValueError(
            "Errore: più di un risultato trovato per il CF specificato."
        )
    return result_list if result_list else [{"numero_ore": 0}]


def get_highest_paid_work_group() -> list[dict[str, str]]:
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
    results = session.execute(query)
    return compress_to_dict_list(results)


def change_employee_work_group(cf, new_codice_lavoro) -> None:
    previews_work_code_query = text(
        """
            SELECT codice_lavoro, occupazione_presente_inizio
            FROM PERSONALE
            WHERE CF = :cf;
        """
    )
    output = _query_with_input(previews_work_code_query, {"cf": cf})

    if output:
        previews_work_code = output[0]["codice_lavoro"]
        previews_work_start = output[0]["occupazione_presente_inizio"]
    else:
        raise ValueError("Il CF specificato non esiste.")

    insert_old_occupation_query = text(
        """
            INSERT INTO OCCUPAZIONE_PASSATA (codice_lavoro, inizio_lavoro, CF, fine_lavoro) 
            VALUES (:previews_work_code, :previews_work_start, :cf, NOW());
        """
    )
    session.execute(
        insert_old_occupation_query,
        {
            "previews_work_code": previews_work_code,
            "previews_work_start": previews_work_start,
            "cf": cf,
        },
    )
    session.commit()

    update_current_occupation_query = text(
        """
            UPDATE PERSONALE
            SET codice_lavoro = :new_codice_lavoro, occupazione_presente_inizio = NOW()
            WHERE CF = :cf;
        """
    )
    session.execute(
        update_current_occupation_query,
        {
            "new_codice_lavoro": new_codice_lavoro,
            "cf": cf,
        },
    )
    session.commit()

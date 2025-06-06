from dataclasses import dataclass, field
from typing import List, Callable, Any
from model.db import (
    get_rooms_from_building_code,
    get_dresses_from_model_code,
    get_materials_from_dress_code,
    insert_work_group,
    insert_participation,
    get_work_groups_from_room_number,
    get_max_paid_model_contract,
    get_event_with_most_participants,
    get_dresses_from_event_code,
    insert_work_shift,
    insert_new_expense,
    get_total_hours_worked_by_employee,
    get_highest_paid_work_group,
    change_employee_work_group,
)


def default_operation():
    raise NotImplementedError("This operation is not implemented yet.")


@dataclass(frozen=True)
class Operation:
    desc: str
    admin_only: bool
    input_fields: List[str] = field(default_factory=list)
    operation_handler: Callable[..., Any] = field(default=default_operation)


USER_OPERATIONS = [
    Operation(
        "Visualizzare tutte le stanze contenute in un immobile",
        True,
        ["codice immobile"],
        get_rooms_from_building_code,
    ),
    Operation(
        "Visualizzazione dei materiali utilizzati per un determinato abito",
        True,
        ["codice abito"],
        get_materials_from_dress_code,
    ),
    Operation(
        "Creazione di un gruppo di lavoro",
        True,
        ["data inizio lavoro", "descrizione", "tipo gruppo"],
        insert_work_group,
    ),
    Operation(
        "Visualizzazione di tutti gli abiti indossati da una modella",
        False,
        ["codice modella"],
        get_dresses_from_model_code,
    ),
    Operation(
        "Aggiunta di un partecipante a un evento",
        False,
        ["codice evento", "CF persona", "costo"],
        insert_participation,
    ),
    Operation(
        "Visualizzazione dei gruppi di lavoro che hanno occupato un ufficio",
        False,
        ["numero stanza"],
        get_work_groups_from_room_number,
    ),
    Operation(
        "Contratto pagato più alto tra le modelle",
        False,
        [],
        get_max_paid_model_contract,
    ),
    Operation(
        "Visualizzazione dell'evento con più partecipanti",
        False,
        [],
        get_event_with_most_participants,
    ),
    Operation(
        "Visualizzazione di tutti gli abiti indossati in un evento",
        False,
        ["codice evento"],
        get_dresses_from_event_code,
    ),
    Operation(
        "Prenotazione turni di lavoro in una stanza per un determinato gruppo",
        False,
        [
            "data inizio turno",
            "data fine turno",
            "codice immobile",
            "codice piano",
            "codice stanza",
            "codice lavoro",
            "descrizione",
        ],
        insert_work_shift,
    ),
    Operation(
        "Aggiunta di un nuovo acquisto",
        False,
        [
            "id spesa",
            "data e ora",
            "costo",
            "CF (opzionale)",
            "codice contrattuale (opzionale)",
            "codice materiale (opzionale)",
            "altro campo (opzionale)",
        ],
        insert_new_expense,
    ),
    Operation(
        "Visualizzazione delle ore fatte da un dipendente nel suo attuale gruppo di lavoro",
        False,
        ["CF dipendente"],
        get_total_hours_worked_by_employee,
    ),
    Operation(
        "Individuazione del gruppo di lavoro con il personale più retribuito (attuale e passato)",
        False,
        [],
        get_highest_paid_work_group,
    ),
    Operation(
        "Cambio gruppo per un dipendente specializzato",
        False,
        ["CF dipendente", "nuovo codice lavoro"],
        change_employee_work_group,
    ),
]

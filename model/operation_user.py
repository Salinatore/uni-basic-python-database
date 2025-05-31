from dataclasses import dataclass, field
from typing import List, Callable, Any
from model.db import (
    get_rooms_from_building_code,
    get_dresses_from_model_code,
    get_materials_from_dress_code,
    insert_work_group
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
    Operation("Visualizzare tutte le stanze contenute in un immobile", True, ["codice immobile"], get_rooms_from_building_code),
    Operation("Visualizzazione dei materiali utilizzati per un determinato abito", True, ["codice abito"], get_materials_from_dress_code),
    Operation("Creazione di un gruppo di lavoro", True, ["data inizio lavoro", "descrizione", "tipo gruppo"], insert_work_group),
    Operation("Visualizzazione di tutti gli abiti indossati da una modella", False, ["codice modella"], get_dresses_from_model_code),
    Operation("Aggiunta di un partecipante a un evento", False),
    Operation("Visualizzazione dei gruppi di lavoro che hanno occupato un ufficio", False),
    Operation("Contratto pagato più alto tra le modelle", False),
    Operation("Visualizzazione dell'evento con più partecipanti", False),
    Operation("Visualizzazione di tutti gli abiti indossati in un evento", False),
    Operation("Prenotazione turni di lavoro in una stanza per un determinato gruppo", False),
    Operation("Aggiunta di un nuovo acquisto", False),
    Operation("Visualizzazione delle ore fatte da un dipendente nel suo attuale gruppo di lavoro", False),
    Operation("Individuazione del gruppo di lavoro con il personale più retribuito (attuale e passato)", False),
    Operation("Cambio gruppo per un dipendente specializzato", False)
]
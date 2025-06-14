"""
This module defines the operation catalog for the application.

It includes various operations that users can perform, each represented
by an `Operation` dataclass. Operations are executed in separate threads
to avoid blocking the GUI.
"""

from collections.abc import Callable
from dataclasses import dataclass, field
from functools import wraps
import threading
from typing import Any

from model.db import (
    change_employee_work_group,
    get_dresses_from_event_code,
    get_dresses_from_model_code,
    get_event_with_most_participants,
    get_highest_paid_work_group,
    get_max_paid_model_contract,
    get_total_hours_worked_by_employee,
    get_work_groups_from_room_number,
    get_materials_from_dress_code,
    get_rooms_from_building_code,
    insert_new_expense,
    insert_participation,
    insert_work_group,
    insert_work_shift,
)


def default_operation(*args, **kwargs) -> None:
    raise NotImplementedError("This operation is not implemented yet.")


@dataclass(frozen=True)
class Operation:
    """
    Represents an operation that can be performed in the application.

    Attributes:
        desc (str): Description of the operation.
        admin_only (bool): Indicates if the operation is restricted to admin users.
        input_fields (list[str]): List of input fields required for the operation.
        operation_handler (Callable[..., Any]): Function that handles the operation logic by calling the model.
    """

    desc: str
    admin_only: bool
    input_fields: list[str] = field(default_factory=list)
    operation_handler: Callable[..., Any] = field(default=default_operation)


def threaded_handler(gui, func):
    @wraps(func)
    def wrapper(*args):
        def task():
            try:
                result = func(*args)
                gui.run_on_ui_thread(lambda: gui.display_result(result))
            except Exception as e:
                def error_handler(err=e):
                    gui.display_error(err)
                gui.run_on_ui_thread(error_handler(e))

        threading.Thread(target=task, daemon=True).start()

    return wrapper


def get_admin_operations(gui) -> list[Operation]:
    return [
        Operation(
            "Visualizzare tutte le stanze contenute in un immobile",
            False,
            ["codice immobile"],
            threaded_handler(gui, get_rooms_from_building_code),
        ),
        Operation(
            "Visualizzazione dei materiali utilizzati per un determinato abito",
            False,
            ["codice abito"],
            threaded_handler(gui, get_materials_from_dress_code),
        ),
        Operation(
            "Creazione di un gruppo di lavoro",
            True,
            ["data inizio lavoro", "descrizione", "tipo gruppo"],
            threaded_handler(gui, insert_work_group),
        ),
        Operation(
            "Visualizzazione di tutti gli abiti indossati da una modella",
            False,
            ["codice modella"],
            threaded_handler(gui, get_dresses_from_model_code),
        ),
        Operation(
            "Aggiunta di un partecipante a un evento",
            False,
            ["codice evento", "CF persona", "costo"],
            threaded_handler(gui, insert_participation),
        ),
        Operation(
            "Visualizzazione dei gruppi di lavoro che hanno occupato un ufficio",
            True,
            ["numero stanza"],
            threaded_handler(gui, get_work_groups_from_room_number),
        ),
        Operation(
            "Contratto pagato più alto tra le modelle",
            False,
            [],
            threaded_handler(gui, get_max_paid_model_contract),
        ),
        Operation(
            "Visualizzazione dell'evento con più partecipanti",
            False,
            [],
            threaded_handler(gui, get_event_with_most_participants),
        ),
        Operation(
            "Visualizzazione di tutti gli abiti indossati in un evento",
            False,
            ["codice evento"],
            threaded_handler(gui, get_dresses_from_event_code),
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
            threaded_handler(gui, insert_work_shift),
        ),
        Operation(
            "Aggiunta di un nuovo acquisto",
            False,
            [
                "codice_lavoro",
                "id spesa",
                "data e ora",
                "costo",
                "materiali [codice_materile-quantità,...] es:[1-20]",
            ],
            threaded_handler(gui, insert_new_expense),
        ),
        Operation(
            "Visualizzazione delle ore fatte da un dipendente nel suo attuale gruppo di lavoro",
            True,
            ["CF dipendente"],
            threaded_handler(gui, get_total_hours_worked_by_employee),
        ),
        Operation(
            "Individuazione del gruppo di lavoro con il personale più retribuito (attuale e passato)",
            False,
            [],
            threaded_handler(gui, get_highest_paid_work_group),
        ),
        Operation(
            "Cambio gruppo per un dipendente specializzato",
            True,
            ["CF dipendente", "nuovo codice lavoro"],
            threaded_handler(gui, change_employee_work_group),
        ),
    ]


def get_worker_operations(gui) -> list[Operation]:
    return [op for op in get_admin_operations(gui) if not op.admin_only]

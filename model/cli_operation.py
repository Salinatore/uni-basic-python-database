import model.db as model
from view.cli import print_list


OPERATIONS = {
    1: {"desc": "Visualizzare tutte le stanze contenute in un immobile", "admin_only": True},
    2: {"desc": "Visualizzazione dei materiali utilizzati per un determinato abito", "admin_only": False},
    3: {"desc": "Creazione di un gruppo di lavoro", "admin_only": False},
    4: {"desc": "Visualizzazione di tutti gli abiti indossati da una modella", "admin_only": False},
    5: {"desc": "Aggiunta di un partecipante a un evento", "admin_only": False},
    6: {"desc": "Visualizzazione dei gruppi di lavoro che hanno occupato un ufficio", "admin_only": False},
    7: {"desc": "Contratto pagato più alto tra le modelle", "admin_only": False},
    8: {"desc": "Visualizzazione dell'evento con più partecipanti", "admin_only": False},
    9: {"desc": "Visualizzazione di tutti gli abiti indossati in un evento", "admin_only": False},
    10: {"desc": "Prenotazione turni di lavoro in una stanza per un determinato gruppo", "admin_only": False},
    11: {"desc": "Aggiunta di un nuovo acquisto", "admin_only": False},
    12: {"desc": "Visualizzazione delle ore fatte da un dipendente nel suo attuale gruppo di lavoro", "admin_only": False},
    13: {"desc": "Individuazione del gruppo di lavoro con il personale più retribuito (attuale e passato)", "admin_only": False},
    14: {"desc": "Cambio gruppo per un dipendente specializzato", "admin_only": False}
}


def _op_1():
    building_code = input("Inserisci il codice immobile con cui fare la ricerca: ")
    rooms = model.get_rooms_from_building_code(building_code)
    print_list(rooms)


def _op_2():
    dress_code = input("Inserisci il codice dell'abito con cui fare la ricerca: ")
    materials = model.get_materials_from_dress_code(dress_code)
    print_list(materials)


def _op_3():
    start_work_date = input("Inserisci la data di inizio del gruppo di lavoro (es. 2025-05-27 10:00:00): ")
    description = input("Inserisci la descrizione del gruppo di lavoro: ")
    group_type = input("Inserisci il tipo del gruppo di lavoro: ")
    model.insert_work_group(start_work_date, description, group_type)


def _op_4():
    model_code = input("Inserisci il codice della modella di cui cercare gli abiti: ")
    dresses = model.get_dresses_from_model_code(model_code)
    print_list(dresses)


def _op_5():
    print("Not yet implemented")


def _op_6():
    print("Not yet implemented")


def _op_7():
    print("Not yet implemented")


def _op_8():
    print("Not yet implemented")


def _op_9():
    print("Not yet implemented")


def _op_10():
    print("Not yet implemented")


def _op_11():
    print("Not yet implemented")


def _op_12():
    print("Not yet implemented")


def _op_13():
    print("Not yet implemented")


def _op_14():
    print("Not yet implemented")


OPERATIONS_HANDLERS = {
    1: _op_1,
    2: _op_2,
    3: _op_3
}
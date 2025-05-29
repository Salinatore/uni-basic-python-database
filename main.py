from enum import Enum

from view.cli import show_menu, print_list, print_invalid_choice, show_internal_menu
import model.db as model

ALL_OPERATIONS = {
    1 : "Visualizzare tutte le stanze contenute in un immobile",
    2 : "Visualizzazione dei materiali utilizzati per un determinato abito",
    3 : "Creazione di un gruppo di lavoro",
    4 : "Visualizzazione di tutti gli abiti indossati da una modella",
    5 : "Aggiunta di un partecipante a un evento",
    6 : "Visualizzazione dei gruppi di lavoro che hanno occupato un ufficio",
    7 : "Contratto pagato più alto tra le modelle",
    8: "Visualizzazione dell'evento con più partecipanti",
    9: "Visualizzazione di tutti gli abiti indossati in un evento",
    10: "Prenotazione turni di lavoro in una stanza per un determinato gruppo",
    11: "Aggiunta di un nuovo acquisto",
    12: "Visualizzazione delle ore fatte da un dipendente nel suo attuale gruppo di lavoro",
    13: "Individuazione del gruppo di lavoro con il personale più retribuito (attuale e passato)",
    14: "Cambio gruppo per un dipendente specializzato"
}
ADMIN_OPERATIONS = [
    1, 2, 3
]

class UserType(Enum):
    ADMIN = 1
    WORKER = 2


def main():
    user_type = login()
    query_loop(user_type)


def login():
    return UserType.ADMIN


def query_loop(user_type: UserType):
    while True:
        if user_type == UserType.WORKER:
            operations = {k: v for k, v in ALL_OPERATIONS.items() if k not in ADMIN_OPERATIONS}
        else:
            operations = ALL_OPERATIONS
        show_menu(operations)

        choice = input("Scelta: ")
        try:
            choice = int(choice)
        except ValueError:
            print_invalid_choice()
            continue

        match choice:
            case 0:
                break
            case 1:
                building_code = input("Inserisci il codice immobile con cui fare la ricerca: ")
                rooms = model.get_rooms_by_building_code(building_code)
                print_list(rooms)
            case 2:
                dress_code = input("Inserisci il codice dell'abito con cui fare la ricerca: ")
                materials = model.get_material_by_dress_code(dress_code)
                print_list(materials)
            case 3:
                start_work_date = input("Inserisci la data di inizio del gruppo di lavoro (es. 2025-05-27 10:00:00): ")
                description = input("Inserisci la descrizione del gruppo di lavoro: ")
                group_type = input("Inserisci il tipo del gruppo di lavoro: ")
                model.insert_work_group(start_work_date, description, group_type)
            case _:
                print_invalid_choice()

if __name__ == "__main__":
    main()

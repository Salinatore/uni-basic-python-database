from view.cli import show_menu, print_list, print_invalid_choice
import model.db as model

OPERATIONS = [
        "Visualizzare tutte le stanze contenute in un immobile",
        "Visualizzazione dei materiali utilizzati per un determinato abito",
        "Creazione di un gruppo di lavoro",
        "Visualizzazione di tutti gli abiti indossati da una modella",
        "Aggiunta di un partecipante a un evento",
        "Visualizzazione dei gruppi di lavoro che hanno occupato un ufficio",
        "Contratto pagato più alto tra le modelle",
        "Visualizzazione dell'evento con più partecipanti",
        "Visualizzazione di tutti gli abiti indossati in un evento",
        "Prenotazione turni di lavoro in una stanza per un determinato gruppo",
        "Aggiunta di un nuovo acquisto",
        "Visualizzazione delle ore fatte da un dipendente nel suo attuale gruppo di lavoro",
        "Individuazione del gruppo di lavoro con il personale più retribuito (attuale e passato)",
        "Cambio gruppo per un dipendente specializzato"
]

def main():
    while True:
        show_menu(OPERATIONS)

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
            case _:
                print_invalid_choice()

if __name__ == "__main__":
    main()

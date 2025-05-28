from view.cli import show_menu, print_tables, print_event
from model.db import get_all_tables, get_event_by_id

def main():
    while True:
        show_menu()
        choice = input("Scelta: ")
        if choice == "1":
            events = get_all_tables()
            print_tables(events)
        elif choice == "2":
            event_id = input("Inserisci ID evento: ")
            event = get_event_by_id(int(event_id))
            print_event(event)
        elif choice == "0":
            break
        else:
            print("Scelta non valida.")

if __name__ == "__main__":
    main()

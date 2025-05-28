from view.cli import show_menu, print_tables, print_event
from model.db import get_all_tables

def main():
    while True:
        show_menu()
        choice = input("Scelta: ")
        if choice == "1":
            events = get_all_tables()
            print_tables(events)
        elif choice == "0":
            break
        else:
            print("Scelta non valida.")

if __name__ == "__main__":
    main()

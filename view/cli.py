def show_menu():
    print("\n--- Menu ---")
    print("1. Elenca eventi")
    print("2. Mostra evento per ID")
    print("0. Esci")

def print_tables(tables):
    print("Tabelle presenti nel database:")
    for table in tables:
        print(f"- {table}")

def show_menu():
    print("\n--- Menu ---")
    print("1. Elenca eventi")
    print("2. Mostra evento per ID")
    print("0. Esci")

def print_tables(tables):
    print("Tabelle presenti nel database:")
    for table in tables:
        print(f"- {table}")

def print_event(event):
    if event:
        print(f"ID: {event.id_evento}")
        print(f"Nome: {event.nome_evento}")
        print(f"Data: {event.data_evento}")
    else:
        print("Evento non trovato.")

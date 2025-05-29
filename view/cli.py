def show_menu(operations: list):
    print("\n--- Menu ---")
    for i, operation in enumerate(operations, start=1):
        print(f"{i}: {operation}")
    print("0. Esci")


def print_invalid_choice():
    print("Scelta non valida. Riprova.")


def print_unauthorized_choice():
    print("Scelta non autorizzata. Riprova.")


def print_list(items):
    for item in items:
        print(item)
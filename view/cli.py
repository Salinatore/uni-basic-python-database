def show_menu(operations):
    print("\n--- Menu ---")
    for key, info in operations.items():
        print(f"{key}: {info}")
    print("0. Esci")


def print_invalid_choice():
    print("Scelta non valida. Riprova.")


def print_unauthorized_choice():
    print("Scelta non autorizzata. Riprova.")


def print_list(items):
    for item in items:
        print(item)
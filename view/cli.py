def show_menu(operations):
    print("\n--- Menu ---")
    for key, info in operations.items():
        print(f"{key}: {info}")
    print("0. Esci")


def print_invalid_choice():
    print("Scelta non valida. Riprova.")


def print_list(items):
    for item in items:
        print(item)


def show_internal_menu(internal_operations):
    print("\n--- Sotto-menu ---")
    for i, operation in enumerate(internal_operations, start=1):
        print(f"{i}. {operation}")
    print("0. Ritorna al menu principale")
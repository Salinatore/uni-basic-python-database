from enum import Enum
import model.db
from operation import OPERATIONS_HANDLERS, OPERATIONS
from view.cli import show_menu, print_invalid_choice, print_unauthorized_choice


class UserType(Enum):
    ADMIN = 1
    WORKER = 2


def login(max_attempts=3):
    attempts = 0
    while attempts < max_attempts:
        company_code = input("Inserisci il tuo codice aziendale: ")
        input_password = input("Inserisci la tua password: ")

        db_response = model.db.get_userinfo_by_company_code(company_code)

        if not db_response:
            print("Codice aziendale non trovato.")
            attempts += 1
            continue

        db_password = db_response['password_applicativo']
        user_type = db_response['amministratore_sistema']

        if db_password != input_password:
            print("Password errata")
            attempts += 1
            continue

        return UserType.WORKER if user_type == 0 else UserType.ADMIN

    print("Troppi tentativi falliti.")
    return None


def query_loop(user_type: UserType):
    while True:
        operations = {
            k: v for k, v in OPERATIONS.items()
            if not v["admin_only"] or user_type == UserType.ADMIN
        }
        show_menu({k: v["desc"] for k, v in operations.items()})

        choice = input("Scelta: ")
        try:
            choice = int(choice)
        except ValueError:
            print_invalid_choice()
            continue

        if choice == 0:
            break

        if choice not in operations:
            print_invalid_choice()
            continue

        handler = OPERATIONS_HANDLERS.get(choice)
        if handler:
            handler()
        else:
            print_invalid_choice()


def main():
    user_type = login()
    if user_type is not None:
        query_loop(user_type)


if __name__ == "__main__":
    main()

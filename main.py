from enum import Enum
from operation import OPERATIONS_HANDLERS, OPERATIONS
from view.cli import show_menu, print_invalid_choice, print_unauthorized_choice


class UserType(Enum):
    ADMIN = 1
    WORKER = 2


def main():
    user_type = login()
    query_loop(user_type)


def login():
    return UserType.WORKER


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


if __name__ == "__main__":
    main()

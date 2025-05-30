from model import db
from view.gui import Gui
from model.operation_user import USER_OPERATIONS

class Controller:

    def __init__(self):
        self._gui = Gui(self._login_handler)


    def start(self):
        self._gui.start()


    def _login_handler(self, company_code: str, password: str) -> None:
        db_response = db.get_userinfo_from_company_code(company_code)
        if db_response is None:
            self._gui.show_company_code_not_found()
            return

        db_password = db_response.get("password_applicativo")
        user_type = db_response.get("amministratore_sistema")

        if db_password != password:
            self._gui.show_invalid_password()
            return

        if user_type == 0:
            non_admin_operations = [op for op in USER_OPERATIONS if not op.admin_only]
            self._gui.show_worker_screen(non_admin_operations)
        else:
            self._gui.show_admin_screen(USER_OPERATIONS)

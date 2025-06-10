import threading
from typing import List

from model import db
from view.gui import Gui
from controller.operation_user import build_user_operations, Operation

ADMIN_CODE = "admin"


class Controller:
    def __init__(self):
        self._gui = Gui(self._login_handler)

    def start(self):
        self._gui.start()

    def _login_handler(self, company_code: str, password: str) -> None:
        def thread_func():
            db_response = db.get_userinfo_from_company_code(company_code)
            if db_response is None:
                self._gui.run_on_ui_thread(
                    self._gui.show_company_code_not_found
                )
                return

            group_type, db_password = db_response

            if db_password != password:
                self._gui.run_on_ui_thread(self._gui.show_invalid_password)
                return

            if not group_type:
                self._gui.run_on_ui_thread(
                    self._gui.show_not_associated_with_group
                )
                return

            all_operations: List[Operation] = build_user_operations(self._gui)
            if group_type.lower() == ADMIN_CODE:
                self._gui.run_on_ui_thread(
                    self._gui.show_admin_screen, all_operations
                )
            else:
                non_admin_operations = [
                    op for op in all_operations if not op.admin_only
                ]
                self._gui.run_on_ui_thread(
                    self._gui.show_worker_screen, non_admin_operations
                )

        threading.Thread(target=thread_func, daemon=True).start()

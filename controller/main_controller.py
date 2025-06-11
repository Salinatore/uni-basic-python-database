"""
This module defines the main controller for the application.
"""

import threading

from model import db
from view.gui import Gui
from controller.operations_catalog import get_admin_operations, get_worker_operations

ADMIN_CODE = "admin"


class Controller:
    """
    Main application controller handling login and GUI initialization.

    Processes user login asynchronously and instructs the GUI to display
    different screens based on the user group type (admin or worker).

    It delegates operations management to operations_catalog module.
    """

    def __init__(self):
        self._gui = Gui(self._login_handler)

    def start(self):
        self._gui.start()

    def _login_handler(self, company_code: str, password: str) -> None:
        def thread_func():
            db_response = db.get_userinfo_from_company_code(company_code)
            if db_response is None:
                self._gui.run_on_ui_thread(self._gui.show_company_code_not_found)
                return

            group_type, db_password = db_response

            if db_password != password:
                self._gui.run_on_ui_thread(self._gui.show_invalid_password)
                return

            if not group_type:
                self._gui.run_on_ui_thread(self._gui.show_not_associated_with_group)
                return

            if group_type.lower() == ADMIN_CODE:
                self._gui.run_on_ui_thread(
                    self._gui.show_admin_screen, get_admin_operations(self._gui)
                )
            else:
                self._gui.run_on_ui_thread(
                    self._gui.show_worker_screen, get_worker_operations(self._gui)
                )

        threading.Thread(target=thread_func, daemon=True).start()

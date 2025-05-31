import tkinter as tk
from functools import partial
from tkinter import Tk, messagebox
from typing import List

from model.operation import Operation


class Gui:

    ERROR_TITLE = "Errore"

    def __init__(self, login_action):
        self._window = Tk()
        self._login_action = login_action
        self._window.resizable(False, False)
        self._window.withdraw()  # Hide the window initially
        self._window.deiconify()


    def start(self):
        self.show_login_screen()
        self._window.mainloop()


    def close(self):
        self._window.quit()
        self._window.destroy()


    def show_invalid_password(self):
        messagebox.showerror(self.ERROR_TITLE, "Password non valida")


    def show_company_code_not_found(self):
        messagebox.showerror(self.ERROR_TITLE, "Codice azienda non valido")


    def show_login_screen(self):
        self._destroy_view()
        self._build_login_screen(self._login_action)


    def show_worker_screen(self, operations_dic):
        self._build_operation_screen(operations_dic, "Worker")


    def show_admin_screen(self, operations_dic):
        self._build_operation_screen(operations_dic, "Admin")


    def _build_login_screen(self, login_action):
        self._window.geometry("300x200")
        self._window.title("Login")

        label1 = tk.Label(self._window, text="Codice Aziendale:")
        label1.pack(pady=(10, 0))
        entry1 = tk.Entry(self._window, width=30)
        entry1.pack(pady=5)

        label2 = tk.Label(self._window, text="Password:")
        label2.pack(pady=(10, 0))
        entry2 = tk.Entry(self._window, width=30, show="*")
        entry2.pack(pady=5)

        def submit_login(event=None):
            login_action(entry1.get(), entry2.get())

        button = tk.Button(self._window, text="Invia", command=submit_login)
        button.pack(pady=20)

        self._window.bind("<Return>", submit_login)

        entry1.focus()


    def _build_operation_screen(self, operations_list: List[Operation], screen_name: str) -> None:
        self._destroy_view()
        self._window.geometry("700x600")
        self._window.title(screen_name)

        main_frame = tk.Frame(self._window, padx=10, pady=10)
        main_frame.pack(fill=tk.BOTH, expand=True)

        canvas = tk.Canvas(main_frame)
        scrollbar = tk.Scrollbar(main_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = tk.Frame(canvas)

        scrollable_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )

        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        for op in operations_list:
            op_frame = tk.LabelFrame(scrollable_frame, text=f"[ADMIN] {op.desc}" if op.admin_only else op.desc,
                                     padx=10, pady=10)
            op_frame.pack(fill="x", pady=5)

            entries = {}

            if op.input_fields:
                for field_name in op.input_fields:
                    label = tk.Label(op_frame, text=field_name + ":", anchor="w")
                    label.pack(anchor="w")
                    entry = tk.Entry(op_frame, width=40)
                    entry.pack(fill="x", pady=(0, 5))
                    entries[field_name] = entry
            else:
                no_input_label = tk.Label(op_frame, text="No input required", anchor="w")
                no_input_label.pack(anchor="w", pady=(0, 5))

            btn = tk.Button(op_frame, text="Execute",
                            command=partial(self._execute_operation, op, entries))
            btn.pack(pady=5)


    def _execute_operation(self, operation: Operation, entries: dict[str, tk.Entry]) -> None:
        args = [entries[field].get().strip() for field in operation.input_fields]
        if any(not arg for arg in args) and operation.input_fields:
            messagebox.showwarning("Warning", "Please fill all required fields.")
            return
        try:
            result = operation.operation_handler(*args)
            messagebox.showinfo("Result", f"Operation '{operation.desc}' completed.\nResult:\n{result}")
        except Exception as e:
            messagebox.showerror(self.ERROR_TITLE, f"Error executing operation:\n{e}")


    def _destroy_view(self):
        for widget in self._window.winfo_children():
            widget.destroy()

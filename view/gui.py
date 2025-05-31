import tkinter as tk
from functools import partial
from tkinter import Tk, messagebox
from typing import List

from model.operation_user import Operation


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
        self._window.geometry("350x220")
        self._window.title("Login")
        self._window.protocol("WM_DELETE_WINDOW", lambda: self.close())

        frame = tk.Frame(self._window, padx=20, pady=20)
        frame.pack(expand=True)

        tk.Label(frame, text="Codice Aziendale:").grid(row=0, column=0, sticky="w", pady=(0, 5))
        entry1 = tk.Entry(frame, width=30)
        entry1.grid(row=1, column=0, pady=(0, 15))

        tk.Label(frame, text="Password:").grid(row=2, column=0, sticky="w", pady=(0, 5))
        entry2 = tk.Entry(frame, width=30, show="*")
        entry2.grid(row=3, column=0, pady=(0, 15))

        def submit_login(event=None):
            login_action(entry1.get(), entry2.get())

        login_btn = tk.Button(frame, text="Accedi", width=15, command=submit_login)
        login_btn.grid(row=4, column=0, pady=10)

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

            # Label to display the result
            result_label = tk.Label(op_frame, text="", anchor="w", justify="left", wraplength=600, fg="blue")
            result_label.pack(anchor="w", pady=(5, 0))

            # Execute button
            btn = tk.Button(op_frame, text="Execute",
                            command=partial(self._execute_operation, op, entries, result_label))
            btn.pack(pady=(5, 0))

    def _execute_operation(self, operation: Operation, entries: dict[str, tk.Entry], result_label: tk.Label) -> None:
        args = [entries[field].get().strip() for field in operation.input_fields]
        if any(not arg for arg in args) and operation.input_fields:
            result_label.config(text="⚠️ Per favore, completa tutti i campi richiesti.", fg="orange")
            return
        try:
            result = operation.operation_handler(*args)
            if result is None:
                result_text = "Operazione completata con successo."
            elif isinstance(result, list):
                if len(result) == 0:
                    result_text = "Nessun risultato trovato."
                else:
                    result_text = "\n".join(str(item) for item in result)
            elif isinstance(result, dict):
                result_text = "\n".join(f"{k}: {v}" for k, v in result.items())
            else:
                result_text = str(result)
            result_label.config(text=result_text, fg="white")
        except Exception as e:
            result_label.config(text=f"❌ Errore durante l'esecuzione: {e}", fg="red")

    def _destroy_view(self) -> None:
        self._window.protocol("WM_DELETE_WINDOW", lambda: self.show_login_screen())
        self._window.bind("<Return>", lambda event: None)
        for widget in self._window.winfo_children():
            widget.destroy()

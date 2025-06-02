import tkinter as tk
from functools import partial
from tkinter import Tk, messagebox, ttk
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
        self._build_operation_screen(operations_dic, "Lavoratore")

    def show_admin_screen(self, operations_dic):
        self._build_operation_screen(operations_dic, "Admin")

    def _build_login_screen(self, login_action):
        self._window.geometry("350x220")
        self._window.title("Login")
        self._window.protocol("WM_DELETE_WINDOW", lambda: self.close())

        frame = tk.Frame(self._window, padx=20, pady=20)
        frame.pack(expand=True)

        tk.Label(frame, text="Codice Aziendale:").grid(
            row=0, column=0, sticky="w", pady=(0, 5)
        )
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

    def _build_operation_screen(
        self, operations_list: List[Operation], screen_name: str
    ) -> None:
        self._destroy_view()
        self._window.geometry("500x300")
        self._window.title(f"{screen_name} - Operazioni disponibili")

        main_frame = tk.Frame(self._window, padx=30, pady=30)
        main_frame.pack(fill="both", expand=True)

        tk.Label(
            main_frame, text=f"Benvenuto, {screen_name}!", font=("Arial", 16, "bold")
        ).pack(pady=(0, 20))

        tk.Label(
            main_frame,
            text="Seleziona un'operazione dal menu a tendina:",
            font=("Arial", 12),
        ).pack(anchor="w", pady=(0, 10))

        self._operation_map = {}
        options = []
        for op in operations_list:
            label = f"[ADMIN] {op.desc}" if op.admin_only else op.desc
            options.append(label)
            self._operation_map[label] = op

        selected_op = tk.StringVar(value=options[0])

        combo = ttk.Combobox(
            main_frame,
            textvariable=selected_op,
            values=options,
            state="readonly",
            font=("Arial", 11),
            width=50,
        )
        combo.pack(fill="x", pady=10)

        def open_selected_op():
            op = self._operation_map.get(selected_op.get())
            if op:
                self._open_operation_window(op)

        tk.Button(
            main_frame,
            text="Apri Operazione",
            font=("Arial", 11),
            width=25,
            command=open_selected_op,
        ).pack(pady=20)

    def _open_operation_window(self, operation: Operation) -> None:
        op_window = tk.Toplevel(self._window)
        op_window.title(operation.desc)
        op_window.geometry("600x500")
        op_window.resizable(False, False)

        frame = tk.Frame(op_window, padx=20, pady=20)
        frame.pack(fill=tk.BOTH, expand=True)

        tk.Label(frame, text=operation.desc, font=("Arial", 14)).pack(pady=(0, 10))

        entries = {}
        if operation.input_fields:
            for field in operation.input_fields:
                label = tk.Label(frame, text=field + ":")
                label.pack(anchor="w")
                entry = tk.Entry(frame, width=40)
                entry.pack(fill="x", pady=(0, 10))
                entries[field] = entry
        else:
            tk.Label(frame, text="No input required.").pack(pady=(0, 10))

        result_frame = tk.Frame(frame)
        result_frame.pack(fill="both", expand=True, pady=(10, 0))

        scrollbar = tk.Scrollbar(result_frame)
        result_text = tk.Text(
            result_frame,
            wrap="word",
            height=15,
            width=70,
            yscrollcommand=scrollbar.set,
            state="disabled",
            background="#f0f0f0",
            relief=tk.SUNKEN,
        )
        scrollbar.config(command=result_text.yview)

        result_text.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        execute_btn = tk.Button(
            frame,
            text="Esegui",
            command=partial(self._execute_operation, operation, entries, result_text),
        )
        execute_btn.pack(pady=(10, 0))

        op_window.transient(self._window)
        op_window.grab_set()

    def _execute_operation(
        self, operation: Operation, entries: dict[str, tk.Entry], result_text: tk.Text
    ) -> None:
        args = [entries[field].get().strip() for field in operation.input_fields]
        if any(not arg for arg in args) and operation.input_fields:
            self._set_result_text(
                result_text, "⚠️ Per favore, completa tutti i campi richiesti.", "orange"
            )
            return
        try:
            result = operation.operation_handler(*args)
            if result is None:
                result_str = "✅ Operazione completata con successo."
            elif isinstance(result, list):
                result_str = (
                    "\n".join(str(item) for item in result)
                    if result
                    else "Nessun risultato trovato."
                )
            elif isinstance(result, dict):
                result_str = "\n".join(f"{k}: {v}" for k, v in result.items())
            else:
                result_str = str(result)
            self._set_result_text(result_text, result_str, "black")
        except Exception as e:
            self._set_result_text(
                result_text, f"❌ Errore durante l'esecuzione: {e}", "red"
            )

    def _set_result_text(self, text_widget: tk.Text, message: str, color: str) -> None:
        text_widget.config(state="normal")
        text_widget.delete(1.0, tk.END)
        text_widget.insert(tk.END, message)
        text_widget.tag_configure("color", foreground=color)
        text_widget.tag_add("color", "1.0", "end")
        text_widget.config(state="disabled")

    def _destroy_view(self) -> None:
        self._window.protocol("WM_DELETE_WINDOW", lambda: self.show_login_screen())
        self._window.bind("<Return>", lambda event: None)
        for widget in self._window.winfo_children():
            widget.destroy()

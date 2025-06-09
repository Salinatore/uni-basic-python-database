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

    def show_not_associated_with_group(self):
        messagebox.showerror(
            self.ERROR_TITLE,
            "Il codice aziendale non è associato a nessun gruppo di lavoro",
        )

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

        tk.Label(frame, text="Password:").grid(
            row=2, column=0, sticky="w", pady=(0, 5)
        )
        entry2 = tk.Entry(frame, width=30, show="*")
        entry2.grid(row=3, column=0, pady=(0, 15))

        def submit_login(event=None):
            login_action(entry1.get(), entry2.get())

        login_btn = tk.Button(
            frame, text="Accedi", width=15, command=submit_login
        )
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
            main_frame,
            text=f"Benvenuto, {screen_name}!",
            font=("Arial", 16, "bold"),
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
        op_window.geometry("800x600")
        op_window.resizable(True, True)

        frame = tk.Frame(op_window, padx=20, pady=20)
        frame.pack(fill=tk.BOTH, expand=True)

        tk.Label(frame, text=operation.desc, font=("Arial", 14, "bold")).pack(
            pady=(0, 10)
        )

        entries = {}

        if operation.input_fields:
            for field in operation.input_fields:
                if isinstance(field, str):
                    label = tk.Label(frame, text=field + ":")
                    label.pack(anchor="w")
                    entry = tk.Entry(frame, width=40)
                    entry.pack(fill="x", pady=(0, 10))
                    entries[field] = entry
                elif isinstance(field, dict):
                    field_name = field.get("name", "Field")
                    field_type = field.get("type", "text")

                    label = tk.Label(frame, text=field_name + ":")
                    label.pack(anchor="w")

                    if field_type == "dropdown":
                        combo = ttk.Combobox(
                            frame,
                            values=field.get("options", []),
                            state="readonly",
                            width=38,
                            font=("Arial", 11),
                        )
                        combo.pack(fill="x", pady=(0, 10))
                        entries[field_name] = combo

                    elif field_type == "checkbox":
                        var = tk.BooleanVar()
                        check = tk.Checkbutton(frame, variable=var)
                        check.pack(anchor="w", pady=(0, 10))
                        entries[field_name] = var

                    else:
                        entry = tk.Entry(frame, width=40)
                        entry.pack(fill="x", pady=(0, 10))
                        entries[field_name] = entry
        else:
            tk.Label(frame, text="Nessun input richiesto.").pack(pady=(0, 10))

        # Result area frame
        result_frame = tk.Frame(frame)
        result_frame.pack(fill="both", expand=True, pady=(10, 0))

        # Text area for messages
        scrollbar = tk.Scrollbar(result_frame)
        result_text = tk.Text(
            result_frame,
            wrap="word",
            height=5,
            width=70,
            yscrollcommand=scrollbar.set,
            state="disabled",
            background="#f0f0f0",
            relief=tk.SUNKEN,
        )
        scrollbar.config(command=result_text.yview)
        result_text.pack(side="top", fill="x", expand=False)
        scrollbar.pack(side="right", fill="y")

        # Table for list[dict[str, Any]]
        tree = ttk.Treeview(result_frame, show="headings")
        tree.pack(fill="both", expand=True, pady=(10, 0))

        # Execute button
        execute_btn = tk.Button(
            frame,
            text="Esegui",
            command=partial(
                self._execute_operation, operation, entries, result_text, tree
            ),
        )
        execute_btn.pack(pady=(10, 0))

        op_window.transient(self._window)
        op_window.grab_set()

    def _execute_operation(
        self,
        operation: Operation,
        entries: dict[str, tk.Entry],
        result_text: tk.Text,
        tree: ttk.Treeview,
    ) -> None:
        self._clear_result_widgets(result_text, tree)

        args = [
            entries[field].get().strip() for field in operation.input_fields
        ]
        if any(not arg for arg in args) and operation.input_fields:
            self._set_result_text(
                result_text,
                "⚠️ Per favore, completa tutti i campi richiesti.",
                "orange",
            )
            return

        try:
            result = operation.operation_handler(*args)

            if result is None:
                self._set_result_text(
                    result_text,
                    "✅ Operazione completata con successo.",
                    "green",
                )

            elif isinstance(result, list) and all(
                isinstance(d, dict) for d in result
            ):
                if not result:
                    self._set_result_text(
                        result_text, "ℹ️ Nessun risultato trovato.", "blue"
                    )
                else:
                    self._populate_table(tree, result)

            else:
                self._set_result_text(result_text, str(result), "black")

        except Exception as e:
            self._set_result_text(
                result_text, f"❌ Errore durante l'esecuzione: {e}", "red"
            )

    def _set_result_text(
        self, text_widget: tk.Text, message: str, color: str
    ) -> None:
        text_widget.config(state="normal")
        text_widget.delete(1.0, tk.END)
        text_widget.insert(tk.END, message)
        text_widget.tag_configure("color", foreground=color)
        text_widget.tag_add("color", "1.0", "end")
        text_widget.config(state="disabled")

    def _clear_result_widgets(
        self, text_widget: tk.Text, tree_widget: ttk.Treeview
    ):
        text_widget.config(state="normal")
        text_widget.delete("1.0", tk.END)
        text_widget.config(state="disabled")
        tree_widget.delete(*tree_widget.get_children())
        tree_widget["columns"] = []

    def _populate_table(self, tree: ttk.Treeview, data: list[dict]):
        columns = list(data[0].keys())
        tree["columns"] = columns

        for col in columns:
            tree.heading(col, text=col)
            tree.column(col, anchor="center")

        for row in data:
            values = [str(row.get(col, "")) for col in columns]
            tree.insert("", "end", values=values)

    def _destroy_view(self) -> None:
        self._window.protocol(
            "WM_DELETE_WINDOW", lambda: self.show_login_screen()
        )
        self._window.bind("<Return>", lambda event: None)
        for widget in self._window.winfo_children():
            widget.destroy()

#!/usr/bin/env python3.11

import tkinter as tk
from tkinter import ttk
from sympy import symbols, Eq, solve
import random
import os
import string
import math

class AlgebraicExerciseGenerator:
    def __init__(self):
        self.generated_equations = set()

    def generate_linear_equation(self):
        a = random.randint(-10, 10)
        while a == 0:
            a = random.randint(-10, 10)
        b = random.randint(-10, 10)
        c = random.randint(-20, 20)
        x_value = random.randint(-10, 10)
        equation = f"{a}x + {b} = {c}"
        return equation, {'x': x_value, 'a': a, 'b': b, 'c': c}

    def generate_quadratic_equation(self):
        a = random.randint(1, 10)
        b = random.randint(-10, 10)
        c = random.randint(-20, 20)
        x_value = random.randint(-10, 10)
        equation = f"{a}x² + {b}x + {c} = 0"
        return equation, {'x': x_value, 'a': a, 'b': b, 'c': c}

    def generate_cubic_equation(self):
        a = random.randint(1, 5)
        b = random.randint(-5, 5)
        c = random.randint(-5, 5)
        d = random.randint(-10, 10)
        x_value = random.randint(-10, 10)
        equation = f"{a}x³ + {b}x² + {c}x + {d} = 0"
        return equation, {'x': x_value, 'a': a, 'b': b, 'c': c, 'd': d}

    def generate_rational_equation(self):
        a = random.randint(-10, 10)
        while a == 0:
            a = random.randint(-10, 10)
        b = random.randint(-10, 10)
        c = random.randint(-10, 10)
        while c == 0:
            c = random.randint(-10, 10)
        d = random.randint(-10, 10)
        x_value = random.randint(-10, 10)
        equation = f"({a}x + {b}) / ({c}x + {d}) = 0"
        return equation, {'x': x_value, 'a': a, 'b': b, 'c': c, 'd': d}

    def generate_irrational_equation(self):
        a = random.randint(1, 10)
        b = random.randint(-10, 10)
        c = random.randint(1, 10)
        x_value = random.randint(-10, 10)
        equation = f"√({a}x + {b}) = {c}"
        return equation, {'x': x_value, 'a': a, 'b': b, 'c': c}

    def generate_exponential_equation(self):
        a = random.randint(-10, 10)
        b = random.randint(-10, 10)
        c = random.randint(-10, 10)
        x_value = random.randint(-10, 10)
        equation = f"{a} * exp({b}x) = {c}"
        return equation, {'x': x_value, 'a': a, 'b': b, 'c': c}

    def generate_logarithmic_equation(self):
        a = random.randint(2, 10)
        b = random.randint(1, 10)
        c = random.randint(-10, 10)
        while c == 0:
            c = random.randint(-10, 10)
        d = random.randint(-10, 10)
        x_value = random.randint(-10, 10)
        equation = f"log_{a}({b}x + {c}) = {d}"
        return equation, {'x': x_value, 'a': a, 'b': b, 'c': c, 'd': d}

    def generate_trigonometric_equation(self):
        a = random.randint(1, 3)
        b = random.randint(-1, 1)
        x_value = random.randint(-10, 10)
        equation = f"sin({a}x) = {b}"
        return equation, {'x': x_value, 'a': a, 'b': b}

    def generate_choices(self, equation, correct_x_value):
        choices = []
        correct_choice = correct_x_value
        options = ['A', 'B', 'C', 'D']
        random.shuffle(options)
        distractors = []
        while len(distractors) < 3:
            random_change = random.randint(-5, 5)
            while random_change == 0:
                random_change = random.randint(-5, 5)

            distractor_x_value = correct_x_value + random_change
            if distractor_x_value not in distractors:
                distractors.append(distractor_x_value)
        all_choices = [correct_choice] + distractors
        random.shuffle(all_choices)

        return all_choices

class EmmyApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Emmy - Generador de Ecuaciones")
        self.algebraic_generator = AlgebraicExerciseGenerator()
        self.selected_equation_types = [] 
        self.create_ui()

    def create_ui(self):
        style = ttk.Style()
        style.configure('TButton', padding=(10, 5), font=('Helvetica', 12))
        style.configure('TLabel', font=('Helvetica', 12))
        style.configure('TCheckbutton', font=('Helvetica', 12))

        ttk.Label(self.root, text="Número de Preguntas:", style='TLabel').grid(row=0, column=0)
        self.num_questions = ttk.Entry(self.root, font=('Helvetica', 12))
        self.num_questions.grid(row=0, column=1)

        ttk.Label(self.root, text="Tipos de Ecuaciones:", style='TLabel').grid(row=1, column=0)

        self.linear_var = tk.IntVar()
        self.linear_check = ttk.Checkbutton(self.root, text="Lineal", variable=self.linear_var, style='TCheckbutton')
        self.linear_check.grid(row=1, column=1)

        self.quadratic_var = tk.IntVar()
        self.quadratic_check = ttk.Checkbutton(self.root, text="Cuadrática", variable=self.quadratic_var, style='TCheckbutton')
        self.quadratic_check.grid(row=2, column=1)

        self.cubic_var = tk.IntVar()
        self.cubic_check = ttk.Checkbutton(self.root, text="Cúbica", variable=self.cubic_var, style='TCheckbutton')
        self.cubic_check.grid(row=3, column=1)

        self.rational_var = tk.IntVar()
        self.rational_check = ttk.Checkbutton(self.root, text="Racional", variable=self.rational_var, style='TCheckbutton')
        self.rational_check.grid(row=4, column=1)

        self.irrational_var = tk.IntVar()
        self.irrational_check = ttk.Checkbutton(self.root, text="Irracional", variable=self.irrational_var, style='TCheckbutton')
        self.irrational_check.grid(row=5, column=1)

        self.exponential_var = tk.IntVar()
        self.exponential_check = ttk.Checkbutton(self.root, text="Exponencial", variable=self.exponential_var, style='TCheckbutton')
        self.exponential_check.grid(row=6, column=1)

        self.logarithmic_var = tk.IntVar()
        self.logarithmic_check = ttk.Checkbutton(self.root, text="Logarítmica", variable=self.logarithmic_var, style='TCheckbutton')
        self.logarithmic_check.grid(row=7, column=1)

        self.trigonometric_var = tk.IntVar()
        self.trigonometric_check = ttk.Checkbutton(self.root, text="Trigonométrica", variable=self.trigonometric_var, style='TCheckbutton')
        self.trigonometric_check.grid(row=8, column=1)

        ttk.Button(self.root, text="Generar Ecuaciones", command=self.generate_equations, style='TButton').grid(row=9, column=0, columnspan=2)

        self.output_text = tk.Text(self.root, wrap=tk.WORD, width=80, height=20, font=('Helvetica', 12))
        self.output_text.grid(row=10, column=0, columnspan=2)

    def show_message(self, message, clear_input=False):
        self.output_text.delete(1.0, tk.END)
        self.output_text.insert(tk.END, message)

        if clear_input:
            self.num_questions.delete(0, tk.END)

    def validate_inputs(self):
        try:
            num_questions = int(self.num_questions.get())

            if num_questions <= 0:
                raise ValueError("El número de preguntas debe ser mayor que cero.")

            selected_equation_types = []
            if self.linear_var.get():
                selected_equation_types.append("Lineal")
            if self.quadratic_var.get():
                selected_equation_types.append("Cuadrática")
            if self.cubic_var.get():
                selected_equation_types.append("Cúbica")
            if self.rational_var.get():
                selected_equation_types.append("Racional")
            if self.irrational_var.get():
                selected_equation_types.append("Irracional")
            if self.exponential_var.get():
                selected_equation_types.append("Exponencial")
            if self.logarithmic_var.get():
                selected_equation_types.append("Logarítmica")
            if self.trigonometric_var.get():
                selected_equation_types.append("Trigonométrica")

            if not selected_equation_types:
                raise ValueError("Debes seleccionar al menos un tipo de ecuación.")

            return num_questions, selected_equation_types

        except ValueError as e:
            self.show_message(f"Error: {str(e)}", clear_input=True)
            return None

    def generate_equations(self):
        inputs = self.validate_inputs()

        if inputs:
            num_questions, selected_equation_types = inputs

            script_directory = os.path.dirname(os.path.abspath(__file__))

            exercises = []

        for question_number in range(1, num_questions + 1):
            equation = ""
            variables = {}

            selected_type = random.choice(selected_equation_types)

            if selected_type == "Lineal":
                equation, variables = self.algebraic_generator.generate_linear_equation()
            elif selected_type == "Cuadrática":
                equation, variables = self.algebraic_generator.generate_quadratic_equation()
            elif selected_type == "Cúbica":
                equation, variables = self.algebraic_generator.generate_cubic_equation()
            elif selected_type == "Racional":
                equation, variables = self.algebraic_generator.generate_rational_equation()
            elif selected_type == "Irracional":
                equation, variables = self.algebraic_generator.generate_irrational_equation()
            elif selected_type == "Exponencial":
                equation, variables = self.algebraic_generator.generate_exponential_equation()
            elif selected_type == "Logarítmica":
                equation, variables = self.algebraic_generator.generate_logarithmic_equation()
            elif selected_type == "Trigonométrica":
                equation, variables = self.algebraic_generator.generate_trigonometric_equation()

            # Extract the correct 'x' value
            correct_x_value = variables['x']

            formatted_choices = []

            choices = self.algebraic_generator.generate_choices(equation, correct_x_value)

            for i, choice in enumerate(choices):
                formatted_choice = f"{chr(65 + i)}) x = {choice}"
                formatted_choices.append(formatted_choice)

            exercises.append(f"{question_number}. {equation}")
            exercises.extend(formatted_choices)
            exercises.append("")

            output_file = os.path.join(script_directory, "Ecuaciones.txt")

            with open(output_file, "w") as file:
                file.write("\n".join(map(str, exercises)))

            self.show_message(f"Ecuaciones generadas y guardadas en 'Ecuaciones.txt'.", clear_input=True)

if __name__ == "__main__":
    root = tk.Tk()
    app = EmmyApp(root)
    root.mainloop()

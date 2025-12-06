import os
from pyswip import Prolog

class CursosRepository:
    def __init__(self):
        self.prolog = Prolog()

        base_path = os.path.dirname(os.path.abspath(__file__))  
        prolog_file = os.path.join(base_path, "../../data/prolog/cursos.pl")
        # Normalizar la ruta
        prolog_file = os.path.normpath(prolog_file)

        # Cargar archivo de Prolog
        self.prolog.consult(prolog_file)
    
    def obtener_todos_los_cursos(self):
        """Retorna todos los cursos como lista de dict."""
        result = list(self.prolog.query(
            "curso(Nombre, Codigo, Creditos, Requisitos, Area, Nivel)"
        ))

        cursos = []
        for c in result:
            cursos.append({
                "nombre": c["Nombre"],
                "codigo": c["Codigo"],
                "creditos": c["Creditos"],
                "requisitos": list(c["Requisitos"]),
                "area": c["Area"],
                "nivel": c["Nivel"]
            })
        return cursos
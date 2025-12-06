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
    
    def obtener_cursos_disponibles(self, aprobados):
        """Retorna cursos disponibles con base en el historial como lista de dict."""
        aprobados_prolog = "[" + ",".join([f"'{c}'" for c in aprobados]) + "]"

        query = f"puede_matricular(Codigo, {aprobados_prolog})"
        result = list(self.prolog.query(query))
       
        cursos_disponibles = []
        for r in result:
            codigo = r["Codigo"]

            # Consultamos todos los detalles del curso
            detalle = list(self.prolog.query(
                f"curso(Nombre, '{codigo}', Creditos, Requisitos, Area, Nivel)"
            ))[0]

            cursos_disponibles.append({
                "nombre": detalle["Nombre"],
                "codigo": codigo,
                "creditos": detalle["Creditos"],
                "requisitos": list(detalle["Requisitos"]),
                "area": detalle["Area"],
                "nivel": detalle["Nivel"]
            })

        return cursos_disponibles
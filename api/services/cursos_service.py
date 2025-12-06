from repo.cursos_repository import CursosRepository


class CursosService:
            
        def __init__(self):
            self.user_repo = CursosRepository()

        def list_cursos(self):
            return self.user_repo.obtener_todos_los_cursos()
        
        def cursos_disponibles(self):
            return self.user_repo.obtener_cursos_disponibles()
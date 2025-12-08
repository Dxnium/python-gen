from repo.user_repository import UserRepository
from repo.historial_repository import HistorialRepository
from repo.cursos_repository import CursosRepository
from models.user import User
from typing import List

class UserService:

    def __init__(self):
        self.user_repo = UserRepository()
        self.historial_repo = HistorialRepository()
        self.cursos_repo = CursosRepository()

    def list_users(self) -> List[User]:
        return self.user_repo.get_all()
    
    def create_user(self, nombre: str, email: str, password: str) -> User:
        return self.user_repo.create(nombre, email, password)

    def add_historial(self, user_id: str, codigo_curso: str):
        user = self.user_repo.get_by_id(user_id)
        if not user:
            return None

        h = self.historial_repo.create(codigo_curso)
        user.historial.append(h)
        user.save()

        return h

    def get_user_with_historial(self, user_id: str):
        return self.user_repo.get_by_id(user_id)
    
    def clear_historial(self, user_id: str) -> bool:
        user = self.user_repo.get_by_id(user_id)
        if not user:
            return False

        user.historial = []
        user.save()
        return True
    
    def cursos_disponibles(self, aprobados: List[str]):
        return self.cursos_repo.obtener_cursos_disponibles(aprobados)
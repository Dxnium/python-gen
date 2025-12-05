from models.user import User
from typing import List, Optional

class UserRepository:

    def create(self, nombre: str, email: str, password: str) -> User:
        user = User(nombre=nombre, email=email, contrasena=password)
        user.save()
        return user

    def get_by_id(self, user_id: str) -> Optional[User]:
        return User.objects(id=user_id).first()

    def get_all(self) -> List[User]:
        return list(User.objects)

    def delete(self, user_id: str) -> bool:
        user = User.objects(id=user_id).first()
        if not user:
            return False
        user.delete()
        return True

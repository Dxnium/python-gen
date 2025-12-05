from fastapi import APIRouter, HTTPException
from services.user_service import UserService

router = APIRouter(prefix="/users", tags=["Users"])
service = UserService()

@router.post("/")
def create_user(nombre: str, email: str, password: str):
    return service.create_user(nombre, email, password).to_json()

@router.post("/{user_id}/historial")
def add_historial(user_id: str, codigo_curso: str):
    h = service.add_historial(user_id, codigo_curso)
    if not h:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    return {
        "curso": h.codigo_curso
    }

@router.get("/{user_id}")
def get_user(user_id: str):
    user = service.get_user_with_historial(user_id)
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    return {
        "id": str(user.id),
        "nombre": user.nombre,
        "historial": [
            {"id": str(h.id), "curso": h.codigo_curso}
            for h in user.historial
        ]
    }

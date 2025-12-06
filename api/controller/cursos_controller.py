from fastapi import APIRouter, HTTPException
from services.cursos_service import CursosService

router = APIRouter(prefix="/cursos", tags=["cursos"])
service = CursosService()

@router.get("/")
def list_cursos():
    cursos = service.list_cursos()
    return cursos

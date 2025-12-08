from fastapi import APIRouter, HTTPException
from services.cursos_service import CursosService
from services.gemini_service import GeminiService


router = APIRouter(prefix="/cursos", tags=["cursos"])
service = CursosService()
ai_service = GeminiService()

@router.get("/")
def list_cursos():
    cursos = service.list_cursos()
    return cursos

@router.get("/recomendacion")
def get_recomendacion_ai(nombre_curso: str, area: str, creditos: int):
    explicacion_ia = ai_service.generar_explicacion_ia(
        nombre_curso=nombre_curso,
        area=area,
        creditos=creditos
    )
    return {
        "explicacion_ia": explicacion_ia
    }
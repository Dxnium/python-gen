from fastapi import FastAPI
from db.mongo_connection import init_db
from controller.user_controller import router as user_router
from controller.cursos_controller import router as cursos_router


from models.user import User
from models.historial import HistorialAcademico
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


init_db()
app.include_router(user_router)
app.include_router(cursos_router)

@app.get("/")
def root():
    return {"message": "MongoEngine API running"}

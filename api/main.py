from fastapi import FastAPI
from db.mongo_connection import init_db
from controller.user_controller import router as user_router

from models.user import User
from models.historial import HistorialAcademico

app = FastAPI()
init_db()

app.include_router(user_router)

@app.get("/")
def root():
    return {"message": "MongoEngine API running"}

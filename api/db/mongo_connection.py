from mongoengine import connect

MONGODB_URL = "mongodb://localhost:27017/mongo_db"

def init_db():
    connect(host=MONGODB_URL)

    from models.user import User
    from models.historial import HistorialAcademico

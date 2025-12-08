from mongoengine import Document, StringField, EmbeddedDocumentListField
from .historial import HistorialAcademico

class User(Document):
    nombre = StringField(required=True, max_length=120)
    email = StringField(required=True, unique=True)
    contrasena = StringField(required=True)
    
    meta = {
        "collection": "users"
    }

    historial = EmbeddedDocumentListField(HistorialAcademico)

    def to_json(self):
        return {
            "id": str(self.id),
            "nombre": self.nombre,
            "email": self.email,
            "historial": [
                {
                    "id": str(h.id),
                    "codigo_curso": h.codigo_curso
                }
                for h in self.historial
            ]
        }


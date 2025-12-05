from mongoengine import Document, StringField, ListField, ObjectIdField, ReferenceField, EmbeddedDocumentListField
from .historial import HistorialAcademico

class User(Document):
    nombre = StringField(required=True, max_length=120)
    email = StringField(required=True, unique=True)
    contrasena = StringField(required=True)
    
    meta = {
        "collection": "users"
    }

    historial = EmbeddedDocumentListField(HistorialAcademico)


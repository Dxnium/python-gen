from mongoengine import StringField, EmbeddedDocument

class HistorialAcademico(EmbeddedDocument):
    meta = {"collection": "historial_academico"}

    codigo_curso = StringField(required=True)

from models.historial import HistorialAcademico

class HistorialRepository:

    def create(self, codigo_curso: str):
        h = HistorialAcademico(
            codigo_curso=codigo_curso
        )
        return h

    def get_by_user(self, user):
        return list(HistorialAcademico.objects(propietario=user))

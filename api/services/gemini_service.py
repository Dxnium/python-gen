import os
from google import genai

class GeminiService:
    def __init__(self):
        api_key = os.getenv("GEMINI_API_KEY")
        self.client = genai.Client(api_key=api_key)

    def generar_explicacion_ia(self, nombre_curso: str, area: str, creditos: int) -> str:
        prompt = (
            f"Actúa como un orientador académico universitario motivador. "
            f"El estudiante es elegible para el curso '{nombre_curso}' ({area}, {creditos} créditos). "
            f"Genera una explicación concisa y entusiasta (máximo 40 palabras) "
            f"sobre por qué este curso es crucial, qué habilidades desarrollará y cómo se conecta con una especialización."
        )   
        
        try:
            response = self.client.models.generate_content(
                model='gemini-2.5-flash',
                contents=prompt
            )
            return response.text
        except Exception as e:
            return f"Error al generar explicación con IA: {e}"
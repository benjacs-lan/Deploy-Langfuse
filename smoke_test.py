import os
import sys

# 1. Configuración de llaves (Usando variables de entorno que el SDK detecta automáticamente)
os.environ["LANGFUSE_PUBLIC_KEY"] = "pk-lf-7d9495a4-653a-4777-9dae-6275bff17bf6"
os.environ["LANGFUSE_SECRET_KEY"] = "sk-lf-bb24e0da-d7e5-4c99-bb5f-d7e303f43a11"
os.environ["LANGFUSE_HOST"] = "http://localhost:3000"

try:
    from langfuse.decorators import observe, langfuse_context
except ImportError:
    print("❌ Error: No se encuentra 'langfuse.decorators'.")
    print("Ejecuta: ./venv/bin/pip install 'langfuse<3.0.0'")
    sys.exit(1)

# 2. Definimos una "generación"
@observe(as_type="generation")
def simular_respuesta_llm(pregunta: str):
    print(f"🤖 LLM procesando: '{pregunta}'")
    return "¡Conexión exitosa con LocalStack y Terraform!"

# 3. Rastro principal
@observe()
def ejecutar_prueba():
    print("🚀 Iniciando rastro en Langfuse...")
    respuesta = simular_respuesta_llm("¿Estado del despliegue?")
    print(f"📝 Resultado: {respuesta}")

if __name__ == "__main__":
    if "pk-lf-..." in os.environ["LANGFUSE_PUBLIC_KEY"]:
        print("⚠️  AVISO: Primero debes poner tus llaves reales en el script.")
        print("Búscalas en http://localhost:3000 -> Settings -> API Keys")
    else:
        ejecutar_prueba()
        langfuse_context.flush()
        print("\n✅ ¡Trace enviado! Revísalo en http://localhost:3000")
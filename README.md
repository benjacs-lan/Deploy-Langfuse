#  Langfuse + AWS LocalStack (Observabilidad LLM con IaC)

Este proyecto despliega un entorno de **observabilidad para modelos de lenguaje (LLM)** utilizando **Langfuse**, simulando una infraestructura de nube real de AWS de forma local.

---

##  ¿Por qué esta Arquitectura?

El objetivo de este proyecto es demostrar cómo utilizar monitoreo combinando DevOps e MLops.

### Problemas que resuelve:
1.  **Costos en la Nube:** Al usar **LocalStack**, simulamos servicios de AWS (S3, IAM) localmente sin gastar un centavo en infraestructura real durante el desarrollo.
2.  **Infraestructura como Código (IaC):** Usamos **Terraform** para definir los recursos, asegurando que el entorno sea idéntico cada vez que se despliega.
3.  **Caja Negra de los LLM:** **Langfuse** permite trazar, evaluar y debugear cada interacción con modelos de IA, algo crítico para aplicaciones en producción.

---

## 🛠️ Recursos Utilizados

### 1. **Langfuse (Self-Hosted)**
-   **Propósito:** Dashboard de observabilidad.
-   **¿Por qué?:** Centraliza todos los logs, costos y métricas de calidad de nuestras llamadas a IA.

### 2. **LocalStack (AWS Simulado)**
-   **Propósito:** Emular S3 e IAM.
-   **¿Por qué?:** Permite que la aplicación "crea" que está en AWS. Probamos la lógica de almacenamiento y permisos sin necesidad de internet o una tarjeta de crédito.

### 3. **Terraform (con tflocal)**
-   **Recursos creados:** Bucket S3 y Roles de IAM.
-   **¿Por qué?:** Automatiza la creación del bucket donde Langfuse guarda datos pesados. Es la forma estándar en la industria de manejar servidores y servicios.

### 4. **PostgreSQL 15**
-   **Propósito:** Base de datos persistente.
-   **¿Por qué?:** Almacena la configuración, usuarios y metadatos de los rastreos de Langfuse.

---

## Cómo Ejecutar el Proyecto

### Requisitos:
-   Docker y Docker Compose.
-   Python 3 (preferiblemente en un venv).
-   `terraform` y `tflocal` (wrapper para LocalStack).

### Pasos:
1.  **Levantar Contenedores:**
    ```bash
    docker compose up -d
    ```
2.  **Desplegar Infraestructura AWS (Terraform):**
    ```bash
    make init
    make apply
    ```
3.  **Probar el Sistema:**
    ```bash
    # Ejecuta el script de prueba para mandar tu primer trace
    python smoke_test.py
    ```

---

## 📊 Comandos de Verificación
-   `make status`: Muestra los recursos creados en el AWS local.
-   `make logs`: Revisa qué está pasando en los servidores.
-   **Dashboard:** [http://localhost:3000](http://localhost:3000)

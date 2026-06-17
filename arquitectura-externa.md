# Arquitectura Externa - EcoBuddy

## 1. Decisión arquitectónica

La arquitectura externa seleccionada para EcoBuddy es:

```txt
Cliente-Servidor
```

EcoBuddy tendrá una aplicación móvil desarrollada en Flutter que actuará como cliente, mientras que el backend en NestJS actuará como servidor central encargado de procesar la lógica de negocio, persistir datos, comunicarse con Groq y exponer servicios mediante una API REST.

## 2. Justificación

La arquitectura Cliente-Servidor es la más adecuada porque EcoBuddy necesita separar claramente la experiencia del usuario móvil de la lógica central del sistema.

La app Flutter se encargará de:

- Mostrar la interfaz de usuario.
- Gestionar pantallas, formularios y estado visual.
- Consumir los endpoints del backend.
- Mostrar respuestas del asistente conversacional.
- Mostrar misiones, puntos, hábitos y recompensas.

El backend NestJS se encargará de:

- Autenticación y autorización.
- Gestión de usuarios y familias.
- Procesamiento de consultas al asistente IA.
- Integración con Groq API.
- Clasificación de residuos.
- Generación de misiones domésticas.
- Registro de hábitos sostenibles.
- Gestión de puntos, créditos y recompensas.
- Persistencia en PostgreSQL.
- Manejo de eventos internos de gamificación.

## 3. Vista general

```txt
┌────────────────────────────────┐
│        App Mobile Flutter       │
│--------------------------------│
│ UI                             │
│ Estado                         │
│ Consumo de API                 │
│ Validaciones básicas           │
└───────────────┬────────────────┘
                │ HTTPS / REST API
                ↓
┌────────────────────────────────┐
│        Backend NestJS           │
│--------------------------------│
│ Auth                           │
│ Usuarios                       │
│ Familias                       │
│ IA / Groq                      │
│ Residuos                       │
│ Misiones                       │
│ Hábitos                        │
│ Puntos                         │
│ Recompensas                    │
└───────┬─────────────┬──────────┘
        │             │
        ↓             ↓
┌──────────────┐   ┌──────────────┐
│ PostgreSQL   │   │  Groq API     │
└──────────────┘   └──────────────┘
        │
        ↓
┌──────────────┐
│ Redis        │
└──────────────┘
```

## 4. Componentes externos

### 4.1 Flutter Mobile

Es el cliente principal del sistema. Será usado por los miembros del hogar para consultar dudas de reciclaje, completar misiones, registrar hábitos, revisar puntos y canjear recompensas.

### 4.2 Backend NestJS

Es el servidor principal. Centraliza la lógica del sistema para evitar que reglas importantes queden dentro del cliente móvil.

### 4.3 PostgreSQL

Base de datos relacional principal. Almacenará usuarios, familias, residuos consultados, historial de conversaciones, misiones, hábitos, puntos, créditos y recompensas.

### 4.4 Redis

Se usará para cache, control de sesiones temporales, rate limiting o colas ligeras si el sistema lo requiere.

### 4.5 Groq API

Servicio externo de IA usado para procesar preguntas del usuario y generar respuestas rápidas sobre clasificación de residuos.

## 5. Flujo principal

```txt
Usuario pregunta por un residuo
        ↓
Flutter envía consulta al backend
        ↓
NestJS valida usuario y consulta
        ↓
NestJS envía pregunta a Groq
        ↓
Groq devuelve respuesta
        ↓
Backend interpreta respuesta
        ↓
Backend crea misión relacionada
        ↓
Backend guarda historial y misión
        ↓
Flutter muestra respuesta y misión
```

## 6. Ventajas para EcoBuddy

- Separa responsabilidades entre cliente y servidor.
- Permite mantener segura la API key de Groq en el backend.
- Evita duplicar reglas de negocio en la app móvil.
- Facilita el mantenimiento del sistema.
- Permite escalar el backend sin modificar la app Flutter.
- Facilita agregar futuras plataformas, como una web administrativa.

## 7. Por qué no usar microservicios al inicio

No se recomienda usar microservicios en la primera versión porque EcoBuddy todavía no requiere separar cada dominio en servicios desplegables de forma independiente. Para este proyecto, un backend NestJS modular es suficiente y más realista.

Los microservicios agregarían complejidad en:

- Comunicación entre servicios.
- Despliegue.
- Monitoreo.
- Manejo de errores distribuidos.
- Bases de datos por servicio.
- Configuración de infraestructura.

## 8. Conclusión

La arquitectura externa de EcoBuddy será Cliente-Servidor, porque permite que Flutter se concentre en la experiencia móvil y NestJS concentre la lógica de negocio, la IA, la persistencia y la gamificación.

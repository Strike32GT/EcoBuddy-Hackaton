# Arquitectura Interna - EcoBuddy

## 1. Decisión arquitectónica

La arquitectura interna seleccionada para EcoBuddy es:

```txt
Monolito Modular + Arquitectura Hexagonal
```

Esta decisión permite construir un backend ordenado, mantenible y escalable sin caer en la complejidad de microservicios desde la primera versión.

## 2. Justificación

EcoBuddy tendrá varios dominios funcionales:

- Autenticación.
- Usuarios.
- Familias.
- Asistente IA.
- Clasificación de residuos.
- Misiones.
- Hábitos.
- Puntos.
- Recompensas.
- Notificaciones.
- Analítica ambiental.

Cada dominio debe estar separado en módulos, pero todos pueden vivir dentro de una misma aplicación NestJS. Por eso se recomienda un monolito modular.

La arquitectura hexagonal se usa para separar la lógica de negocio de tecnologías externas como Prisma, PostgreSQL, Redis, Groq API o servicios de notificación.

## 3. Capas internas

```txt
Presentation Layer
        ↓
Application Layer
        ↓
Domain Layer
        ↓
Infrastructure Layer
```

## 4. Responsabilidad de cada capa

### 4.1 Presentation Layer

Contiene los elementos que reciben o devuelven información al exterior.

Incluye:

- Controllers.
- DTOs.
- Validaciones de entrada.
- Guards.
- Decorators.
- Respuestas HTTP.

Ejemplo:

```txt
AiAssistantController
MissionsController
RewardsController
```

### 4.2 Application Layer

Contiene los casos de uso de la aplicación. Coordina la ejecución de acciones, pero no debe tener detalles técnicos de base de datos o APIs externas.

Incluye:

- Use cases.
- Application services.
- Coordinadores de flujo.

Ejemplo:

```txt
ResolveWasteQuestionUseCase
CreateMissionUseCase
CompleteMissionUseCase
RedeemRewardUseCase
```

### 4.3 Domain Layer

Contiene la lógica más importante del negocio. No debe depender de NestJS, Prisma, PostgreSQL ni Groq.

Incluye:

- Entidades.
- Value Objects.
- Domain Services.
- Repository Ports.
- Reglas de negocio.

Ejemplo:

```txt
Mission
Reward
EcoPoints
WasteClassification
MissionStatus
```

### 4.4 Infrastructure Layer

Contiene las implementaciones técnicas. Aquí se conectan las herramientas externas.

Incluye:

- Repositorios Prisma.
- Adaptadores de Groq.
- Adaptadores de Redis.
- Servicios de notificación.
- Mappers.

Ejemplo:

```txt
PrismaMissionRepository
GroqAiAdapter
RedisCacheAdapter
```

## 5. Flujo interno recomendado

```txt
HTTP Request
   ↓
Controller
   ↓
Use Case
   ↓
Domain Service / Entity
   ↓
Repository Port
   ↓
Infrastructure Adapter
   ↓
Database / External API
```

## 6. Ejemplo aplicado: consulta de residuo

```txt
Usuario pregunta: ¿Dónde boto una botella de plástico?
        ↓
AiAssistantController
        ↓
ResolveWasteQuestionUseCase
        ↓
WasteClassificationDomainService
        ↓
AiAssistantPort
        ↓
GroqAiAdapter
        ↓
Groq API
        ↓
Respuesta clasificada
        ↓
CreateMissionUseCase
        ↓
MissionRepositoryPort
        ↓
PrismaMissionRepository
        ↓
PostgreSQL
```

## 7. Módulos principales

```txt
backend/src/modules/
├── auth/
├── users/
├── families/
├── ai-assistant/
├── waste-classification/
├── missions/
├── habits/
├── points/
├── rewards/
├── notifications/
└── analytics/
```

## 8. Estructura recomendada por módulo

Ejemplo con el módulo `missions`:

```txt
missions/
├── application/
│   ├── usecases/
│   │   ├── create-mission.usecase.ts
│   │   ├── complete-mission.usecase.ts
│   │   └── get-user-missions.usecase.ts
│   └── services/
│
├── domain/
│   ├── entities/
│   │   └── mission.entity.ts
│   ├── repositories/
│   │   └── mission.repository.port.ts
│   ├── services/
│   │   └── mission-domain.service.ts
│   └── value-objects/
│       └── mission-status.vo.ts
│
├── infrastructure/
│   ├── persistence/
│   │   └── prisma-mission.repository.ts
│   └── mappers/
│       └── mission.mapper.ts
│
└── presentation/
    ├── controllers/
    │   └── missions.controller.ts
    └── dto/
        ├── create-mission.dto.ts
        └── complete-mission.dto.ts
```

## 9. Eventos internos

EcoBuddy puede usar eventos internos para desacoplar la gamificación.

Ejemplos:

```txt
WasteQuestionResolvedEvent
MissionCreatedEvent
MissionCompletedEvent
PointsEarnedEvent
RewardUnlockedEvent
```

Ejemplo de flujo:

```txt
Usuario completa misión
        ↓
MissionCompletedEvent
        ↓
PointsService suma puntos
        ↓
RewardsService revisa recompensas disponibles
        ↓
NotificationService genera aviso
```

## 10. Conclusión

La arquitectura interna de EcoBuddy debe ser un monolito modular con enfoque hexagonal. Esta estructura permite mantener el proyecto claro, separar responsabilidades y facilitar cambios futuros sin sobredimensionar la solución.

# Patrón de Diseño Backend - EcoBuddy

## 1. Decisión

Para el backend de EcoBuddy se usará:

```txt
Modular Architecture + Hexagonal Architecture + Repository Pattern + Adapter Pattern + Use Case Pattern
```

El backend estará desarrollado en NestJS y organizado como un monolito modular.

## 2. Patrón principal

El patrón principal será:

```txt
Arquitectura Hexagonal / Ports and Adapters
```

Esto permite separar el núcleo de negocio de los detalles externos como base de datos, APIs, cache o servicios de IA.

## 3. Flujo recomendado

```txt
Controller
   ↓
Use Case
   ↓
Domain Service / Entity
   ↓
Repository Port
   ↓
Repository Adapter
   ↓
Database / External API
```

## 4. Patrones usados

### 4.1 Use Case Pattern

Cada acción importante del sistema debe representarse como un caso de uso.

Ejemplos:

```txt
RegisterUserUseCase
LoginUserUseCase
ResolveWasteQuestionUseCase
CreateMissionUseCase
CompleteMissionUseCase
EarnPointsUseCase
RedeemRewardUseCase
```

Ventajas:

- Organiza la lógica de aplicación.
- Evita servicios demasiado grandes.
- Facilita pruebas unitarias.
- Hace más claro el flujo del sistema.

### 4.2 Repository Pattern

Permite que la lógica de negocio no dependa directamente de Prisma ni PostgreSQL.

Ejemplo de puerto:

```ts
export interface MissionRepositoryPort {
  create(mission: Mission): Promise<Mission>;
  findByUserId(userId: string): Promise<Mission[]>;
  complete(missionId: string): Promise<Mission>;
}
```

Ejemplo de adaptador:

```ts
@Injectable()
export class PrismaMissionRepository implements MissionRepositoryPort {
  constructor(private readonly prisma: PrismaService) {}

  async create(mission: Mission): Promise<Mission> {
    // implementación con Prisma
  }
}
```

### 4.3 Adapter Pattern

Sirve para conectar servicios externos sin contaminar el dominio.

Ejemplos:

```txt
GroqAiAdapter
PrismaMissionRepository
RedisCacheAdapter
EmailNotificationAdapter
PushNotificationAdapter
```

### 4.4 Dependency Injection

NestJS trabaja naturalmente con inyección de dependencias. Esto permite cambiar implementaciones sin modificar los casos de uso.

Ejemplo:

```txt
MissionRepositoryPort → PrismaMissionRepository
AiAssistantPort → GroqAiAdapter
CachePort → RedisCacheAdapter
```

### 4.5 Domain Service Pattern

Se usa cuando una regla de negocio no pertenece claramente a una sola entidad.

Ejemplo:

```txt
MissionGeneratorDomainService
PointsCalculatorDomainService
RewardEligibilityDomainService
WasteClassificationDomainService
```

### 4.6 Event Pattern interno

Se usará para desacoplar la gamificación.

Eventos sugeridos:

```txt
WasteQuestionResolvedEvent
MissionCreatedEvent
MissionCompletedEvent
PointsEarnedEvent
RewardUnlockedEvent
```

Ejemplo:

```txt
Usuario completa misión
        ↓
MissionCompletedEvent
        ↓
Points module suma puntos
        ↓
Rewards module verifica recompensas
        ↓
Notifications module avisa al usuario
```

## 5. Estructura por módulo

Ejemplo para `ai-assistant`:

```txt
ai-assistant/
├── application/
│   ├── usecases/
│   │   └── resolve-waste-question.usecase.ts
│   └── services/
│       └── ai-assistant.service.ts
│
├── domain/
│   ├── entities/
│   │   └── ai-response.entity.ts
│   ├── repositories/
│   ├── services/
│   │   └── waste-classification-domain.service.ts
│   └── ports/
│       └── ai-assistant.port.ts
│
├── infrastructure/
│   ├── adapters/
│   │   └── groq-ai.adapter.ts
│   └── mappers/
│       └── ai-response.mapper.ts
│
└── presentation/
    ├── controllers/
    │   └── ai-assistant.controller.ts
    └── dto/
        └── ask-question.dto.ts
```

## 6. Ejemplo de flujo backend

```txt
POST /api/ai-assistant/ask
        ↓
AiAssistantController
        ↓
ResolveWasteQuestionUseCase
        ↓
AiAssistantPort
        ↓
GroqAiAdapter
        ↓
Groq API
        ↓
WasteClassificationDomainService
        ↓
CreateMissionUseCase
        ↓
MissionRepositoryPort
        ↓
PrismaMissionRepository
        ↓
PostgreSQL
```

## 7. Reglas para mantener el backend ordenado

- Los controllers no deben contener lógica de negocio.
- Los use cases coordinan la acción principal.
- El domain no debe importar Prisma, NestJS ni librerías externas innecesarias.
- Los adaptadores externos van en infrastructure.
- Los DTOs solo deben usarse en presentation.
- Los repositories deben depender de interfaces/puertos.
- Las reglas de puntos y recompensas deben estar en domain o application, no en controller.

## 8. Conclusión

El backend de EcoBuddy debe usar patrones orientados a separación de responsabilidades. La combinación de arquitectura modular, arquitectura hexagonal, repository, adapter y use cases permite mantener el sistema limpio, escalable y fácil de probar.

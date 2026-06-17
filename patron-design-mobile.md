# Patrón de Diseño Mobile - EcoBuddy

## 1. Decisión

Para la aplicación móvil de EcoBuddy se usará:

```txt
Clean Architecture + MVVM + Repository Pattern + Use Cases
```

La app será desarrollada en Flutter y consumirá el backend NestJS mediante una API REST.

## 2. Patrón principal

El patrón principal en mobile será:

```txt
MVVM
```

MVVM significa:

```txt
Model - View - ViewModel
```

En Flutter se aplicará de la siguiente manera:

```txt
View
   ↓
ViewModel / Provider
   ↓
Use Case
   ↓
Repository
   ↓
Data Source
```

## 3. Librería de estado recomendada

La librería recomendada para manejar estado es:

```txt
Riverpod
```

Riverpod encaja bien con MVVM porque permite crear providers para ViewModels, casos de uso, repositorios y datasources.

## 4. Capas en Flutter

### 4.1 Presentation Layer

Contiene todo lo relacionado con la interfaz y el estado visual.

Incluye:

- Pages.
- Widgets.
- ViewModels.
- Providers.
- Estados de pantalla.

Ejemplo:

```txt
ChatPage
ChatViewModel
ChatState
MissionCardWidget
```

### 4.2 Domain Layer

Contiene las reglas principales de la app móvil, sin depender de Flutter, Dio o almacenamiento local.

Incluye:

- Entities.
- Use cases.
- Repository contracts.

Ejemplo:

```txt
WasteQuestion
Mission
Reward
AskWasteQuestionUseCase
CompleteMissionUseCase
AiAssistantRepository
```

### 4.3 Data Layer

Contiene la comunicación con APIs, modelos y persistencia local.

Incluye:

- Models.
- DTOs.
- Remote Data Sources.
- Local Data Sources.
- Repository Implementations.

Ejemplo:

```txt
AiAssistantRemoteDataSource
MissionRemoteDataSource
AuthLocalDataSource
AiAssistantRepositoryImpl
```

## 5. Flujo recomendado

```txt
Usuario interactúa con pantalla
        ↓
View llama al ViewModel
        ↓
ViewModel ejecuta un UseCase
        ↓
UseCase llama al Repository
        ↓
Repository decide usar RemoteDataSource o LocalDataSource
        ↓
DataSource consume API NestJS
        ↓
Respuesta vuelve a la View
```

## 6. Ejemplo aplicado: pregunta al asistente IA

```txt
ChatPage
   ↓
ChatViewModel
   ↓
AskWasteQuestionUseCase
   ↓
AiAssistantRepository
   ↓
AiAssistantRemoteDataSource
   ↓
NestJS API
```

## 7. Estructura recomendada por feature

Ejemplo con `chat_ai`:

```txt
chat_ai/
├── data/
│   ├── datasources/
│   │   └── ai_assistant_remote_datasource.dart
│   ├── models/
│   │   ├── ai_response_model.dart
│   │   └── ask_question_request_model.dart
│   └── repositories/
│       └── ai_assistant_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── ai_response.dart
│   │   └── waste_question.dart
│   ├── repositories/
│   │   └── ai_assistant_repository.dart
│   └── usecases/
│       └── ask_waste_question_usecase.dart
│
└── presentation/
    ├── pages/
    │   └── chat_page.dart
    ├── providers/
    │   ├── chat_provider.dart
    │   └── chat_viewmodel.dart
    └── widgets/
        ├── chat_bubble.dart
        └── waste_answer_card.dart
```

## 8. Features principales

```txt
features/
├── auth/
├── chat_ai/
├── recycling/
├── missions/
├── habits/
├── rewards/
├── family/
├── profile/
└── notifications/
```

## 9. Ejemplo de ViewModel

```dart
class ChatViewModel extends StateNotifier<ChatState> {
  final AskWasteQuestionUseCase askWasteQuestionUseCase;

  ChatViewModel(this.askWasteQuestionUseCase) : super(ChatState.initial());

  Future<void> askQuestion(String question) async {
    state = state.copyWith(isLoading: true);

    final result = await askWasteQuestionUseCase(question);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (response) => state = state.copyWith(
        isLoading: false,
        response: response,
      ),
    );
  }
}
```

## 10. Reglas para mantener Flutter ordenado

- Las pantallas no deben llamar directamente a Dio.
- Las pantallas no deben contener lógica de negocio.
- Los ViewModels manejan el estado de la UI.
- Los UseCases representan acciones concretas.
- Los Repositories abstraen el origen de datos.
- Los Models pertenecen a data.
- Las Entities pertenecen a domain.
- Los Widgets deben ser reutilizables cuando sea posible.

## 11. Paquetes recomendados

```yaml
dependencies:
  flutter_riverpod: ^2.0.0
  dio: ^5.0.0
  go_router: ^14.0.0
  freezed_annotation: ^2.0.0
  json_annotation: ^4.0.0
  shared_preferences: ^2.0.0
```

```yaml
dev_dependencies:
  build_runner: ^2.0.0
  freezed: ^2.0.0
  json_serializable: ^6.0.0
```

## 12. Conclusión

El patrón de diseño mobile para EcoBuddy será MVVM sobre Clean Architecture, apoyado por Repository Pattern y Use Cases. Esta combinación permite separar UI, estado, lógica y datos, haciendo que la app sea más mantenible y escalable.

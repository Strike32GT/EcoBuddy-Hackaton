# Diagrama MER - EcoBuddy

Este documento contiene el **Modelo Entidad-Relación (MER)** propuesto para EcoBuddy, una aplicación móvil desarrollada en Flutter que funciona como asistente inteligente para reciclaje familiar, clasificación de residuos, generación de misiones, hábitos sostenibles, puntos, créditos y recompensas.

## Objetivo del modelo

El modelo busca representar las entidades principales necesarias para:

- Gestionar usuarios y familias.
- Registrar conversaciones con el asistente IA.
- Clasificar residuos consultados por los usuarios.
- Generar misiones domésticas a partir de consultas o hábitos.
- Registrar hábitos sostenibles del hogar.
- Administrar puntos, créditos y recompensas.
- Enviar notificaciones a los usuarios.

## Diagrama MER en Mermaid

```mermaid
erDiagram
    USERS {
        uuid id PK
        string full_name
        string email UK
        string password_hash
        string avatar_url
        string role
        int total_points
        int total_credits
        boolean is_active
        datetime created_at
        datetime updated_at
    }

    FAMILIES {
        uuid id PK
        string name
        string description
        uuid created_by_user_id FK
        datetime created_at
        datetime updated_at
    }

    FAMILY_MEMBERS {
        uuid id PK
        uuid family_id FK
        uuid user_id FK
        string member_role
        datetime joined_at
    }

    AI_CONVERSATIONS {
        uuid id PK
        uuid user_id FK
        uuid family_id FK
        string title
        datetime started_at
        datetime updated_at
    }

    AI_MESSAGES {
        uuid id PK
        uuid conversation_id FK
        string sender_type
        text content
        string model_provider
        string model_name
        int tokens_used
        datetime created_at
    }

    WASTE_CATEGORIES {
        uuid id PK
        string name
        string description
        string color
        string icon
        boolean is_recyclable
        datetime created_at
    }

    WASTE_ITEMS {
        uuid id PK
        uuid category_id FK
        string name
        string description
        string disposal_instruction
        boolean requires_cleaning
        boolean requires_special_handling
        datetime created_at
        datetime updated_at
    }

    WASTE_QUERIES {
        uuid id PK
        uuid user_id FK
        uuid family_id FK
        uuid conversation_id FK
        uuid waste_item_id FK
        text user_question
        text ai_answer
        string classification_result
        float confidence_score
        datetime created_at
    }

    MISSIONS {
        uuid id PK
        uuid family_id FK
        uuid created_for_user_id FK
        uuid waste_query_id FK
        string title
        text description
        string difficulty
        string status
        int points_reward
        int credits_reward
        datetime due_date
        datetime created_at
        datetime updated_at
    }

    MISSION_COMPLETIONS {
        uuid id PK
        uuid mission_id FK
        uuid user_id FK
        text evidence_note
        string evidence_image_url
        datetime completed_at
        boolean validated
    }

    HABIT_TYPES {
        uuid id PK
        string name
        text description
        string frequency
        int points_reward
        int credits_reward
        boolean is_active
        datetime created_at
    }

    HABIT_LOGS {
        uuid id PK
        uuid habit_type_id FK
        uuid user_id FK
        uuid family_id FK
        string status
        text note
        datetime registered_at
    }

    POINT_TRANSACTIONS {
        uuid id PK
        uuid user_id FK
        uuid family_id FK
        uuid mission_id FK
        uuid habit_log_id FK
        string transaction_type
        int points_amount
        int credits_amount
        text description
        datetime created_at
    }

    REWARDS {
        uuid id PK
        string name
        text description
        string reward_type
        int credits_cost
        int stock
        boolean is_active
        datetime created_at
        datetime updated_at
    }

    REWARD_REDEMPTIONS {
        uuid id PK
        uuid reward_id FK
        uuid user_id FK
        uuid family_id FK
        int credits_spent
        string status
        datetime redeemed_at
    }

    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        string title
        text message
        string notification_type
        boolean is_read
        datetime created_at
    }

    USERS ||--o{ FAMILY_MEMBERS : pertenece
    FAMILIES ||--o{ FAMILY_MEMBERS : tiene
    USERS ||--o{ FAMILIES : crea

    USERS ||--o{ AI_CONVERSATIONS : inicia
    FAMILIES ||--o{ AI_CONVERSATIONS : agrupa
    AI_CONVERSATIONS ||--o{ AI_MESSAGES : contiene

    WASTE_CATEGORIES ||--o{ WASTE_ITEMS : clasifica
    USERS ||--o{ WASTE_QUERIES : realiza
    FAMILIES ||--o{ WASTE_QUERIES : registra
    AI_CONVERSATIONS ||--o{ WASTE_QUERIES : genera
    WASTE_ITEMS ||--o{ WASTE_QUERIES : responde

    FAMILIES ||--o{ MISSIONS : recibe
    USERS ||--o{ MISSIONS : asignado
    WASTE_QUERIES ||--o{ MISSIONS : origina
    MISSIONS ||--o{ MISSION_COMPLETIONS : completa
    USERS ||--o{ MISSION_COMPLETIONS : evidencia

    HABIT_TYPES ||--o{ HABIT_LOGS : define
    USERS ||--o{ HABIT_LOGS : registra
    FAMILIES ||--o{ HABIT_LOGS : acumula

    USERS ||--o{ POINT_TRANSACTIONS : gana
    FAMILIES ||--o{ POINT_TRANSACTIONS : acumula
    MISSIONS ||--o{ POINT_TRANSACTIONS : recompensa
    HABIT_LOGS ||--o{ POINT_TRANSACTIONS : recompensa

    REWARDS ||--o{ REWARD_REDEMPTIONS : canjea
    USERS ||--o{ REWARD_REDEMPTIONS : solicita
    FAMILIES ||--o{ REWARD_REDEMPTIONS : registra

    USERS ||--o{ NOTIFICATIONS : recibe
```

## Descripción de entidades principales

### USERS

Representa a los usuarios registrados en la aplicación. Cada usuario puede pertenecer a una familia, iniciar conversaciones con la IA, completar misiones, registrar hábitos y canjear recompensas.

### FAMILIES

Representa el hogar o grupo familiar. Es importante porque EcoBuddy está orientado a mejorar los hábitos de reciclaje dentro del entorno familiar.

### FAMILY_MEMBERS

Tabla intermedia que permite relacionar usuarios con familias. También permite manejar roles dentro del hogar, por ejemplo: administrador, padre, madre, hijo o invitado.

### AI_CONVERSATIONS

Representa una conversación entre el usuario y el asistente IA. Sirve para agrupar los mensajes y mantener historial de consultas.

### AI_MESSAGES

Guarda los mensajes enviados por el usuario y las respuestas generadas por la IA. Permite auditar el historial conversacional y mejorar la experiencia del asistente.

### WASTE_CATEGORIES

Representa categorías de residuos, por ejemplo: plástico, papel, cartón, vidrio, orgánico, electrónico, peligroso o no reciclable.

### WASTE_ITEMS

Representa residuos específicos que pueden ser consultados por el usuario, por ejemplo: botella de plástico, caja de cartón, pila, bolsa, papel usado o lata.

### WASTE_QUERIES

Guarda cada consulta realizada por el usuario sobre un residuo. Relaciona la pregunta, la respuesta de IA, la clasificación obtenida y el residuo identificado.

### MISSIONS

Representa las misiones domésticas generadas por el sistema. Una misión puede nacer desde una consulta a la IA o desde una recomendación de hábito sostenible.

### MISSION_COMPLETIONS

Registra la finalización de una misión por parte del usuario. Puede guardar evidencia textual o imagen, además de un estado de validación.

### HABIT_TYPES

Define los tipos de hábitos sostenibles que el usuario puede registrar, por ejemplo: separar residuos, reducir plástico, reutilizar envases o limpiar materiales reciclables.

### HABIT_LOGS

Registra cada vez que un usuario cumple o reporta un hábito sostenible.

### POINT_TRANSACTIONS

Guarda el historial de puntos y créditos ganados o descontados. Es útil para mantener trazabilidad de la gamificación.

### REWARDS

Representa las recompensas disponibles para canjear con créditos.

### REWARD_REDEMPTIONS

Registra los canjes realizados por los usuarios.

### NOTIFICATIONS

Guarda notificaciones enviadas al usuario, como misiones pendientes, recompensas desbloqueadas o recordatorios de hábitos.

## Reglas generales del modelo

- Un usuario puede pertenecer a una o varias familias mediante `FAMILY_MEMBERS`.
- Una familia puede tener varios miembros.
- Un usuario puede iniciar varias conversaciones con la IA.
- Una conversación puede tener varios mensajes.
- Una consulta sobre residuo puede generar una misión.
- Una misión puede otorgar puntos y créditos al completarse.
- Un hábito registrado también puede generar puntos o créditos.
- Los créditos acumulados pueden ser usados para canjear recompensas.
- Las transacciones de puntos permiten auditar todo el sistema de gamificación.

## Observación técnica

Este MER está pensado para implementarse con **PostgreSQL** y un backend **NestJS** usando una arquitectura interna basada en módulos. Si se utiliza Prisma, cada entidad del diagrama puede convertirse en un modelo dentro de `schema.prisma`.

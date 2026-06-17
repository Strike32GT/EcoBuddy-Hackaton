# Metodología - EcoBuddy

> Nota: el archivo se llama `metologia.md` porque ese fue el nombre solicitado, pero el término correcto es `metodologia.md`.

## 1. Metodología seleccionada

La metodología seleccionada para EcoBuddy es:

```txt
Scrum ligero
```

Scrum es adecuado porque EcoBuddy tiene funcionalidades que pueden evolucionar durante el desarrollo, especialmente el asistente IA, la gamificación, las misiones domésticas y el sistema de recompensas.

## 2. Justificación

No se recomienda usar Waterfall porque EcoBuddy no es un proyecto completamente cerrado desde el inicio. Durante el desarrollo pueden cambiar:

- El flujo del asistente conversacional.
- Las respuestas generadas por IA.
- Las reglas de clasificación de residuos.
- Las misiones domésticas.
- La forma de asignar puntos y créditos.
- La experiencia de usuario en Flutter.
- El sistema de recompensas.

Scrum permite trabajar por incrementos, validar avances y corregir el producto conforme se desarrolla.

## 3. Tipo de Scrum recomendado

Para este proyecto se recomienda un Scrum ligero, no un Scrum empresarial complejo.

Características:

- Sprints cortos de 1 o 2 semanas.
- Backlog simple.
- Reuniones breves.
- Entregables funcionales al final de cada sprint.
- Priorización por valor del producto.
- Validación frecuente del avance.

## 4. Roles sugeridos

### Product Owner

Define la visión del producto, prioriza funcionalidades y valida si lo construido cumple con la necesidad principal.

### Scrum Master

Ayuda a organizar el proceso, controlar el avance y eliminar bloqueos.

### Development Team

Se encarga del desarrollo de la app Flutter, backend NestJS, base de datos, integración con Groq y pruebas.

## 5. Artefactos Scrum

### Product Backlog

Lista general de funcionalidades del proyecto.

Ejemplos:

- Registro de usuario.
- Inicio de sesión.
- Crear familia.
- Consultar residuo con IA.
- Generar misión doméstica.
- Completar misión.
- Sumar puntos.
- Canjear recompensas.
- Ver progreso ambiental.

### Sprint Backlog

Lista de tareas seleccionadas para un sprint específico.

### Incremento

Resultado funcional entregado al final del sprint.

## 6. Propuesta de sprints

### Sprint 1: Base del proyecto

Objetivo: preparar la estructura inicial del sistema.

Tareas:

- Crear proyecto Flutter.
- Crear proyecto NestJS.
- Definir estructura de carpetas.
- Configurar PostgreSQL.
- Configurar variables de entorno.
- Crear documentación inicial.

Entregable:

- Proyecto base funcional.

### Sprint 2: Autenticación y usuarios

Objetivo: permitir que un usuario acceda al sistema.

Tareas:

- Registro de usuario.
- Login.
- JWT.
- Perfil básico.
- Validaciones.

Entregable:

- Usuario puede registrarse e iniciar sesión.

### Sprint 3: Familias y hogar

Objetivo: representar el entorno familiar dentro de la app.

Tareas:

- Crear familia.
- Unirse a familia.
- Listar miembros.
- Perfil del hogar.

Entregable:

- Usuario puede pertenecer a una familia.

### Sprint 4: Asistente IA

Objetivo: integrar el asistente conversacional.

Tareas:

- Crear módulo de IA.
- Integrar Groq API.
- Enviar preguntas desde Flutter.
- Mostrar respuestas.
- Guardar historial.

Entregable:

- Usuario puede preguntar cómo clasificar un residuo.

### Sprint 5: Clasificación de residuos

Objetivo: estructurar las respuestas del asistente.

Tareas:

- Definir categorías de residuos.
- Guardar residuos consultados.
- Clasificar resultados.
- Mostrar recomendaciones.

Entregable:

- Sistema responde con clasificación clara del residuo.

### Sprint 6: Misiones domésticas

Objetivo: generar acciones prácticas a partir de consultas.

Tareas:

- Crear módulo de misiones.
- Generar misión después de una consulta.
- Listar misiones activas.
- Completar misión.

Entregable:

- Usuario recibe y completa misiones.

### Sprint 7: Puntos, créditos y recompensas

Objetivo: implementar la gamificación.

Tareas:

- Sumar puntos.
- Registrar créditos.
- Crear recompensas.
- Canjear recompensas.
- Mostrar progreso.

Entregable:

- Usuario gana puntos y puede canjear recompensas.

### Sprint 8: Hábitos, notificaciones y cierre

Objetivo: completar funcionalidades complementarias y pulir el sistema.

Tareas:

- Registro de hábitos.
- Notificaciones.
- Pruebas.
- Corrección de errores.
- Mejora visual.
- Documentación final.

Entregable:

- MVP completo de EcoBuddy.

## 7. Herramientas recomendadas

- Jira, Trello o GitHub Projects para el tablero Scrum.
- GitHub para control de versiones.
- GitHub Issues para tareas y bugs.
- Postman o Insomnia para probar la API.
- Figma o Stitch para prototipado.
- Docker para entorno local.

## 8. Estados recomendados del tablero

```txt
Por hacer
En progreso
En revisión
Hecho
```

## 9. Conclusión

La metodología recomendada para EcoBuddy es Scrum ligero, porque permite construir el producto de forma incremental, validar las funcionalidades principales y adaptarse a cambios en IA, gamificación y experiencia de usuario.

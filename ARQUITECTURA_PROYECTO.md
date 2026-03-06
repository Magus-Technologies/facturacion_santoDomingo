# ARQUITECTURA DEL PROYECTO CREDIGO

## 📁 ESTRUCTURA DEL PROYECTO

```
credigo/
├── app/                          # Lógica de negocio (Backend Laravel)
│   ├── Enums/                    # Enumeraciones del sistema
│   ├── Exceptions/               # Excepciones personalizadas
│   ├── Http/
│   │   ├── Controllers/
│   │   │   ├── Api/              # Controladores API REST
│   │   │   └── BaseApiController.php
│   │   ├── Middleware/           # Middleware personalizado
│   │   ├── Requests/             # Form Requests para validación
│   │   └── Resources/            # API Resources para transformar datos
│   ├── Models/                   # Modelos Eloquent (ORM)
│   ├── Providers/                # Service Providers de Laravel
│   ├── Services/                 # Capa de servicios (Lógica de negocio)
│   │   └── Contracts/            # Interfaces de servicios
│   └── Traits/                   # Traits reutilizables
│
│
├── database/                     # Base de datos
│   ├── factories/                # Factories para testing
│   ├── migrations/               # Migraciones de base de datos
│   └── seeders/                  # Seeders para datos iniciale


# 📱 Test App for Vacancy

A Flutter application built with **Clean Architecture**, featuring Authentication, Home Dashboard, and Settings — demonstrating best practices in state management, dependency injection, networking, and localization.

---

## ✨ Features

- **Authentication** — Email/password login + Google Sign-In
- **Home Dashboard** — User profile, stats cards, business list with shimmer loading
- **Settings** — Theme switching (light/dark) and language selection
- **Localization** — Multi-language support via `flutter_localizations` & `intl`

---

## 🏗️ Architecture

The project follows **Clean Architecture** with a feature-first folder structure:

```
lib/
├── app/                    # App-level config
│   ├── router/             # GoRouter navigation
│   └── theme/              # Theme & ThemeCubit
├── core/                   # Shared utilities
│   ├── di/                 # GetIt dependency injection
│   ├── l10n/               # Locale cubit
│   ├── network/            # Dio HTTP client
│   └── storage/            # Secure storage
└── features/
    ├── auth/               # Authentication feature
    │   ├── data/           # DataSources, Models, Repository impl
    │   ├── domain/         # Entities, Repository interface, UseCases
    │   └── presentation/   # BLoC, Pages, Widgets
    ├── home/               # Home / Dashboard feature
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    └── settings/           # Settings feature
        └── presentation/
```

---

## 📦 Key Packages

| Category              | Package                    |
|-----------------------|----------------------------|
| State Management      | `flutter_bloc`, `equatable`|
| Navigation            | `go_router`                |
| Networking            | `dio`                      |
| Dependency Injection  | `get_it`                   |
| Storage               | `flutter_secure_storage`, `shared_preferences` |
| Auth                  | `google_sign_in`           |
| UI                    | `google_fonts`, `iconsax_flutter`, `shimmer`, `cached_network_image` |
| Testing               | `bloc_test`, `mocktail`    |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `^3.10.4`
- Dart SDK (bundled with Flutter)

### Installation

```bash
# Clone the repository
git clone https://github.com/khurshid28/test-app-for-vacancy.git
cd test-app-for-vacancy

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🧪 Running Tests

```bash
flutter test
```

---

## 📄 License

This project is for demonstration purposes.

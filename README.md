# booking_demo

A modern Flutter starter showcasing **Bloc + GoRouter + GetIt + Retrofit (Dio) + Freezed + Build Runner**.  
Includes a customer flow and a web-friendly admin dashboard to demonstrate real-world patterns (web hot reload, isolated widget previews, and clean data layers).

---

## 🚀 Features

- Customer mode and Admin Dashboard (responsive grid for web)
- Easy toggle between **mock data** and **real API** via an env flag (`USE_MOCK=true`)
- Layered architecture (domain / data / presentation)
- Code generation for Retrofit client, Freezed models, and JSON serialization

---

## 🏗️ Architecture

```
lib/
  core/                   # DI (GetIt), router (GoRouter), theming
  features/
    booking/
      domain/             # entities, repositories (abstractions)
      data/               # Retrofit API, repository impl, mock data source
      application/        # Bloc
      presentation/       # pages & widgets (admin grid, status pill, etc.)
```

---

## 🛠️ Getting Started

```bash
flutter pub get
# Generate code
dart run build_runner build --delete-conflicting-outputs

# Run with mock data (web)
USE_MOCK=true flutter run -d chrome

# Or on a device/emulator
USE_MOCK=true flutter run
```

---

## 🔄 Switching to a Real Backend

1. Set the `baseUrl` in `lib/core/di/locator.dart`.
2. Remove the `USE_MOCK` environment variable when running.

---

## 📝 Recommended Scripts

```bash
# Format & analyze
flutter format . && flutter analyze

# Run tests with coverage
flutter test --coverage
```

---

## 🤖 Continuous Integration

A ready-to-use GitHub Actions workflow is included at `.github/workflows/flutter_ci.yaml`:

- Setup Java 17 & Flutter stable
- Install dependencies
- Run code generation (build_runner)
- Format check, analyze, tests
- Smoke builds for web and apk

---

## ⚙️ Environment Variables

- `USE_MOCK=true` → use the in-memory mock data source instead of hitting the API.
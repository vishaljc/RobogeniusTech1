# RoboGenius Tech — Flutter Web Application

A **premium, futuristic Flutter Web application** for RoboGenius Tech, a Robotic Process Automation (RPA) company.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0
- Chrome browser

### Install Dependencies
```bash
flutter pub get
```

### Run in Chrome
```bash
flutter run -d chrome
```

### Build for Production
```bash
flutter build web --release
```

---

## 🗂 Project Structure

```
lib/
├── main.dart                     # Entry point — MultiProvider setup
├── app/
│   ├── app.dart                  # MaterialApp.router
│   └── routes.dart               # GoRouter configuration
├── core/
│   ├── constants/app_constants.dart
│   ├── theme/app_theme.dart      # Dark theme, AppColors
│   └── utils/responsive.dart     # Responsive breakpoint helpers
├── data/
│   ├── models/service_model.dart
│   └── services/services_data.dart
├── viewmodels/
│   ├── home_vm.dart              # HomeViewModel (stats, scroll)
│   └── services_vm.dart         # ServicesViewModel (list, hover, select)
├── views/
│   ├── home/                     # Home page + section widgets
│   ├── services/                 # Services page
│   ├── about/                    # About page
│   └── contact/                  # Contact page + form
├── widgets/
│   ├── common/                   # Reusable: CustomButton, GlassCard, etc.
│   └── layout/                   # Navbar, Footer, ResponsiveLayout
└── providers/
    └── app_provider.dart         # Global UI state (menu, route)
```

---

## 🎨 Design System

| Token | Value |
|-------|-------|
| Background | `#050A18` |
| Surface | `#0D1528` |
| Neon Blue | `#00D4FF` |
| Neon Purple | `#7B2FFF` |
| Neon Cyan | `#00FFD1` |
| Font | Space Grotesk (Google Fonts) |

---

## 📱 Responsive Breakpoints

| Device | Width |
|--------|-------|
| Mobile | < 600px |
| Tablet | 600–1024px |
| Desktop | > 1024px |

---

## 🧱 Architecture: MVVM + Provider

- **Model**: `ServiceModel` — pure data
- **ViewModel**: `HomeViewModel`, `ServicesViewModel` — business logic, `ChangeNotifier`
- **View**: Flutter widgets — consume via `context.watch<VM>()`
- **Provider**: `AppProvider` — global app state (menu open/close, current route)

---

## 📦 Key Dependencies

| Package | Purpose |
|---------|---------|
| `provider` | State management |
| `go_router` | Declarative routing |
| `google_fonts` | Space Grotesk font |
| `visibility_detector` | Scroll-triggered animations |
| `flutter_animate` | Animation helpers |

---

## ✨ Features

- ✅ Full-screen animated hero with custom robot illustration (Canvas)
- ✅ Animated stat counters (triggered on scroll visibility)
- ✅ Services preview grid with hover effects
- ✅ RPA highlight section with automation flow diagram (Canvas)
- ✅ Why Choose Us section with feature cards
- ✅ Process timeline (4-step)
- ✅ About page with company timeline (Canvas)
- ✅ Contact form with loading state + success animation
- ✅ Glassmorphism cards
- ✅ Sticky navbar with active route highlighting
- ✅ Footer with quick links + contact info
- ✅ Fully responsive (Mobile / Tablet / Desktop)
- ✅ Scroll fade-in animations on all sections
- ✅ Gradient glow buttons with hover effects
- ✅ Dark tech theme throughout

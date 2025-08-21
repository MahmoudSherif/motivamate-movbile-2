# MotivaMate - Self Motivation Mobile App

A Flutter mobile application designed to help users stay motivated and achieve their goals through a comprehensive set of features including task management, focus timers, calendar planning, note-taking, and inspirational content.

## 🌟 Features

### 🎯 Core Features
- **Calendar** - Event creation and management with visual indicators
- **Tasks & Challenges** - Personal task management with social challenge leagues
- **Notes** - Modern note-taking with categories and search functionality
- **Profile** - User statistics, achievements, and progress tracking
- **Achieve** - Focus timer (Pomodoro-style) with goal setting
- **Inspiration** - Historical figures with motivational lessons and quotes

### 🎨 Design
- **Space Theme** - Animated starfield background throughout the app
- **Glass Morphism** - Modern UI with backdrop blur effects
- **Motivational Quotes** - Rotating quotes in Arabic and English every 3 seconds
- **Deep Teal & Orange** - Beautiful color scheme optimized for motivation

### 🔧 Technical Features
- **Flutter** - Cross-platform mobile development
- **Firebase** - Authentication and data synchronization
- **Provider** - State management pattern
- **Material Design** - Modern UI components
- **Offline Support** - Local data persistence

## 📱 App Structure

```
📱 MotivaMate
├── 📅 Calendar - Event management and planning
├── ✅ Tasks - Personal tasks + social challenges
├── 📝 Notes - Modern note-taking system
├── 👤 Profile - Stats and achievements
├── 🎯 Achieve - Focus timer and goals
└── 💡 Inspire - Historical figures and lessons

🔥 Quote Bar - Rotating motivational quotes
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode for platform-specific development
- Firebase project for backend services

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/MahmoudSherif/motivamate-movbile-2.git
   cd motivamate-movbile-2
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories:
     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── theme/
│   └── app_theme.dart       # App theming and colors
├── models/                  # Data models
│   ├── task.dart
│   ├── calendar_event.dart
│   ├── note.dart
│   ├── achievement.dart
│   └── ...
├── providers/               # State management
│   ├── auth_provider.dart
│   ├── task_provider.dart
│   └── ...
├── screens/                 # UI screens
│   ├── auth/
│   ├── calendar/
│   ├── tasks/
│   └── ...
└── widgets/                 # Reusable components
    ├── space_background.dart
    └── quote_bar.dart
```

## 🎨 Design System

### Colors
- **Primary Teal**: `#1A6B6B` - Main brand color
- **Warm Orange**: `#E67E22` - Accent color for highlights
- **Space Blue**: `#0F172A` - Background gradient base
- **Glass Effects**: Semi-transparent overlays with backdrop blur

### Typography
- **Inter Font Family** - Clean, modern readability
- **Arabic Support** - Cairo font for Arabic quotes and text
- **Responsive Sizing** - Scales appropriately across devices

## 🔥 Key Features Detailed

### 1. Calendar System
- Visual calendar with event indicators
- Touch-optimized date selection
- Event creation with time management
- Color-coded event categories

### 2. Task Management
- Personal task creation with priorities
- Due date tracking and notifications
- Social challenges with unique codes
- Leaderboard system for motivation

### 3. Focus Timer (Achieve)
- Pomodoro-style timer with presets (15, 25, 45, 60 minutes)
- Animated circular progress indicator
- Goal setting and tracking
- Session completion celebrations

### 4. Notes System
- Modern card-based note layout
- Category organization
- Search functionality
- Rich text support

### 5. Inspiration Content
- Historical figures with motivational stories
- Key lessons and quotes
- Swipeable card interface
- Educational content for motivation

### 6. Quote System
- Rotating quotes every 3 seconds
- Bilingual support (Arabic/English)
- Fade animations between quotes
- Inspirational and motivational content

## 🛠️ Development

### Dependencies
- `flutter`: SDK
- `provider`: State management
- `firebase_core`: Firebase integration
- `firebase_auth`: Authentication
- `cloud_firestore`: Database
- `table_calendar`: Calendar widget
- `google_fonts`: Typography
- `fl_chart`: Charts and analytics

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📖 Documentation References

This project includes comprehensive documentation from the original study companion concept:
- `UI_UX_SUMMARY.md` - Design system and user experience guidelines
- `FUNCTIONALITY_DOCUMENTATION.md` - Complete feature specifications
- `QUICK_REFERENCE.md` - Development checklist and priorities
- `AUTHENTICATION_GUIDE.md` - User authentication and data sync guide

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📱 Screenshots

*Add screenshots here once the app is running*

## 🎯 Roadmap

- [ ] Firebase integration completion
- [ ] Chart analytics implementation
- [ ] Push notifications
- [ ] Social features enhancement
- [ ] Offline functionality
- [ ] Achievement system with animations
- [ ] Habit tracking features
- [ ] Export/import functionality

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by productivity and motivation apps
- Historical figures content for educational purposes
- Firebase for backend infrastructure
- Flutter community for amazing packages

---

**Built with ❤️ using Flutter**
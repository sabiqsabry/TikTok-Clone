# TikTok Clone - Flutter App

A fully functional TikTok clone built with Flutter, featuring a vertical video feed, user profiles, and social features.

## 🎯 Features

### Core Features
- **Vertical Video Feed**: Smooth scrolling video feed with autoplay functionality
- **User Profiles**: Complete user profile with bio, stats, and video grid
- **Bottom Navigation**: Five-tab navigation (Home, Discover, Upload, Inbox, Profile)
- **Like & Follow**: Interactive like and follow buttons
- **Comments & Share**: Placeholder functionality for social features

### UI/UX
- **TikTok-like Design**: Authentic TikTok UI with proper styling
- **Responsive Layout**: Works on different screen sizes
- **Smooth Animations**: Fluid transitions and interactions
- **Dark Theme**: Proper dark theme for video content

## 📱 Screenshots

The app includes visual references from the `assets/figma_screens/` directory:
- Home feed with vertical scrolling
- User profile with video grid
- Upload interface
- Comments and sharing features
- Settings and privacy screens

## 🛠️ Tech Stack

- **Flutter** - Core framework
- **video_player** - Video playback functionality
- **chewie** - Enhanced video controls
- **cached_network_image** - Image caching
- **provider** - State management
- **shared_preferences** - Local data storage
- **image_picker** - Video/image selection
- **permission_handler** - Device permissions

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── user.dart            # User data model
│   └── video.dart           # Video data model
├── screens/
│   ├── home_screen.dart     # Main video feed
│   ├── profile_screen.dart  # User profile
│   ├── discover_screen.dart # Discover tab
│   ├── upload_screen.dart   # Upload interface
│   └── inbox_screen.dart    # Inbox/messages
├── widgets/
│   ├── video_card.dart      # Video display widget
│   ├── profile_header.dart  # Profile header widget
│   └── bottom_nav_bar.dart # Navigation bar
└── services/
    └── local_storage_service.dart # Data persistence
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio / Xcode
- iOS Simulator or Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/sabiqsabry/TikTok-Clone.git
   cd TikTok-Clone
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platform Support
- ✅ iOS
- ✅ Android
- ⏳ Web (coming soon)
- ⏳ Desktop (coming soon)

## 🎨 Design System

The app follows TikTok's design language:
- **Colors**: Black backgrounds for video content, white for UI elements
- **Typography**: Clean, readable fonts with proper hierarchy
- **Icons**: Material Design icons with custom styling
- **Layout**: Full-screen video experience with overlay UI

## 📊 Features Status

| Feature | Status | Notes |
|---------|--------|-------|
| Vertical Video Feed | ✅ Complete | Smooth scrolling with mock data |
| User Profiles | ✅ Complete | Full profile with video grid |
| Bottom Navigation | ✅ Complete | All 5 tabs implemented |
| Like/Follow | ✅ Complete | Interactive buttons |
| Comments | 🔄 Placeholder | UI ready, backend needed |
| Share | 🔄 Placeholder | UI ready, backend needed |
| Upload | 🔄 Placeholder | UI ready, camera integration needed |
| Video Playback | 🔄 Placeholder | Mock videos, real video integration needed |

## 🔧 Configuration

### App Icon
The app uses a custom icon from `assets/figma_screens/Icon.png`. To regenerate icons:
```bash
flutter pub run flutter_launcher_icons:main
```

### Dependencies
All dependencies are managed in `pubspec.yaml` with the latest stable versions.

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📦 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- TikTok for the original design inspiration
- Flutter team for the amazing framework
- All contributors and maintainers

## 📞 Support

If you have any questions or need help, please open an issue on GitHub.

---

**Note**: This is a demo/educational project. It's not affiliated with TikTok and doesn't use any official TikTok APIs.

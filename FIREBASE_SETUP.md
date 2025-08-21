# MotivaMate Firebase Setup Instructions

## 🔥 Firebase Configuration

To complete the setup of MotivaMate, you need to configure Firebase for authentication and data storage.

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: `motivamate-app`
4. Enable Google Analytics (optional)
5. Click "Create project"

### 2. Add Android App

1. In Firebase Console, click "Add app" → Android
2. Enter package name: `com.motivamate.app`
3. Enter app nickname: `MotivaMate Android`
4. Download `google-services.json`
5. Place it in `android/app/google-services.json`

### 3. Add iOS App (if building for iOS)

1. In Firebase Console, click "Add app" → iOS
2. Enter bundle ID: `com.motivamate.app`
3. Enter app nickname: `MotivaMate iOS`
4. Download `GoogleService-Info.plist`
5. Place it in `ios/Runner/GoogleService-Info.plist`

### 4. Enable Authentication

1. Go to Authentication → Sign-in method
2. Enable Email/Password
3. Enable Google Sign-In (optional)

### 5. Setup Firestore Database

1. Go to Firestore Database
2. Click "Create database"
3. Choose "Start in test mode" for development
4. Select a location close to your users

### 6. Configure Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow authenticated users to read/write their tasks
    match /tasks/{taskId} {
      allow read, write: if request.auth != null && resource.data.userId == request.auth.uid;
    }
    
    // Allow authenticated users to read/write their notes
    match /notes/{noteId} {
      allow read, write: if request.auth != null && resource.data.userId == request.auth.uid;
    }
    
    // Allow authenticated users to read/write their events
    match /events/{eventId} {
      allow read, write: if request.auth != null && resource.data.userId == request.auth.uid;
    }
    
    // Allow authenticated users to read/write their goals
    match /goals/{goalId} {
      allow read, write: if request.auth != null && resource.data.userId == request.auth.uid;
    }
    
    // Public challenges (read-only for discovery)
    match /challenges/{challengeId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        (resource.data.adminId == request.auth.uid || 
         request.auth.uid in resource.data.participantIds);
    }
  }
}
```

### 7. Test Configuration

After placing the configuration files, run:

```bash
flutter clean
flutter pub get
flutter run
```

### 8. Environment Variables (Optional)

Create `.env` file in project root for additional configuration:

```env
# Firebase Configuration (already in google-services.json)
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_STORAGE_BUCKET=your-project-id.appspot.com

# Optional API Keys
GOOGLE_PLACES_API_KEY=your-google-places-key
ANALYTICS_KEY=your-analytics-key
```

## 🔐 Security Considerations

1. **Never commit Firebase config files to public repositories**
2. **Use Firebase Security Rules to protect user data**
3. **Enable App Check for production** (prevents unauthorized access)
4. **Set up proper user authentication flow**
5. **Validate all user inputs on both client and server side**

## 📱 Production Setup

For production deployment:

1. **Android:**
   - Generate signed APK with proper keystore
   - Update Firebase project with production SHA-1 fingerprint
   - Enable Play Store distribution

2. **iOS:**
   - Configure proper provisioning profiles
   - Update Firebase project with production bundle ID
   - Enable App Store distribution

## 🆘 Troubleshooting

### Common Issues:

1. **"google-services.json not found"**
   - Make sure file is in `android/app/` directory
   - Check that package name matches

2. **"Firebase not initialized"**
   - Ensure `Firebase.initializeApp()` is called in `main.dart`
   - Check that configuration files are properly placed

3. **Authentication errors**
   - Verify Email/Password is enabled in Firebase Console
   - Check that security rules allow authenticated access

4. **Firestore permission denied**
   - Review security rules
   - Ensure user is properly authenticated
   - Check that user ID matches in rules

### Get Help:

- [Firebase Documentation](https://firebase.google.com/docs)
- [Flutter Firebase Plugins](https://firebase.flutter.dev/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter+firebase)

---

**Note:** This app is designed to work offline-first, so users can continue using most features even without internet connection. Data will sync when connection is restored.
# Firebase Android SHA fingerprints

These are the signing certificate fingerprints for the Android debug keystore used by this project.

Use these values in the Firebase Console (Project settings → Your apps → Add fingerprint) and then re-download `google-services.json`.

- SHA-1:
  E9:24:65:80:83:9E:F6:D9:0B:5E:41:37:B7:9E:31:4B:57:98:19:5C

- SHA-256:
  03:11:DB:D9:48:2C:93:C4:EA:3F:65:4D:08:35:77:04:CF:94:B1:DE:7D:03:E0:7A:70:C1:39:1D:59:B4:70:E8

Steps to use
1. Open the Firebase Console → Project Settings → Your apps → select the Android app for package `com.example.notes`.
2. Click "Add fingerprint" and paste the SHA-1 value, repeat for SHA-256.
3. After adding, download the updated `google-services.json` and replace `android/app/google-services.json` in this project.
4. Rebuild and run the app:

```powershell
cd "c:\App Dev\New folder\notes"
flutter pub get
flutter clean
flutter run -d <device-id>
```

Notes:
- Use the SHA for the debug keystore if you're testing locally with the debug build. For release builds, add the SHA(s) for your release keystore as well.
- If using CI or release signing, add the CI/release key SHA fingerprints in Firebase.

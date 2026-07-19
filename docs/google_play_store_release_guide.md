# MadrasaPulse — Google Play Store Release Guide 🚀

This document details the configuration and assets needed to release the **MadrasaPulse** Flutter mobile application on the Google Play Store.

---

## 🎨 Branding & Marketing Assets

To successfully publish your application on Google Play, you need standard brand graphics. We have pre-generated the following premium branding assets:

### 1. App Icon (512x512 PNG)
A minimalist mosque outline integrated with a pulse wave representing "MadrasaPulse", featuring teal and gold highlights.
![App Icon](file:///d:/MadrasaPulse/docs/branding/app_icon.png)

### 2. Feature Graphic (1024x500 PNG)
A premium marketing banner featuring dashboard mockup previews, mosque outlines, and product branding.
![Feature Graphic](file:///d:/MadrasaPulse/docs/branding/feature_graphic.png)

---

## 📦 App Package Configuration

We have renamed the package name to a production namespace across both platforms:
*   **Android Package Name:** `com.itsmenishmal.madrasapulse`
*   **iOS Bundle Identifier:** `com.itsmenishmal.madrasapulse`
*   **App Label Name:** `MadrasaPulse`

---

## 🔑 Application Signing Setup

To prevent sensitive password credentials from leaking into your Git repository, the Gradle build config is programmed to dynamically load values from a local file named `key.properties`.

### Step 1: Generate Release Keystore
Run the following command in your terminal to generate a secure keystore file:
```bash
keytool -genkey -v -keystore frontend/android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
*(Keep this file safe! If you lose this keystore, you will not be able to push updates to the Play Store.)*

### Step 2: Configure key.properties
Create a file named `key.properties` inside the `frontend/android/` directory:
```properties
storePassword=your_keystore_password_here
keyPassword=your_key_password_here
keyAlias=upload
storeFile=upload-keystore.jks
```
*(Both `key.properties` and `*.jks` are already included in `.gitignore` to prevent commits.)*

---

## 🚀 Building & Publishing

### Step 3: Build the Android App Bundle (AAB)
Run the compilation command inside the `frontend` folder:
```bash
cd frontend
flutter build appbundle --release
```
The output file will be generated at:
`frontend/build/app/outputs/bundle/release/app-release.aab`

### Step 4: Play Store Upload
1. Log in to the [Google Play Console](https://play.google.com/console).
2. Click **Create app**, fill in the app name (`MadrasaPulse`), default language, and app type.
3. Complete the app setup checklists (Content Rating, Privacy Policy, Target Audience).
4. Navigate to **Production** under the Release section.
5. Create a new release, and upload the generated `app-release.aab` bundle.
6. Submit the release for review!

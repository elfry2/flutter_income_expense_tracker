# Flutter Firebase Income & Expense Tracker

Lazily generated with Gemini [https://share.gemini.google/22DZ8SIJ6Lyv](https://share.gemini.google/22DZ8SIJ6Lyv).

A simple, modular income and expense tracker app built with **Flutter** and **Firebase Firestore** for educational purposes.

This repository demonstrates a clean implementation of full **CRUD** (Create, Read, Update, Delete) operations using Firestore, structured so that each operation has its own dedicated screen in Flutter.

---

## 🚀 Features

* **Read (List & Summary):** Real-time list of all income and expense entries powered by Firestore streams (`StreamBuilder`).
* **Read (Detail):** Dedicated detailed screen displaying metadata for a single selected transaction.
* **Create:** Form screen for recording new income or expense items.
* **Update:** Form screen pre-populated with existing document data for editing.
* **Delete:** Modal dialog confirmation with instant document deletion from Firestore.

---

## 🛠️ Prerequisites & Setup

Before running this project, ensure you have the following installed:

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.0.0 or higher)
* [Node.js](https://nodejs.org/) (Required for Firebase CLI)
* [Firebase CLI](https://firebase.google.com/docs/cli) (`npm install -g firebase-tools`)
* [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/) (`dart pub global activate flutterfire_cli`)

---

## ⚠️ Important Firebase Configuration Setup

Follow these mandatory setup steps to link your Firebase project before running the app.

### 1. Create a Firebase Project & Firestore Database
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click **Add project** and follow the instructions.
3. In your project overview screen, navigate to **Build** -> **Firestore Database**.
4. Click **Create database**.
5. Choose your security rules mode (for testing/learning, you can start in **test mode**, but remember to set secure rules before production).
6. Select your preferred database region and click **Enable**.

### 2. Configure FlutterFire CLI
Run the FlutterFire configuration command in your project root folder to automatically configure platforms (Android, iOS, Web, macOS):

```bash
flutterfire configure
```

This command will:
* Prompt you to select your Firebase project.
* Ask which target platforms you want to support (Android, iOS, Web, etc.).
* Automatically generate a `lib/firebase_options.dart` file containing your app's specific credentials.

---

## 📦 Project Structure

```text
lib/
├── models/
│   └── transaction_model.dart    # Data model & Firestore serialization
├── services/
│   └── database_service.dart     # Firestore CRUD helper methods
├── screens/
│   ├── home_screen.dart          # READ (All items)
│   ├── add_transaction_screen.dart # CREATE
│   ├── edit_transaction_screen.dart# UPDATE
│   └── detail_screen.dart        # READ (Single item) & DELETE
└── main.dart                     # App initialization & entry point
```

---

## 🏁 Running the App

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run on connected device/emulator:**
   ```bash
   flutter run
   ```

---

## 📂 Firestore Collection Structure

```text
users (collection)
 └── {userId} (document)
      └── transactions (subcollection)
           └── {transactionId} (document)
                ├── title: "Grocery" (String)
                ├── amount: 45.50 (Number)
                ├── type: "expense" (String)
                ├── category: "Food" (String)
                └── date: Timestamp
```
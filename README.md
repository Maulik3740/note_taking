# 📝 Flutter Firebase Notes App

[![Flutter](https://img.shields.io/badge/Flutter-3.13-blue?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)](#)

A **simple and functional note-taking app** built using **Flutter** and **Firebase**, designed to demonstrate clean code, modular structure, and essential CRUD operations with authentication.

---

## 🚀 Features

- ✅ **User Authentication** with Firebase Auth (Sign up / Login)  
- ✅ **Add, Edit, and Delete Notes**  
- ✅ **Notes Stored** in Firebase Firestore  
- ✅ **Display Saved Notes** in a clean and responsive UI  
- ✅ **Search Functionality** for notes 🔍  
- ✅ **Timestamps** for note creation & updates ⏱️  

---

## 🛠️ Tech Stack

- **Frontend:** Flutter  
- **Backend:** Firebase Authentication & Firestore  
- **State Management:** (Provider / Bloc / Riverpod / etc.)  
- **Platform Support:** Android, iOS  

---

## 📸 Screenshots

| Login | Notes List | Edit Notes |
|-------|------------|------------|
| <img width="387" height="825" alt="Screenshot 2025-08-22 at 5 45 01 PM" src="https://github.com/user-attachments/assets/f4cdc782-d197-45da-ba10-415180a95595" /> |  <img width="387" height="825" alt="Screenshot 2025-08-22 at 5 45 26 PM" src="https://github.com/user-attachments/assets/9fbe5dea-5ef4-4e18-96db-68defb7e4df9" /> | <img width="387" height="825" alt="Screenshot 2025-08-22 at 5 45 45 PM" src="https://github.com/user-attachments/assets/80a29d66-be9a-4bb2-be146e46fdc88293" />
 |



> *(Add your screenshots into a `/screenshots` folder in the repo and rename them accordingly.)*

---

## 📦 Installation & Setup

Follow these steps to set up and run the project locally:

1️⃣ **Clone the repository**  
```bash
git clone https://github.com/your-username/flutter-firebase-notes-app.git
cd flutter-firebase-notes-app
2️⃣ Install dependencies

flutter pub get


3️⃣ Configure Firebase

Go to Firebase Console

Create a new Firebase project

Enable Authentication (Email/Password)

Enable Cloud Firestore

Download google-services.json (Android) and place it in:

android/app/


For iOS, add GoogleService-Info.plist in:

ios/Runner/


4️⃣ Run the app

flutter run

📲 APK Download

👉 [Download APK](apk/app-release.apk)


(Upload your built .apk in GitHub Releases or inside an /apk/ folder and link it here.)

📖 Folder Structure
lib/
 ├── models/        # Data models
 ├── services/      # Firebase services (Auth, Firestore)
 ├── screens/       # UI Screens (Login, Notes, Edit)
 ├── widgets/       # Reusable widgets
 └── main.dart      # Entry point

🤝 Contribution

Contributions are welcome!
Feel free to fork the repo and submit a pull request to improve the project.

📜 License

This project is licensed under the MIT License – perfect for learning and personal projects.

✨ Built with ❤️ using Flutter & Firebase


---

✅ Key fixes I applied:  
1. All **commands** (`flutter pub get`, `git clone`) are inside proper **code blocks**.  
2. Numbered steps are **outside the code blocks**.  
3. Extra line breaks and spacing cleaned up so GitHub renders headings, lists, and tables correctly.  

---

If you want, I can also create a **version with even more polished badges** (Flutter version, Firebase, build status, license, last commit) to make it look like a professional open-source project.  

Do you want me to do that next?

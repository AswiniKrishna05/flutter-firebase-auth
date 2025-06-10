# 📱 Flutter Firebase Auth Module
*Intern Task – Login, Signup & Forgot Password Feature*

---

## 🔎 Project Overview

This is a basic user-authentication module built with **Flutter** (front-end) and **Firebase** (back-end). It includes:

1. Signup Page
2. Login Page
3. Forgot Password Page
4. Home Page

---

## 🧩 Features & Task Requirements

### 1. Signup Page
- **UI Fields**:
    - Full Name
    - Email Address
    - Phone Number
    - Password
    - Confirm Password
    - Signup Button

- **Validation Rules**:
    - Email must be valid
    - Password ≥ 6 chars and must match confirmation
    - Phone number must be exactly 10 digits

- **On Success**:
    - Create user via **Firebase Auth**
    - Store Full Name & Phone Number in **Firestore**
    - Navigate to **Login Page**

<details>
  <summary>Screenshots</summary>

![Signup Page](assets/signup.png)  
_Signup with validation and Firebase integration_
</details>

---

### 2. Login Page
- **UI Fields**:
    - Email Address
    - Password
    - Login Button
    - “Forgot Password?” (TextButton)
    - “Signup” (TextButton)

- **Functionality**:
    - Authenticate using **Firebase Auth**
    - Fetch user document from **Firestore** and verify phone number
    - On success → navigate to **Home Page**
    - On failure → show alert: “Entered details are incorrect”

- **Navigation Links**:
    - "Forgot Password?" → **Forgot Password Page**
    - "Signup" → **Signup Page**

<details>
  <summary>Screenshots</summary>

![Login Page](assets/login.png)  
_Login form with error handling and navigation_
</details>

---

### 3. Forgot Password Page
- **UI Elements**:
    - Heading: *Forgot Password*
    - Subtext: *“Enter your registered email to reset your password”*
    - Email Address input
    - Reset Password button
    - “Back to Login” (TextButton)

- **Functionality**:
    - Validate email
    - Send password reset email via **Firebase Auth**
    - Display confirmation: “Reset link sent to your email.”
    - “Back to Login” → **Login Page**

<details>
  <summary>Screenshots</summary>

![Forgot Password](assets/forgot_password.png)  
_Password reset flow with Firebase integration_
</details>

---

### 4. Home Page
- **UI Details**:
    - AppBar Title: *Welcome*
    - Body Text: *Login Successful*

<details>
  <summary>Screenshots</summary>

![Home Page](assets/home.png)  
_Greeting screen after successful login_
</details>

---

## ⚙️ Firebase Setup

1. Go to **Firebase Console** → *Authentication* → *Sign-in Method* → enable **Email/Password**
2. Create a Firestore database (start in test mode for development)
3. Add your app’s `google-services.json` (Android) / `GoogleService-Info.plist` (iOS)
4. Initialize Firebase in your `main.dart`:


---

## 🚀 Getting Started

1. **Clone the repo**
2. Install dependencies:

    ```
    flutter pub get
    ```

3. **Configure Firebase**
4. Run on emulator or physical device:

    ```
    flutter run
    ```

---

## ✅ Acceptance Criteria

- ✅ Responsive pages
- ✅ Complete navigation flow
- ✅ Field validation with user feedback
- ✅ Firebase errors displayed clearly
- ✅ Navigator.push/pop used correctly
- ✅ Sign-up → Login → Forgot Password → Home flows correctly

---

## 📌 Notes & Future Enhancements

- UI uses Material 3 with theming
- Missing features:
    - Profile editing
    - Email verification
    - Improved error handling & localization
    - Unit/integration tests

---

## 🖼️ Screenshots

- `screen_shots/Login%20screen.jpeg`
- `screen_shots/Registration screen.jpeg`
- `screen_shots/Forgot password screen.jpeg`
- `screen_shots/Home screen.jpeg`

---

## 📝 Intern Task Document

**Task Title**: *Flutter + Firebase – Login, Signup, and Forgot Password Functionality*  
**Objective**: Build a Flutter module that includes the above features, using Firebase Auth & Firestore, with proper input validation and navigation flows.

---

Thanks for reviewing this module! Feel free to use this template for future demos or evaluations.

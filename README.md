# BLoC vs Cubit Playground

## 📌 Project Overview

This project is an **educational Flutter application** designed to explore **BLoC and Cubit state management** in a structured and maintainable way.  
The primary goal is to develop a **consistent code style** for both **BLoC** and **Cubit**, ensuring that the state management approach can be switched with **minimal code changes**.

---

## 🎯 Key Objectives

- **Mastering BLoC & Cubit** – Implementing state management with both technologies and understanding their differences.
- **State Switching at Runtime** – Dynamically switching between BLoC and Cubit **without restarting the app**.
- **Reactive UI & State Dependency** – Implementing **cross-state dependencies** (e.g., color state affecting counter state).
- **Factory Pattern for State Management** – Using a **Factory Pattern** to make state manager selection flexible and interchangeable.
- **Consistency & Scalability** – Ensuring the **codebase remains clean, scalable, and easy to maintain**.
- **Advanced Features**:
  - Dependency between **one BLoC/Cubit and another**.
  - Implementing **cross-dependencies** (e.g., a Cubit depending on a BLoC and vice versa).
  - Creating a **hydrated BLoC** for caching.
  - **Navigation with named routes**.
  - **Repository pattern integration**.
  - **Observers for state monitoring**.

---

## 🏗️ Project Structure

- **State Management**:
  - `features/counter/` – Standard counter implementation using **BLoC** and **Cubit**.
  - `features/counter_depends_on_color/` – Counter dependent on color changes.
  - `core/state_managing/` – Global state management logic.
- **Navigation**:
  - `core/config/app_routes.dart` – Centralized routing logic.
  - `core/config/route_names.dart` – Static route name definitions.
- **Utility Functions**:
  - `core/utils/helpers.dart` – Helper functions, including a **shortcut for navigation**.

---

## 🚀 How It Works

### 1️⃣ **Switching State Management Dynamically**

- The app starts with **either BLoC or Cubit** (default: **BLoC**).
- You can **switch state management at runtime** without losing stored states.
- Two separate instances of the counter exist for **BLoC and Cubit**, maintaining **state consistency** when switching.

### 2️⃣ **Cross-State Dependencies**

- The **counter value is affected by color changes**:
  - **Red → +1**
  - **Green → +10**
  - **Blue → +100**
  - **Black → -100**
- This logic is implemented using **stream subscriptions** inside the state managers.

### 3️⃣ **Factory Pattern for Flexibility**

- Instead of **hardcoding state managers**, the app **uses a factory** to determine which one should be used.
- This means switching from Cubit to BLoC (or vice versa) **takes only a few lines of code**.

---

## 📌 Tech Stack

- **Flutter**
- **Dart**
- **flutter_bloc** (BLoC & Cubit)
- **SharedPreferences** (for state persistence)
- **Material Design 3**

---

## 🛠️ Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/RamanGodun/BLoC-vs-CUBIT-playground-app-

   ```

2. Install dependencies:
   flutter pub get

## 📖 Learning Outcomes

By working with this project, you will:
✅ Learn when to use BLoC vs. Cubit
✅ Understand state dependencies and stream subscriptions
✅ Use the Factory Pattern for state management abstraction
✅ Implement navigation with named routes
✅ Explore state persistence and caching
✅ Follow a clean and scalable architecture

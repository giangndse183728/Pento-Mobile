📱 Pento – Smart Household Food Management System (Mobile)

Pento Mobile is a smart household food management mobile application designed and developed to support daily household workflows such as tracking, organizing, planning, and exchanging food efficiently.

This project was built as a client capstone project, focusing on practical real-world use cases, clean architecture, and seamless integration with external services.

🎯 Project Objectives

Build a production-oriented mobile frontend for smart food management

Solve real-life household problems with intuitive mobile interactions

Apply MVVM architecture for scalability and maintainability

Integrate third-party services for scanning, location, and notifications

🚀 Core Features
📸 Smart Scanning & Input

OCR-based food scanning from receipts

Barcode scanning for quick product entry

📦 Food Management

Track food quantity, categories, and expiration dates

Kanban-style board to visualize food lifecycle stages

🍽️ Meal Planning & Recipes

Meal Planning: Create daily and weekly meal plans based on available food

Recipe Management: Browse, save, and match recipes with current ingredients

Reduce food waste by suggesting meals using expiring items

🗺️ Discovery & Community

Nearby Store Discovery using real-time location

Food Trading between households to share surplus food

🔔 Real-time Sync & Notifications

Real-time data synchronization

Push notifications for expiring food, meal reminders, and trading updates

🎨 Mobile UX & Interaction

Smooth and intuitive mobile experience

Illustration-based UI with liquid glass–inspired visual elements

Designed for clarity, usability, and daily repetitive interactions

Optimized for both Android and iOS platforms

🔗 Integration & Data Flow

Integrated with backend services to enable:

Real-time data synchronization

Notifications and alerts

Seamless interaction between scanning, management, meal planning, and trading features

🧠 Architecture Overview (MVVM)

The application follows the MVVM (Model – View – ViewModel) architecture:

Model: Immutable data models (Freezed, JSON Serializable)

View: Flutter UI widgets

ViewModel: Business logic and state management using Riverpod

This approach ensures:

Clear separation of concerns

High testability

Easier feature scaling and maintenance

🛠️ Tech Stack (Mobile)
Framework

Flutter – Cross-platform mobile development

Libraries & Packages

Riverpod – State management (ViewModel layer)

Flutter Hooks – Cleaner widget logic

Dio – HTTP client

GoRouter – Declarative navigation

Freezed – Immutable models & union types

JSON Serializable – Data serialization

Flutter Secure Storage – Secure local storage

Mobile Scanner – Barcode & QR scanning

SignalR (signalr_netcore) – Real-time communication

Google Maps Flutter – Map rendering

Geolocator – Device location services

Image Picker – Image selection & capture

Cached Network Image – Optimized image loading

FL Chart – Charts & analytics

☁️ Third-Party Services

Firebase Cloud Messaging (FCM) – Push notifications

Google Maps Platform – Maps, geocoding, and places

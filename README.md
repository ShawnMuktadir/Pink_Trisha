# Pink by Trisha

A cross platform e commerce mobile application built with Flutter, developed end to end including UI, state management, authentication, and checkout flow. This project reached a fully working staged build. It was not published to the app stores because the client paused the project for business reasons unrelated to the engineering work.

## Overview

Pink by Trisha is a retail shopping application covering the full customer journey: browsing products, managing a cart, checking out, and managing an account. The project targets Android, iOS, and Web from a single Flutter codebase.

## Platforms

* Android
* iOS
* Web
* Windows
* macOS
* Linux

## Tech Stack

* **Framework:** Flutter (Dart)
* **State Management:** Riverpod, using StateNotifierProvider and StateNotifier, organized in a controller, model, and views structure per feature module
* **Authentication:** Firebase Auth, Google Sign In
* **Networking:** Dio
* **Payments:** SSL Commerz payment gateway integration
* **Maps and Location:** Google Maps Flutter
* **Local Storage:** Shared Preferences
* **Media and UI:** Cached Network Image, Shimmer loading states, Flutter SVG, Carousel Slider, Flutter ScreenUtil for responsive layout
* **Other:** Connectivity Plus for network state handling, Package Info Plus, Device Info Plus, Image Picker

## Architecture

The codebase is organized by feature module, with each module split into:

* `model` for data and state classes
* `controller` for business logic built on Riverpod StateNotifier
* `views` for the UI layer, with reusable pieces under `components`

Shared UI elements, network handling, and utilities live under `global` and `data_provider` so feature modules stay focused on their own logic.

## Key Features

* Email and Google sign in, sign up, and password recovery
* Product browsing with categories, search, and filtering
* Product detail pages with related product suggestions
* Cart, shipping address, and payment option management
* Order summary, order confirmation, and order history
* Wishlist
* Account management including profile, addresses, and settings

## Project Status

This is a staged, working build from a client engagement. It is shared here as a portfolio reference to demonstrate architecture and implementation, not as a live production product.

## Getting Started

This project requires the Flutter SDK. To run it locally:

```
flutter pub get
flutter run
```

Firebase configuration files are required for the authentication features to work and are not included in this repository.

## Author

Md Muktadir
[linkedin.com/in/shawnmuktadir](https://linkedin.com/in/shawnmuktadir)
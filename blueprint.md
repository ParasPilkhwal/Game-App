# Project Blueprint

## Overview

This project is a Flutter application with Firebase authentication. It includes screens for Home, Login, and Signup. The goal is to develop a game app with features like a leaderboard and settings.

## Implemented Features

- Firebase Authentication (Login and Signup screens)
- Basic navigation between screens (Home, Login, Signup)
- Bottom Navigation Bar in `MyHomePage` for Game, Leaderboard, and Settings sections.

## Plan for Current Change: Navigate to MyHomePage after Login

- **Goal:** Ensure the user is navigated to `MyHomePage` after a successful login to display the BottomNavigationBar.
- **Steps:**
  1. Modify the `goRouter` configuration in `lib/router.dart` to redirect to `/` (which now corresponds to `MyHomePage`) when the user is authenticated and tries to access `/login` or `/signup`.

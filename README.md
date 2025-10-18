# User Directory App

A Flutter-based User Directory application built using the **MVVM architecture**, **GetX** for state management, and **Material 3** design. This app fetches user data from the [RandomUser API](https://randomuser.me/) and supports search, filtering, sorting, pagination, and robust state handling.

---

## Features

- MVVM Architecture: Cleanly separated concerns for maintainability and scalability
- GetX State Management: Lightweight and powerful for managing state and navigation
- Material 3 UI: Modern, responsive, and adaptive interface
- RandomUser API Integration: Fetches paginated user data
- Infinite Scrolling: Loads more users automatically as you scroll
- Search Functionality: Local search by first or last name
- Pull to Refresh: Reloads the user list manually
- Client-side Sorting: Alphabetical A-Z and Z-A sorting
- Gender Filtering: API-driven filter for male and female users
- Error Handling: Graceful display of error messages for failed states
- No Internet Handling: Dedicated UI state when offline
- Loading Indicators: For all asynchronous operations
- Detail Screen: Full user info with profile image, email, phone, location, date of birth and age
- Light/dark mode: Light and dark themes for better user experience

---

## Architecture Overview

This project follows the **Model-View-ViewModel (MVVM)** architecture to separate UI from business logic and data manipulation:

- **Model**: Represents the user data structure fetched from the API
- **View**: UI components built using Flutter widgets and Material 3 design
- **ViewModel**: Uses GetX Controllers to manage and expose data/state to the UI

---

## Tech Stack

| Category            | Technology                                          |
|---------------------|-----------------------------------------------------|
| Framework           | Flutter                                             |
| Architecture        | MVVM                                                |
| State Management    | GetX                                                |
| UI Kit              | Material 3 (M3)                                     |
| API                 | RandomUser API                                      |
| Networking          | `http` package                                      |
| Additional Features | Null safety, Responsive layout, Centralized theming |

---

## API Reference

- Base URL: `https://randomuser.me/api/`
- Example endpoint:  
  `https://randomuser.me/api/?page=1&results=20&gender=male`

Supported query parameters:

- `page`: Pagination index
- `results`: Number of users per page
- `gender`: male or female

---
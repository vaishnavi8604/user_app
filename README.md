Employee Directory App (Flutter + GetX)
This Flutter app displays a paginated list of employees from a mock API. It uses GetX for state management, handles loading and error states, and stores the last viewed employee using SharedPreferences.

How to Run the App
Clone the repository:
git clone https://github.com/vaishnavi8604/user_app.git
cd user_app
Install dependencies:

Approach
1. Pagination
   Used a ScrollController to detect when the user scrolls near the bottom of the list.

Fetched more data when the scroll offset reaches the end of the list.

Maintained currentPage and hasMoreData flags to control API calls and avoid unnecessary requests.

2. State Management
   Used GetX for:

Reactive UI updates (Obx for observing changes).

Managing employee list, loading state, error handling, and pagination logic in a single controller (EmployeeController).

3. Local Storage
   Used SharedPreferences to persist the last viewed employee.

On app restart, it reads from local storage and displays the last user on the top of the list.
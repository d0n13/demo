# Node Login App

This is a simple Node.js application that implements a versioned API for user authentication. It validates users against mock data and assigns privileges based on user roles.

## Project Structure

```
node-login-app
├── src
│   ├── controllers
│   │   └── authController.ts
│   ├── routes
│   │   └── v1
│   │       └── authRoutes.ts
│   ├── middleware
│   │   └── authMiddleware.ts
│   ├── models
│   │   └── userModel.ts
│   ├── app.ts
│   └── types
│       └── index.ts
├── package.json
├── tsconfig.json
└── README.md
```

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```
   cd node-login-app
   ```

3. Install the dependencies:
   ```
   npm install
   ```

4. Start the application:
   ```
   npm start
   ```

## API Usage

### Login

- **Endpoint:** `POST /api/v1/login`
- **Request Body:**
  ```json
  {
    "username": "user",
    "password": "password"
  }
  ```
- **Response:**
  - **200 OK**: Login successful
  - **401 Unauthorized**: Invalid username or password

## License

This project is licensed under the MIT License.
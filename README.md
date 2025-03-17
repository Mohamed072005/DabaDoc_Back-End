# SocialQ Backend

SocialQ is a community-based question and answer platform that connects users with people in their local area. This repository contains the backend API built with Ruby on Rails 8.0.2 and MongoDB.

## 📋 Overview

The SocialQ backend provides the following functionality:
- User authentication (registration and login)
- Question creation and retrieval
- API endpoints for the frontend application

## ⚙️ Tech Stack

- Ruby on Rails 8.0.2
- MongoDB with Mongoid ODM
- JWT for authentication
- BCrypt for password hashing
- Rack CORS for handling Cross-Origin Resource Sharing

## 🚀 Getting Started

### Prerequisites

- Ruby 3.2.0 or higher
- MongoDB 6.0 or higher
- Bundler

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Mohamed072005/DabaDoc_Back-End.git
cd DabaDoc_Back-End
```

2. Install dependencies:
```bash
bundle install
```

3. Configure MongoDB:
    - Create a `config/mongoid.yml` file with your MongoDB configuration
    - Example configuration:
   ```yaml
   development:
     clients:
       default:
         uri: mongodb://localhost:27017/dabadoc_test_development
   
   test:
     clients:
       default:
         uri: mongodb://localhost:27017/dabadoc_test_test
   
   production:
     clients:
       default:
         uri: <%= ENV['MONGODB_URI'] %>
   ```

4. Set up Rails credentials:
   - The application uses Rails' built-in credentials system for storing secrets
   - The JWT secret key is accessed through `Rails.application.credentials.secret_key_base`
   - To edit credentials in development with VSCode, run:
     ```bash
     EDITOR="code --wait" rails credentials:edit
     ```
   - For other editors, replace "code" with your editor's command
   - Make sure your master key is stored safely in `config/master.key` or set as `RAILS_MASTER_KEY` environment variable

5. Start the server:
```bash
rails server
```

6. The API will be available at `http://localhost:3000`

## 🔄 API Endpoints

### Authentication

#### Register a new user
```
POST /auth/register
```
Request body:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

#### Login
```
POST /auth/login
```
Request body:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```
Response:
```json
{
  "token": "jwt_token_here",
  "user": {
    "id": "user_id",
    "email": "user@example.com"
  }
}
```

### Questions

#### Create a new question
```
POST /question/create
```
Headers:
```
Authorization: Bearer jwt_token_here
```
Request body:
```json
{
  "title": "Question title",
  "content": "Question content",
  "location": {
    "latitude": 37.7749,
    "longitude": -122.4194
  }
}
```

#### Get questions
```
GET /question/get/questions?page=1&perPage=10
```
Query parameters:
- `page`: Page number (default: 1)
- `perPage`: Number of questions per page (default: 5)

Response:
```json
{
  "data": {
    "questions": [
      {
        "id": "question_id",
        "title": "Question title",
        "content": "Question content",
        "created_at": "2025-03-17T12:00:00Z",
        "user": {
          "id": "user_id",
          "email": "user@example.com"
        },
        "likes": [],
        "answers": []
      }
    ],
    "total_pages": 5,
    "total_count": 25
  }
}
```

## 🏗️ Project Structure

```
app/
├── controllers/
│   ├── concerns /
│   │   └── authenticate_request.rb    # a Guard for check the jwt token
│   ├── application_controller.rb
│   ├── auth_controller.rb             
│   ├── question_controller.rb          
│   ├── like_controller.rb             
│   └── answer_controller.rb           
├── models/
│   ├── user.rb                       
│   ├── like.rb                        
│   ├── answer.rb                      
│   └── question.rb                    
├── repositories
│   ├── question_repository.rb
│   └── user_repository.rb
├── services/
│   ├── auth_service.rb
│   ├── jwt_service.rb
│   ├── service_result.rb             # manage the response format
│   └── question_service.rb
config/
├── application.rb
├── mongoid.yml
└── routes.rb
```

## 🛡️ Authentication

The application uses JWT (JSON Web Tokens) for authentication:

1. When a user registers or logs in, a JWT token is generated
2. The token must be included in the Authorization header for protected routes
3. The `ApplicationController` verifies the token and sets the current user

## 🔧 Development

### Running the Development Server

```bash
rails server
```

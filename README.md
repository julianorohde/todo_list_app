# README

## Coding Task - Kadince

Developed by [Juliano Rohde](https://www.linkedin.com/in/julianorohde/).

## Accessing the App

### Hosted on Heroku

You can access the app directly via Heroku: https://todo-list-app-e8ecbac54fce.herokuapp.com/

### Running locally with Docker

To run the app locally using Docker, follow these steps:

1. Install Docker on your system;
2. Clone the repository: 
```
git clone https://github.com/julianorohde/todo_list_app.git
```
3. Build and run the Docker containers:
```
docker compose up -d --build
```
4. Run the database migrations:
```
docker compose exec web bash -c "rails db:drop && rails db:create && rails db:migrate"
```
5. Access the app at: `http://localhost:3000`.

## Using the App

1. **Sign up:** first, create an account to access the app.

2. **Manage To-Do Items:**
* Create, edit, delete, and complete (mark as done) your to-do items;
* Filter to-dos by status: pending, completed, or view all.

## Deployment and CI/CD

**Automatic deployment:** The app is configured for automatic deployment to Heroku whenever a merge is made into the `main` branch.

**Test validation:** Merges into `main` are only allowed if the test suite passes successfully in the CI/CD pipeline.

## Test Coverage

This app has 100% test coverage using **Rails MiniTest**, ensuring reliability and high-quality functionality across all features.

# GithubExercise.Umbrella

### Notes
Per the instructions, I've generated an umbrella app with a reusable "backend" that contains the business logic and API
logic and generates a view model which our "frontend" (which is purely presentation logic) can consume. 

I did TDD to drive all the implementation logic for this exercise.

### Caveats
- So far as I can tell repos can't have followers, so I've shown watchers instead as those are a similar concept

- Beware GitHub limits API requests to 60 requests an hour. This isn't too hard to hit by using the application and 
running the tests. This would need to be fixed by adding authentication for a production application, but seem excessive
for this simple exercise. 

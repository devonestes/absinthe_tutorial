# BlogPost tester

Start the server with the included bash script `start.sh`.

GraphiQL is at `localhost:4000/api/graphiql`.

Since the subscriptions are on `user_id`, I made it so there's always two users with ID 1 and 2.
No need to create the users first - they'll always be there.

For the subscriptions you'll need Postgres running on the default port `5432` since that's what's
used for the pub-sub. The data for posts isn't persisted, though, so if you shut down the app
you'll clear the data (except for the two users who are always there).

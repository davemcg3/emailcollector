# emailcollector
Just a quick and dirty email collector running on rails 6

## Important routes
`/users/new`  register a new user

Make an admin on the command line

`rails c`

```
u = User.find(1) # Use any rails find method
u.admin=true
u.save
```

`/logout` Log out of the session

`/login` Create a new session

Now you'll have an admin menu that you can use to navigate around the admin portions of the app, checking the list of all collected emails and the list of all users.

## Check Lint

`rubocop`

auto-fix lint

`rubocop -a`


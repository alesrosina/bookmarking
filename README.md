This is a very simple Rails project for storing bookmarks. Application is quite bare-boned, but the purpose of it is to showcase a simple Rails application.

## Init

It is standard Rails project, so for running it you need:

 - Ruby 2.4
 - Rails 5
 - Postgres DB

After that, run normal rails commands:
```
  $ bundle install
  $ rake db:setup
  $ rake db:migrate
```

Project is using [dotenv](https://github.com/bkeepers/dotenv) for simulating environmental variables. You can see all the variables you need to set in `.env.sample` file.

For getting screen capture images, you need to register at http://www.page2images.com/ and acquire **Direct Linking API Key**. This key is then set to `PAGE2IMAGES_API` environmental variable.

Run project with:

```
  $ rails server
```

And go to `http://localhost:3000`.

## Tests

Project is using [rspec-rsils](https://github.com/rspec/rspec-rails), so for running tests use:

```
  $ bundle exec rspec
```

## Deployment

Project is deployed to Heroku via automatic deploys from `master` branch, so no deployment scripts are necessary.

Project can be found at: http://bookmarking-demo.herokuapp.com/

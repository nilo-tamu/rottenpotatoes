web: bundle exec rails server -p $PORT
release: heroku pg:reset DATABASE
release: rails db:migrate
release: rails db:seed
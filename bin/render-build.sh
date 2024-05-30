#!/usr/bin/env bash
# exit on error
set -o errexit


bundle install
sed -i '1s|.*|#!/usr/bin/env ruby|' bin/*
chmod +x bin/*
bundle exec rails db:migrate
#bundle exec rails assets:precompile
#bundle exec rails assets:clean
# SuggestMovie

Weekly project from [https://weeklyproject.club/](https://weeklyproject.club/) (week 16 2020)

A simple app if you don't know what to watch.
You can add and remove movies to your personal list.

## Installation

1. install Docker 19.03 or higher
1. cp .env.template .env
1. manually configure .env to your needs (optional)
1. docker-compose up --detach --build
1. docker exec --interactive --tty smovie_webserver /app/migrate_database.sh
1. open [http://localhost:5000](http://localhost:5000) (if you haven't changed Port in .env)

## Original Requirements

Timmy is hanging out at home, and is crazy bored. The thing to do at the moment is binge watch a bunch of tv shows and movies, but it's so hard to pick what show to watch. Lately, Timmy has been spending more time trying to pick something to watch than actually watching something!
Build something that will help them pick something good!
Make an app that can:

1. Accept entries for movies or tv shows that they like to watch
1. pick a show at random to watch

If you want to go the extra mile:

1. Build in a list of shows to watch so people don't have to enter shows in by hand
1. Ask people questions about what they are feeling right now to decide something that fits with their vibe.

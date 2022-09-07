##### API DOC

https://documenter.getpostman.com/view/2025931/VVBUx6ga#4bbe8609-806c-4f05-82c3-56dea51b7a00

##### Prerequisites

The setups steps expect following tools installed on the system.

- Ruby [3.0.1]
- Rails [Rails 6.1.6.1]
- Postgres(Optional)
- Docker/Docker-Compose (Optional)
##### 1. Check out the repository

```bash
git clone https://github.com/LouizFs/petal-challenge.git
```

##### 2. Setup Project

Run bundle

```bash
bundle install
```

##### 3. Create and setup the database

You can up a container of postgres running:

```bash
  docker-compose up --build
```

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
bundle exec rake db:seed
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

##### 4. Run tests

You can start the rails server using the command given below.

```bundle
bundle exec rspec
```

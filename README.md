# Backend

To start your Phoenix server for local development:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

To start your Dockerized Phoenix server and Deploy:

- Start Docker Container with `docker compose -f docker-compose.build.yml build && docker compose -f docker-compose.build.yml up`
- To deploy with Travis CI push your changes to git@github.com:RamyFerhat59/timemanager.git
  Now you can visit [`0.0.0.0:4000`](http://0.0.0.0:4000) from your browser locally,
  When deployed visit [`aws load balancer dns name`]

## Database

<img src="static/mcd.png" alt="mcd" width="500"/>

## Routes

### **1. Users**

| Http Methods | Routes         | Description                                         | Parameters                            | Body example                                                         |
| ------------ | -------------- | --------------------------------------------------- | ------------------------------------- | -------------------------------------------------------------------- |
| GET          | /api/users     | Get all users or get one user by username and email | username (optional), email (optional) | -                                                                    |
| GET          | /api/users/:id | Get user by id                                      | -                                     | -                                                                    |
| POST         | /api/users     | Create user                                         | -                                     | { "user": { "username": "Thomas", "email": "thomascgz@gmail.com" } } |
| PUT          | /api/users/:id | Update user by id                                   | -                                     | { "user": { "username": "greg", "email": "test2@test.fr" } }         |
| DELETE       | /api/users/:id | Delete user by id                                   | -                                     | -                                                                    |

### **2. Clocks**

| Http Methods | Routes              | Description                                                                                                | Parameters | Body example |
| ------------ | ------------------- | ---------------------------------------------------------------------------------------------------------- | ---------- | ------------ |
| GET          | /api/clocks/:userId | Get the user's clock by its id                                                                             | -          | -            |
| POST         | /api/clocks/:userId | Post clock or update time and status of the clock. If status is update to false, it creates a working time | -          | -            |

### **3. Workingtimes**

| Http Methods | Routes                        | Description                                 | Parameters | Body example                                                                        |
| ------------ | ----------------------------- | ------------------------------------------- | ---------- | ----------------------------------------------------------------------------------- |
| GET          | /api/workingtimes/:userId     | Get user's workingtimes between 2 datetimes | start, end | -                                                                                   |
| GET          | /api/workingtimes/:userId/:id | Get workingtime by id and user id           | -          | -                                                                                   |
| POST         | /api/workingtimes/:userId     | create a workingtime for a user             | -          | { "workingtime": { "start": "2021-10-26T00:00:00", "end": "2021-10-26T23:00:00" } } |
| PUT          | /api/workingtimes/:id         | update workingtime by id                    | -          | { "workingtime": { "start": "2021-10-26T08:03:07" } }                               |
| DELETE       | /api/workingtimes/:id         | delete workingtime by id                    | -          | -                                                                                   |

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

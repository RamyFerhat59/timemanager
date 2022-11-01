FROM elixir:1.14

RUN apt-get update && apt-get install -y postgresql-client 

WORKDIR /app/backend

COPY . .

RUN MIX_ENV=prod mix local.hex --force

RUN MIX_ENV=prod mix local.rebar --force

RUN mix deps.get --only prod

RUN MIX_ENV=prod mix compile

RUN chmod +x ./entrypoint.sh

CMD ["./entrypoint.sh"]

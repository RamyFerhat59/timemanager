FROM elixir:1.14

RUN apt-get update && apt-get install -y postgresql-client 

WORKDIR /backend

COPY ./config ./
COPY ./deps ./
COPY ./lib ./
COPY ./priv ./
COPY ./test ./ 
COPY ./mix.exs ./
COPY ./mix.lock ./
COPY ./entrypoint_release.sh ./
COPY ./rel ./

ENV MIX_ENV=prod

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix deps.get --only prod

COPY config/config.exs config/prod.exs config/

RUN mix compile

RUN mix deps.compile 

RUN mix release 

RUN chmod +x ./entrypoint_release.sh

CMD ["./entrypoint.sh"]

FROM elixir:1.14

WORKDIR /backend

COPY ./ ./

ENV MIX_ENV=prod

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix deps.get --only prod

COPY config/config.exs config/prod.exs config/

RUN mix compile

RUN chmod +x ./entrypoint.sh

CMD ["./entrypoint.sh"]

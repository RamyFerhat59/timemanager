FROM elixir:alpine

WORKDIR /app/backend

COPY . .

RUN mix local.hex --force

RUN mix deps.get

EXPOSE 4000

CMD ["mix", "ecto.setup"]; ["mix", "phx.server"]
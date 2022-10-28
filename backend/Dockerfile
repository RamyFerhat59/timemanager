FROM elixir:alpine

WORKDIR /app

COPY . .

RUN mix local.hex --force

RUN mix ecto.setup

EXPOSE 5173

CMD ["mix", "phx.server"]
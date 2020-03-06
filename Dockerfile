FROM hexpm/elixir:1.10.0-erlang-22.2.4-alpine-3.11.3 as builder

RUN apk add --no-cache make gcc libc-dev git

ENV MIX_ENV=dev
ENV DATABASE_URL=ecto://postgres:postgres@db/blog_dev

WORKDIR /app

# Port for http
EXPOSE 4000

RUN mix do local.hex --force, local.rebar --force

COPY . .

RUN mix deps.get
CMD sleep 2 && mix ecto.create && mix ecto.migrate && mix phx.server

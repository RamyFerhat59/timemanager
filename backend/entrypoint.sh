#!/bin/bash

MIX_ENV=prod mix ecto.setup
MIX_ENV=prod mix phx.server

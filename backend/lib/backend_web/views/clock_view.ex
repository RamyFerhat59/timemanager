defmodule BackendWeb.ClockView do
  use BackendWeb, :view
  alias BackendWeb.ClockView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{
      id: clock.id,
      status: clock.status,
      time: clock.time,
      user: clock.user
    }
  end
end

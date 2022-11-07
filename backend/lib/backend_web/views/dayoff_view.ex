defmodule BackendWeb.DayoffView do
  use BackendWeb, :view
  alias BackendWeb.DayoffView

  def render("index.json", %{daysoff: daysoff}) do
    %{data: render_many(daysoff, DayoffView, "dayoff.json")}
  end

  def render("show.json", %{dayoff: dayoff}) do
    %{data: render_one(dayoff, DayoffView, "dayoff.json")}
  end

  def render("dayoff.json", %{dayoff: dayoff}) do
    %{
      id: dayoff.id,
      start: dayoff.start,
      end: dayoff.end,
      type: dayoff.type,
      user: dayoff.user
    }
  end
end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Plotlyve.Repo.insert!(%Plotlyve.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias PlotlyveWeb.DashboardLive.Utils
alias Plotlyve.Accounts

[
  "iris.csv",
  "2014_usa_states.csv",
  "2011_february_us_airport_traffic.csv",
  "26k-consumer-complaints.csv",
  "2014_ebola.csv",
  "2014_us_cities.csv",
  "diabetes-vid.csv"
]
|> Utils.fetch_csv_files()

[
  %{email: "john.doe@example.com", password: "Qwerty123!Secure"},
  %{email: "jane.smith@example.com", password: "Password$456!Safe"},
  %{email: "alice.jones@example.com", password: "Alice789#Secure"},
  %{email: "bob.brown@example.com", password: "Secure@101!Strong"},
  %{email: "charlie.davis@example.com", password: "Davis*202#Strong"},
  %{email: "diana.evans@example.com", password: "Evans#303!Secure"},
  %{email: "frank.harris@example.com", password: "Frank@404!Safe123"},
  %{email: "grace.johnson@example.com", password: "Grace$505!Strong1"},
  %{email: "henry.kim@example.com", password: "Kim#606!Secure123"},
  %{email: "isabella.lee@example.com", password: "Lee@707!Strong789"}
]
|> Enum.each(&Accounts.register_user/1)

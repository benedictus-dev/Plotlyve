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

datasetname =
  [
    "2014_usa_states.csv",
    "2011_february_us_airport_traffic.csv",
    "26k-consumer-complaints.csv",
    "Antibiotics.csv",
    "iris.csv",
    "carshare.csv",
    "2014_ebola.csv",
    "2014_us_cities.csv",
    "diabetes-vid.csv"
  ]
  |> Utils.fetch_csv_files()

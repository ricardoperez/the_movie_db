use Mix.Config
# You can configure for your application as:
#
#     config :the_movie_db, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:the_movie_db, :key)
#
config :the_movie_db, [
  url: System.get_env("MOVIE_DB_API_URL") || "https://api.themoviedb.org",
  version: System.get_env("MOVIE_DB_API_VERSION") || "3",
  api_key: System.get_env("MOVIE_DB_API_KEY"),
  access_token: System.get_env("MOVIE_DB_ACCESS_TOKEN")
]

defmodule TheMovieDb do
  @moduledoc """
  TheMovieDb API wrapper
  """

  @doc """
  Text-based search for movies, returns a map with search result.

  ## Example

      iex> TheMovieDb.search("Jack Reacher")
      %{"page" => 1,
        "results" => [%{"adult" => false,
        "backdrop_path" => "/ezXodpP429qK0Av89pVNlaXWJkQ.jpg",
        "genre_ids" => [80, 18, 53], "id" => 75780, "original_language" => "en",
        "original_title" => "Jack Reacher"}]}
  """
  def search(query) do
    path = "#{api_version()}/search/movie"
    make_request(path, %{query: query})
  end

  @spec make_request(String.t, map) :: map
  def make_request(path, params \\ %{}) do
    query_string =
      params
      |> Map.merge(%{api_key: api_key()})
      |> URI.encode_query()

    api_url()
    |> URI.merge("#{path}?#{query_string}")
    |> to_string
    |> HTTPoison.get!
    |> parse_body
  end

  @spec api_url :: String.t
  def api_url do
    Application.get_env(:the_movie_db, :url)
  end

  @spec api_version :: String.t
  def api_version do
    Application.get_env(:the_movie_db, :version)
  end

  @spec api_key :: String.t
  def api_key do
    Application.get_env(:the_movie_db, :api_key)
  end

  defp parse_body(%{body: body, status_code: 200}) do
     Poison.decode!(body)
  end

  defp parse_body(%{status_code: _}) do
     "Error fetching data"
  end
end

defmodule TheMovieDb.Movies do
  @moduledoc """
  Interface for Movies API.

  Check The Movie DB [Movies API documentation](https://developers.themoviedb.org/3/movies) for more information.
  """

  import TheMovieDb

  @spec get_details(integer) :: map
  def get_details(id) do
    path = "#{api_url()}/#{api_version()}/movie/#{id}"
    make_request(path)
  end

  def get_credits(movie_id) do
    path = "#{api_url()}/#{api_version()}/movie/#{movie_id}/credits"
    make_request(path)
  end

  defp make_request(path) do
    query_string = URI.encode_query(%{api_key: api_key()})

    api_url()
    |> URI.merge("#{path}?#{query_string}")
    |> to_string
    |> HTTPoison.get!
    |> parse_response
  end

  defp parse_response(%{body: body}) do
     Poison.decode!(body)
  end
end

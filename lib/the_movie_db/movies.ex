defmodule TheMovieDb.Movies do
  @moduledoc """
  Interface for Movies API.

  Check The Movie DB [Movies API documentation](https://developers.themoviedb.org/3/movies) for more information.
  """
  import TheMovieDb

  @doc """
  Get movie by ID.
  """
  @spec get_details(integer) :: map
  def get_details(id) do
    path = "#{api_url()}/#{api_version()}/movie/#{id}"
    make_request(path)
  end

  @doc """
  Get movie credits, cast and crew, by the movie ID.
  """
  @spec get_credits(integer) :: map
  def get_credits(movie_id) do
    path = "#{api_url()}/#{api_version()}/movie/#{movie_id}/credits"
    make_request(path)
  end

  @doc """
  Get the full details for a movie, which includes actors and directors.
  """
  def full_movie_details(movie_id) do
     movie_task = Task.async(fn -> get_details(movie_id) end)
     credit_task = Task.async(fn -> get_credits(movie_id) end)
     present_movie_with_actor(Task.await(movie_task), Task.await(credit_task))
  end


  defp present_movie_with_actor(movie, credits) do
    %{
      original_title: movie["original_title"],
      actors: Enum.map(credits["cast"], &present_person/1)
    }
  end

  defp present_person(person) do
    %{
      order: person["order"],
      name: person["name"],
      character: person["character"],
      image: person["profile_path"]
    }
  end
end

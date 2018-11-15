defmodule VueSample.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias VueSample.Repo

  alias VueSample.Content.Bost

  @doc """
  Returns the list of bosts.

  ## Examples

      iex> list_bosts()
      [%Bost{}, ...]

  """
  def list_bosts do
    Repo.all(Bost)
  end

  @doc """
  Gets a single bost.

  Raises `Ecto.NoResultsError` if the Bost does not exist.

  ## Examples

      iex> get_bost!(123)
      %Bost{}

      iex> get_bost!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bost!(id), do: Repo.get!(Bost, id)

  @doc """
  Creates a bost.

  ## Examples

      iex> create_bost(%{field: value})
      {:ok, %Bost{}}

      iex> create_bost(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bost(attrs \\ %{}) do
    %Bost{}
    |> Bost.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bost.

  ## Examples

      iex> update_bost(bost, %{field: new_value})
      {:ok, %Bost{}}

      iex> update_bost(bost, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bost(%Bost{} = bost, attrs) do
    bost
    |> Bost.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Bost.

  ## Examples

      iex> delete_bost(bost)
      {:ok, %Bost{}}

      iex> delete_bost(bost)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bost(%Bost{} = bost) do
    Repo.delete(bost)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bost changes.

  ## Examples

      iex> change_bost(bost)
      %Ecto.Changeset{source: %Bost{}}

  """
  def change_bost(%Bost{} = bost) do
    Bost.changeset(bost, %{})
  end

#	def list_bosts do
#		Repo.all(Bost)
#	end
end

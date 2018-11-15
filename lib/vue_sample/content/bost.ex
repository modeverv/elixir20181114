defmodule VueSample.Content.Bost do
  use Ecto.Schema
  import Ecto.Changeset


  schema "bosts" do
    field :body, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(bost, attrs) do
    bost
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end

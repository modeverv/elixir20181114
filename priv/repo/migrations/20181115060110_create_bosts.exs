defmodule VueSample.Repo.Migrations.CreateBosts do
  use Ecto.Migration

  def change do
    create table(:bosts) do
      add :title, :string
      add :body, :text

      timestamps()
    end

  end
end

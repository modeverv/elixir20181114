defmodule VueSampleWeb.Schema.ContentTypes do
	use Absinthe.Schema.Notation

	object :bost do
		field :id, :id
		field :title, :string
		field :body, :string
	end
end


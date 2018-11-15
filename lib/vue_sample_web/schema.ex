defmodule VueSampleWeb.Schema do
	use Absinthe.Schema
	import_types VueSampleWeb.Schema.ContentTypes

	alias VueSampleWeb.Resolvers

	query do
		@desc "Get all bosts"
		field :bosts,list_of(:bost) do
			resolve &Resolvers.Content.list_bosts/3
		end
	end
end


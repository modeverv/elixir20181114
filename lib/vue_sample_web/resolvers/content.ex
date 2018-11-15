defmodule VueSampleWeb.Resolvers.Content do
	def list_bosts(_parent, _args, _resolution) do
		{:ok, VueSample.Content.list_bosts()}
	end
end


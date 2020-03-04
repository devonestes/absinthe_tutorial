defmodule BlogWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  alias BlogWeb.Resolvers

  @desc "A user of the blog"
  object :user do
    field :id, :id
    field :name, :string
    field :posts, list_of(:post) do
      resolve &Resolvers.Content.list_posts/3
    end
  end
end

defmodule BlogWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  @desc "A blog post"
  object :post do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user, non_null(:user)
  end

  input_object :post_params do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user_id, non_null(:id)
  end
end

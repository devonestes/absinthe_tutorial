defmodule BlogWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  @desc "A blog post"
  object :post do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user, non_null(:user)
  end

  interface :post_event do
    field :id, non_null(:id)

    resolve_type(fn
      %{operation: :created}, _ -> :post_created
      %{operation: :updated}, _ -> :post_updated
      %{operation: :deleted}, _ -> :post_deleted
    end)
  end

  object :post_created do
    interface(:post_event)
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user, non_null(:user)
  end

  object :post_updated do
    interface(:post_event)
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user, non_null(:user)
  end

  object :post_deleted do
    interface(:post_event)
    field :id, non_null(:id)
  end

  input_object :post_params do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user_id, non_null(:id)
  end
end

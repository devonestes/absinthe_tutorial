defmodule BlogWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(BlogWeb.Schema.AccountTypes)
  import_types(BlogWeb.Schema.ContentTypes)

  alias BlogWeb.Resolvers

  query do
    field :posts, list_of(:post) do
      resolve(&Resolvers.Content.list_posts/3)
    end
  end

  mutation do
    field :create_post, :post do
      arg(:params, non_null(:post_params))
      resolve(&Resolvers.Content.create_post/3)
    end

    field :update_post, :post do
      arg(:params, non_null(:post_params))
      resolve(&Resolvers.Content.update_post/3)
    end

    field :delete_post, :post do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Content.delete_post/3)
    end
  end

  subscription do
    field :post_created, :post do
      arg :user_id, non_null(:id)
      config &config/2
      trigger(:create_post, topic: &trigger/1)
    end

    field :post_updated, :post do
      arg :user_id, non_null(:id)
      config &config/2
      trigger(:update_post, topic: &trigger/1)
    end

    field :post_deleted, :post do
      arg :user_id, non_null(:id)
      config &config/2
      trigger(:delete_post, topic: &trigger/1)
    end

    field :post_events, :post_event do
      arg :user_id, non_null(:id)
      config &config/2
    end
  end

  defp config(args, _), do: {:ok, topic: String.to_integer(args.user_id)}

  defp trigger(post), do: post.user.id
end

defmodule BlogWeb.Resolvers.Content do
  def list_posts(_, _, _) do
    {:ok, Blog.BlogState.list_posts()}
  end

  def create_post(_parent, args, _) do
    args.params |> Blog.BlogState.create_post() |> trigger(:created)
  end

  def update_post(_parent, args, _) do
    args.params |> Blog.BlogState.update_post() |> trigger(:updated)
  end

  def delete_post(_parent, args, _) do
    args.id |> Blog.BlogState.delete_post() |> trigger(:deleted)
  end

  defp trigger(post, event) do
    Absinthe.Subscription.publish(
      BlogWeb.Endpoint,
      Map.put(post, :operation, event),
      post_events: post.user.id
    )

    {:ok, post}
  end
end

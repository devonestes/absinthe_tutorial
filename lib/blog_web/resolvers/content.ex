defmodule BlogWeb.Resolvers.Content do
  def list_posts(_, _, _) do
    {:ok, Blog.BlogState.list_posts()}
  end

  def create_post(_parent, args, _) do
    post = Blog.BlogState.create_post(args.params)
    {:ok, Map.put(post, :operation, :created)}
  end

  def update_post(_parent, args, _) do
    post = Blog.BlogState.update_post(args.params)
    {:ok, Map.put(post, :operation, :updated)}
  end

  def delete_post(_parent, args, _) do
    post = Blog.BlogState.delete_post(args.params)
    {:ok, Map.put(post, :operation, :deleted)}
  end
end

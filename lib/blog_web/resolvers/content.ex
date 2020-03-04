defmodule BlogWeb.Resolvers.Content do
  def list_posts(_, _, _) do
    {:ok, Blog.BlogState.list_posts()}
  end

  def create_post(_parent, args, _) do
    {:ok, Blog.BlogState.create_post(args.params)}
  end

  def update_post(_parent, args, _) do
    {:ok, Blog.BlogState.update_post(args.params)}
  end

  def delete_post(_parent, args, _) do
    {:ok, Blog.BlogState.delete_post(args.id)}
  end
end

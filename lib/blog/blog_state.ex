defmodule Blog.BlogState do
  use Agent

  def start_link() do
    users = %{1 => %{id: 1, name: "John Doe"}, 2 => %{id: 2, name: "Jane Doe"}}
    Agent.start_link(fn -> [users, %{}] end, name: __MODULE__)
  end

  def list_posts() do
    Agent.get(__MODULE__, fn [_, posts] -> Map.values(posts) end)
  end

  def create_post(post) do
    Agent.get_and_update(__MODULE__, fn [users, posts] ->
      {user_id, post} = Map.pop(post, :user_id)
      user_id = String.to_integer(user_id)
      user = Map.get(users, user_id)
      post = Map.put(post, :user, user)
      post = Map.put(post, :id, String.to_integer(post.id))
      {post, [users, Map.put(posts, post.id, post)]}
    end)
  end

  def update_post(post_params) do
    Agent.get_and_update(__MODULE__, fn [users, posts] ->
      post_params =
        case Map.pop(post_params, :user_id) do
          {nil, params} ->
            params

          {user_id, params} ->
            user_id = String.to_integer(user_id)
            user = Map.get(users, user_id)
            Map.put(params, :user, user)
        end

      post_params = Map.put(post_params, :id, String.to_integer(post_params.id))
                    |> IO.inspect()
      post = Map.get(posts, post_params.id, %{})
      post = Map.merge(post, post_params)
      {post, [users, Map.put(posts, post.id, post)]}
    end)
  end

  def delete_post(id) do
    Agent.get_and_update(__MODULE__, fn [users, posts] ->
      id = String.to_integer(id)
      {post, posts} = Map.pop(posts, id, %{})
      {post, [users, posts]}
    end)
  end
end

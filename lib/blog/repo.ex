defmodule Blog.Repo do
  use Ecto.Repo, otp_app: :blog

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, opts}
  end
end

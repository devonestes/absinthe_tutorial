defmodule Blog.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def up do
    Blog.Accounts.Contact.TypeEnum.create_type()
    create table(:contacts) do
      add :type, :contact_type, null: false
      add :value, :string, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:contacts, [:user_id])
    create unique_index(:contacts, [:type, :value])
  end

  def down do
    drop index(:contacts, [:user_id])
    drop unique_index(:contacts, [:type, :value])
    drop table(:contacts)
    Blog.Accounts.Contact.TypeEnum.drop_type()
  end
end

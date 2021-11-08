Sequel.migration do
  def up do
    run 'CREATE EXTENSION IF NOT EXISTS citext'

    create_table(:ads) do
      primary_key :id, type: :Bignum

      column :user_id, :Bignum, null: false
      column :name, "character varying", null: false
      column :email, "citext", null: false
      column :password_digest, "character varying", null: false
      column :created_at, "timestamp(6) without time zone", null: false
      column :updated_at, "timestamp(6) without time zone", null: false

      index [:email], name: :index_users_on_email, unique: true
    end

    create_table(:user_sessions) do
      primary_key :id, type: :Bignum

      column :uuid, "uuid", null: false
      foreign_key :user_id, :users, type: "bigint", null: false, key: [:id]
      column :created_at, "timestamp(6) without time zone", null: false
      column :updated_at, "timestamp(6) without time zone", null: false

      index [:user_id], name: :index_user_sessions_on_user_id
      index [:uuid], name: :index_user_sessions_on_uuid
    end
  end

  def down
    drop_table(:users)
    drop_table(:user_sessions)
  end
end

class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.integer :jwt_token_id, null: false
      t.string :repo_name, null: false
    end

    add_foreign_key :repos, :jwt_tokens, on_delete: :cascade

    add_index(:repos, [:repo_name, :jwt_token_id], unique: true)
  end
end

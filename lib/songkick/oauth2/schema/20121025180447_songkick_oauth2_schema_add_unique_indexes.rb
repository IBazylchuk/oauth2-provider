class SongkickOauth2SchemaAddUniqueIndexes < ActiveRecord::Migration
  INDEX_NAME1 = 'client_id_code_index'
  INDEX_NAME2 = 'access_token_hash_index'
  INDEX_NAME4 = 'client_id_refresh_token_hash_index'

  def self.up
    remove_index :oauth2_authorizations, name: INDEX_NAME1
    add_index :oauth2_authorizations, [:client_id, :code], name: INDEX_NAME1, unique: true

    remove_index :oauth2_authorizations, name: INDEX_NAME4
    add_index :oauth2_authorizations, [:client_id, :refresh_token_hash], name: INDEX_NAME4, unique: true

    remove_index :oauth2_authorizations, name: INDEX_NAME2
    add_index :oauth2_authorizations, [:access_token_hash], name: INDEX_NAME2, unique: true

    remove_index :oauth2_clients, [:client_id]
    add_index :oauth2_clients, [:client_id], unique: true

    add_index :oauth2_clients, [:name], unique: true
  end

  def self.down
    remove_index :oauth2_authorizations, name: INDEX_NAME1
    add_index :oauth2_authorizations, [:client_id, :code], name: INDEX_NAME1

    remove_index :oauth2_authorizations, name: INDEX_NAME4
    add_index :oauth2_authorizations, [:client_id, :refresh_token_hash], name: INDEX_NAME4

    remove_index :oauth2_authorizations, name: INDEX_NAME2
    add_index :oauth2_authorizations, [:access_token_hash], name: INDEX_NAME2

    remove_index :oauth2_clients, [:client_id]
    add_index :oauth2_clients, [:client_id]

    remove_index :oauth2_clients, [:name]
  end
end

class SongkickOauth2SchemaOriginalSchema < ActiveRecord::Migration
  INDEX_NAME1 = 'index_owner_client_tokens1'
  INDEX_NAME2 = 'index_owner_client_tokens2'
  INDEX_NAME3 = 'index_owner_client_tokens3'
  INDEX_NAME4 = 'index_owner_client_tokens4'
  def self.up
    create_table :oauth2_clients do |t|
      t.timestamps
      t.string     :oauth2_client_owner_type
      t.integer    :oauth2_client_owner_id
      t.string     :name
      t.string     :client_id
      t.string     :client_secret_hash
      t.string     :redirect_uri
    end
    add_index :oauth2_clients, [:client_id]

    create_table :oauth2_authorizations do |t|
      t.timestamps
      t.string     :oauth2_resource_owner_type
      t.integer    :oauth2_resource_owner_id
      t.belongs_to :client
      t.text     :scope
      t.string     :code,               :limit => 40
      t.string     :access_token_hash,  :limit => 40
      t.string     :refresh_token_hash, :limit => 40
      t.datetime   :expires_at
    end
    add_index :oauth2_authorizations, [:client_id, :code], :name => INDEX_NAME1
    add_index :oauth2_authorizations, [:access_token_hash], :name => INDEX_NAME2
    add_index :oauth2_authorizations, [:client_id, :access_token_hash], :name => INDEX_NAME3
    add_index :oauth2_authorizations, [:client_id, :refresh_token_hash], :name => INDEX_NAME4
  end

  def self.down
    drop_table :oauth2_clients
    drop_table :oauth2_authorizations
  end
end


class AddDisabledToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :disabled, :boolean, :default=>false
  end
end

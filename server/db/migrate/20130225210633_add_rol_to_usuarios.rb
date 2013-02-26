class AddRolToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :rol, :string
    add_column :usuarios, :descripcion, :string
  end
end

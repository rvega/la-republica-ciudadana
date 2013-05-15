class AddDisabledToComentarios < ActiveRecord::Migration
  def change
    add_column :comentarios, :disabled, :boolean, :default=>false
  end
end

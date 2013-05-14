class AddDisabledToRespuestas < ActiveRecord::Migration
  def change
    add_column :respuestas, :disabled, :boolean, :default=>false
  end
end

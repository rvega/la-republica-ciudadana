class AddDisabledToPreguntas < ActiveRecord::Migration
  def change
    add_column :preguntas, :disabled, :boolean, :default=>false
  end
end

class AddExtranaToPreguntas < ActiveRecord::Migration
  def change
    add_column :preguntas, :extrana, :boolean, :null => false, :default => false
  end
end

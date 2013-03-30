class AddPuntajeToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :puntaje, :integer
  end
end

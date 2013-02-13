class CreateEtiqueta < ActiveRecord::Migration
  def change
    create_table :etiqueta do |t|
      t.integer :pregunta_id
      t.string :etiqueta
      t.timestamps
    end
  end
end

class CreateEtiqueta < ActiveRecord::Migration
  def change
    create_table :etiquetas do |t|
      t.references :pregunta
      t.string :etiqueta
      t.timestamps
    end
    add_index :etiquetas, :etiqueta, :unique=>true
  end
end

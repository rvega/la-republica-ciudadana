class CreateEtiqueta < ActiveRecord::Migration
  def change
    create_table :etiquetas do |t|
      t.string :etiqueta
      t.timestamps
    end
    add_index :etiquetas, :etiqueta, :unique=>true

    create_table :etiquetas_preguntas, :id=>false do |t|
      t.references :etiqueta, :null=>false
      t.references :pregunta, :null=>false
    end
    add_index(:etiquetas_preguntas, [:etiqueta_id, :pregunta_id], :unique => true)
  end
end

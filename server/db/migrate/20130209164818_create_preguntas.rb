class CreatePreguntas < ActiveRecord::Migration
  def change
    create_table :preguntas do |t|
      t.references :usuario
      t.string :topico
      t.string :cuerpo
      t.integer :score

      t.timestamps
    end
    add_index :preguntas, :topico
    add_index :preguntas, :cuerpo
  end
end

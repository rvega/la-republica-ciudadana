class CreatePreguntas < ActiveRecord::Migration
  def change
    create_table :preguntas do |t|
      t.references :usuario
      t.string :topico
      t.string :cuerpo

      t.timestamps
    end
  end
end

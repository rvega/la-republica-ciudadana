class CreateRespuestas < ActiveRecord::Migration
  def change
    create_table :respuestas do |t|
      t.string :cuerpo
      t.references :usuario
      t.references :pregunta

      t.timestamps
    end
  end
end

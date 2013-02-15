class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.references :usuario
      t.string :cuerpo

      t.timestamps
    end
  end
end

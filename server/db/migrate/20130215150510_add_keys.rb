class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "comentarios", "usuarios", :name => "comentarios_usuario_id_fk"
    add_foreign_key "etiquetas", "preguntas", :name => "etiquetas_pregunta_id_fk"
    add_foreign_key "preguntas", "usuarios", :name => "preguntas_usuario_id_fk"
    add_foreign_key "votos", "usuarios", :name => "votos_usuario_id_fk"
  end
end

class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "comentarios", "usuarios", :name => "comentarios_usuario_id_fk"
    add_foreign_key "etiquetas_preguntas", "etiquetas", :name => "etiquetas_preguntas_etiqueta_id_fk"
    add_foreign_key "etiquetas_preguntas", "preguntas", :name => "etiquetas_preguntas_pregunta_id_fk"
    add_foreign_key "preguntas", "usuarios", :name => "preguntas_usuario_id_fk"
    add_foreign_key "respuestas", "preguntas", :name => "respuestas_pregunta_id_fk"
    add_foreign_key "respuestas", "usuarios", :name => "respuestas_usuario_id_fk"
    add_foreign_key "votos", "usuarios", :name => "votos_usuario_id_fk"
  end
end

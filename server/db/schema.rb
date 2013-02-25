# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130225210633) do

  create_table "comentarios", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "comentable_id"
    t.string   "comentable_type"
    t.string   "cuerpo"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "etiquetas", :force => true do |t|
    t.string   "etiqueta"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "etiquetas", ["etiqueta"], :name => "index_etiquetas_on_etiqueta", :unique => true

  create_table "etiquetas_preguntas", :id => false, :force => true do |t|
    t.integer "etiqueta_id", :null => false
    t.integer "pregunta_id", :null => false
  end

  add_index "etiquetas_preguntas", ["etiqueta_id", "pregunta_id"], :name => "index_etiquetas_preguntas_on_etiqueta_id_and_pregunta_id", :unique => true

  create_table "preguntas", :force => true do |t|
    t.integer  "usuario_id"
    t.string   "topico"
    t.string   "cuerpo"
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "preguntas", ["cuerpo"], :name => "index_preguntas_on_cuerpo"
  add_index "preguntas", ["topico"], :name => "index_preguntas_on_topico"

  create_table "respuestas", :force => true do |t|
    t.string   "cuerpo"
    t.integer  "usuario_id"
    t.integer  "pregunta_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "rol"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "votos", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end

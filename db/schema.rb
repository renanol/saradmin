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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151029023445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bairros", force: :cascade do |t|
    t.string   "nome"
    t.integer  "cidade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bairros", ["cidade_id"], name: "index_bairros_on_cidade_id", using: :btree

  create_table "cidades", force: :cascade do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cidades", ["estado_id"], name: "index_cidades_on_estado_id", using: :btree

  create_table "contatos", force: :cascade do |t|
    t.integer  "tipo"
    t.string   "descricao"
    t.integer  "endereco_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "contatos", ["endereco_id"], name: "index_contatos_on_endereco_id", using: :btree

  create_table "enderecos", force: :cascade do |t|
    t.string   "logradouro"
    t.string   "numero"
    t.string   "complemento"
    t.string   "cep"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "igreja_id"
    t.integer  "bairro_id"
    t.integer  "cidade_id"
    t.integer  "estado_id"
  end

  add_index "enderecos", ["bairro_id"], name: "index_enderecos_on_bairro_id", using: :btree
  add_index "enderecos", ["cidade_id"], name: "index_enderecos_on_cidade_id", using: :btree
  add_index "enderecos", ["estado_id"], name: "index_enderecos_on_estado_id", using: :btree
  add_index "enderecos", ["igreja_id"], name: "index_enderecos_on_igreja_id", using: :btree

  create_table "estados", force: :cascade do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foos", force: :cascade do |t|
    t.string   "description"
    t.integer  "number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "grupo_permissoes", force: :cascade do |t|
    t.integer  "valor"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "grupo_id"
    t.integer  "permissao_id"
  end

  create_table "grupos", force: :cascade do |t|
    t.string   "descricao"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "igrejas", force: :cascade do |t|
    t.string   "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pais", force: :cascade do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissoes", force: :cascade do |t|
    t.integer  "modulo"
    t.integer  "tipo"
    t.string   "alias"
    t.string   "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "grupo_id"
    t.string   "name"
    t.integer  "status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bairros", "cidades"
  add_foreign_key "cidades", "estados"
end

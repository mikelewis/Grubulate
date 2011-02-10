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

ActiveRecord::Schema.define(:version => 20110210044700) do

  create_table "appliances", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
  end

  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["profile_id"], :name => "index_comments_on_profile_id"
  add_index "comments", ["recipe_id"], :name => "index_comments_on_recipe_id"

  create_table "entrees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipments", :force => true do |t|
    t.integer "recipe_id",    :null => false
    t.integer "appliance_id", :null => false
  end

  add_index "equipments", ["appliance_id"], :name => "index_equipments_on_appliance_id"
  add_index "equipments", ["recipe_id"], :name => "index_equipments_on_recipe_id"

  create_table "favorite_chefs", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "chef_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_chefs", ["chef_id"], :name => "index_favorite_chefs_on_chef_id", :unique => true
  add_index "favorite_chefs", ["profile_id"], :name => "index_favorite_chefs_on_profile_id"

  create_table "foods", :force => true do |t|
    t.integer "recipe_id",     :null => false
    t.integer "ingredient_id", :null => false
  end

  add_index "foods", ["ingredient_id"], :name => "index_foods_on_ingredient_id"
  add_index "foods", ["recipe_id"], :name => "index_foods_on_recipe_id"

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", :force => true do |t|
    t.integer "recipe_id", :null => false
    t.integer "entree_id", :null => false
  end

  add_index "meals", ["entree_id"], :name => "index_meals_on_entree_id"
  add_index "meals", ["recipe_id"], :name => "index_meals_on_recipe_id"

  create_table "profiles", :force => true do |t|
    t.string   "username"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id", :unique => true

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rateable_id"], :name => "index_rates_on_rateable_id"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "recipe_images", :force => true do |t|
    t.string   "caption"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "recipes", :force => true do |t|
    t.string   "title"
    t.integer  "difficulty"
    t.text     "short_desc"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
    t.integer  "cook_time"
    t.decimal  "rating_average", :precision => 6, :scale => 2, :default => 0.0
    t.integer  "comments_count",                               :default => 0
  end

  add_index "recipes", ["cook_time"], :name => "index_recipes_on_cook_time"
  add_index "recipes", ["created_at"], :name => "index_recipes_on_created_at"
  add_index "recipes", ["difficulty"], :name => "index_recipes_on_difficulty"
  add_index "recipes", ["profile_id"], :name => "index_recipes_on_profile_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

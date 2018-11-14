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

ActiveRecord::Schema.define(version: 20180417120906) do

  create_table "archives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "file"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["province_id"], name: "index_cities_on_province_id", using: :btree
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "source_profile_id"
    t.integer  "destination_profile_id"
    t.text     "body",                   limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["destination_profile_id"], name: "index_messages_on_destination_profile_id", using: :btree
    t.index ["source_profile_id"], name: "index_messages_on_source_profile_id", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "normal_profile_id"
    t.string   "kind"
    t.text     "content",           limit: 65535
    t.string   "state",                           default: "new"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["normal_profile_id"], name: "index_notifications_on_normal_profile_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "surname"
    t.integer  "user_id"
    t.integer  "image_id"
    t.date     "birthdate"
    t.string   "dni"
    t.string   "type"
    t.string   "gender"
    t.string   "phone_country"
    t.string   "phone_area"
    t.string   "phone_number"
    t.string   "phone_activation_code"
    t.string   "preference_place"
    t.string   "preference_assistance"
    t.string   "preference_time"
    t.integer  "country_id"
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "postal_code"
    t.string   "street"
    t.string   "number"
    t.string   "floor"
    t.string   "apartment"
    t.text     "observation",           limit: 65535
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["city_id"], name: "index_profiles_on_city_id", using: :btree
    t.index ["country_id"], name: "index_profiles_on_country_id", using: :btree
    t.index ["image_id"], name: "index_profiles_on_image_id", using: :btree
    t.index ["province_id"], name: "index_profiles_on_province_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "provinces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_provinces_on_country_id", using: :btree
  end

  create_table "to_learns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_category_id"
    t.integer  "normal_profile_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["normal_profile_id"], name: "index_to_learns_on_normal_profile_id", using: :btree
    t.index ["workshop_category_id"], name: "index_to_learns_on_workshop_category_id", using: :btree
  end

  create_table "to_teaches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_category_id"
    t.integer  "normal_profile_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["normal_profile_id"], name: "index_to_teaches_on_normal_profile_id", using: :btree
    t.index ["workshop_category_id"], name: "index_to_teaches_on_workshop_category_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "workshop_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "image_cover_id"
    t.integer  "image_card_category_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["image_card_category_id"], name: "index_workshop_categories_on_image_card_category_id", using: :btree
    t.index ["image_cover_id"], name: "index_workshop_categories_on_image_cover_id", using: :btree
  end

  create_table "workshop_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_id"
    t.integer  "normal_profile_id"
    t.text     "comment",           limit: 65535
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "score",                           default: 1
    t.index ["normal_profile_id"], name: "index_workshop_comments_on_normal_profile_id", using: :btree
    t.index ["workshop_id"], name: "index_workshop_comments_on_workshop_id", using: :btree
  end

  create_table "workshop_favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_id"
    t.integer  "normal_profile_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["normal_profile_id"], name: "index_workshop_favorites_on_normal_profile_id", using: :btree
    t.index ["workshop_id"], name: "index_workshop_favorites_on_workshop_id", using: :btree
  end

  create_table "workshop_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_id"
    t.integer  "image_id"
    t.string   "kind"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["image_id"], name: "index_workshop_images_on_image_id", using: :btree
    t.index ["workshop_id"], name: "index_workshop_images_on_workshop_id", using: :btree
  end

  create_table "workshop_schedule_message_observers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_schedule_message_id"
    t.integer  "profile_id"
    t.string   "state",                        default: "new"
    t.string   "kind"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["profile_id"], name: "profile", using: :btree
    t.index ["workshop_schedule_message_id"], name: "workshop_schedule_message", using: :btree
  end

  create_table "workshop_schedule_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",                 limit: 65535
    t.integer  "workshop_schedule_id"
    t.integer  "profile_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["profile_id"], name: "index_workshop_schedule_messages_on_profile_id", using: :btree
    t.index ["workshop_schedule_id"], name: "index_workshop_schedule_messages_on_workshop_schedule_id", using: :btree
  end

  create_table "workshop_schedule_subscribeds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_schedule_id"
    t.integer  "normal_profile_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["normal_profile_id"], name: "index_workshop_schedule_subscribeds_on_normal_profile_id", using: :btree
    t.index ["workshop_schedule_id"], name: "index_workshop_schedule_subscribeds_on_workshop_schedule_id", using: :btree
  end

  create_table "workshop_schedules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_id"
    t.text     "schedule_info",            limit: 65535
    t.integer  "maximun_quota",                          default: 0
    t.integer  "actual_quota",                           default: 0
    t.boolean  "unlimited_quota",                        default: false
    t.date     "start_publication"
    t.boolean  "always_open",                            default: false
    t.date     "closing_of_registrations"
    t.boolean  "never_close",                            default: false
    t.integer  "lock_version",                           default: 0
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["workshop_id"], name: "index_workshop_schedules_on_workshop_id", using: :btree
  end

  create_table "workshop_steps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "workshop_id"
    t.string   "step"
    t.boolean  "ok",          default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["workshop_id"], name: "index_workshop_steps_on_workshop_id", using: :btree
  end

  create_table "workshops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "normal_profile_id"
    t.integer  "workshop_category_id"
    t.integer  "country_id"
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "street"
    t.string   "number"
    t.string   "floor"
    t.string   "apartment"
    t.string   "postal_code"
    t.text     "observation",                           limit: 65535
    t.float    "latitude",                              limit: 24
    t.float    "longitude",                             limit: 24
    t.string   "place"
    t.text     "description_place",                     limit: 65535
    t.string   "activity_title"
    t.text     "activity_description",                  limit: 65535
    t.string   "gender"
    t.integer  "age_max",                                             default: 100
    t.integer  "age_min",                                             default: 1
    t.string   "level"
    t.text     "description",                           limit: 65535
    t.boolean  "offer_material",                                      default: false
    t.string   "things_included"
    t.string   "things_to_carry"
    t.string   "aspects_to_consider"
    t.string   "price_unit",                                          default: "por_clase"
    t.integer  "price_in_cents"
    t.boolean  "charge_method_transfer",                              default: false
    t.string   "charge_method_transfer_bank"
    t.string   "charge_method_transfer_subsidiary"
    t.string   "charge_method_transfer_owner"
    t.string   "charge_method_transfer_dni"
    t.string   "charge_method_transfer_account_number"
    t.string   "charge_method_transfer_cbu"
    t.string   "state",                                               default: "draft"
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.string   "payment_method"
    t.index ["city_id"], name: "index_workshops_on_city_id", using: :btree
    t.index ["country_id"], name: "index_workshops_on_country_id", using: :btree
    t.index ["normal_profile_id"], name: "index_workshops_on_normal_profile_id", using: :btree
    t.index ["province_id"], name: "index_workshops_on_province_id", using: :btree
    t.index ["workshop_category_id"], name: "index_workshops_on_workshop_category_id", using: :btree
  end

end

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

ActiveRecord::Schema.define(version: 20150610111023) do

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "course_url"
    t.string   "company"
  end

  create_table "free_subscriptions", force: true do |t|
    t.string   "company"
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobapplications", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cv_file_name"
    t.string   "cv_content_type"
    t.integer  "cv_file_size"
    t.datetime "cv_updated_at"
    t.string   "letter_file_name"
    t.string   "letter_content_type"
    t.integer  "letter_file_size"
    t.datetime "letter_updated_at"
    t.integer  "job_id"
    t.string   "linkedin_url"
  end

  add_index "jobapplications", ["user_id"], name: "index_jobapplications_on_user_id"

  create_table "jobs", force: true do |t|
    t.string   "place"
    t.string   "title"
    t.text     "description"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "guid"
    t.text     "markdown"
    t.boolean  "directapply",         default: false
    t.string   "summary"
    t.string   "job_type"
    t.boolean  "free",                default: false
  end

  add_index "jobs", ["company"], name: "index_jobs_on_company"
  add_index "jobs", ["place"], name: "index_jobs_on_place"
  add_index "jobs", ["title"], name: "index_jobs_on_title"
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id"

  create_table "plans", force: true do |t|
    t.string   "stripe_id"
    t.string   "name"
    t.text     "description"
    t.integer  "amount"
    t.string   "interval"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "posts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
    t.string   "title"
    t.text     "embed_url"
    t.string   "video_url"
    t.text     "markdown"
  end

  add_index "posts", ["topic_id", "created_at"], name: "index_posts_on_topic_id_and_created_at"
  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "stripe_webhooks", force: true do |t|
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid"
    t.string   "email"
    t.string   "state"
    t.string   "stripe_token"
    t.string   "error"
    t.string   "amount"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "toprelations", force: true do |t|
    t.integer  "topic_follower_id"
    t.integer  "topic_followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "toprelations", ["topic_followed_id"], name: "index_toprelations_on_topic_followed_id"
  add_index "toprelations", ["topic_follower_id", "topic_followed_id"], name: "index_toprelations_on_topic_follower_id_and_topic_followed_id", unique: true
  add_index "toprelations", ["topic_follower_id"], name: "index_toprelations_on_topic_follower_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",               default: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "university"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",           default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "stripe_customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end

# frozen_string_literal: true

require "active_record"
require "speaky"

# setup database connection
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

# create table test_models for testing
ActiveRecord::Schema.define do
  create_table :test_models do |t|
    t.string :name
  end
end

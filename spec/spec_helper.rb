# frozen_string_literal: true

require 'dotenv'
require "rails"
require "active_record"
require "speaky"

# load .env file
Dotenv.load

# setup rails logger
Rails.logger = Logger.new(STDOUT)

# setup database connection
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

# create table test_models for testing
ActiveRecord::Schema.define do
  create_table :test_models do |t|
    t.string :name
  end
end

# setup consts to be used in tests
OPENAI_CONFIGURED = !ENV["OPENAI_ACCESS_TOKEN"].blank?
QDRANT_CONFIGURED = !ENV["QDRANT_URL"].blank? && !ENV["QDRANT_API_KEY"].blank? && !ENV["QDRANT_COLLECTION_NAME"].blank?
FAISS_CONFIGURED = !ENV["FAISS_INDEX_PATH"].blank?

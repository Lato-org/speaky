# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky do
  it "has a version number" do
    expect(Speaky::VERSION).not_to be nil
  end

  it "should be configurable" do
    Speaky.configure do |config|
      config.llm_type = 'openai'
      config.llm_config = { access_token: '1234' }

      config.vectorstore_type = 'faiss'
      config.vectorstore_config = { index_path: 'path/to/index' }
    end

    expect(Speaky.config.llm_type).to eq('openai')
    expect(Speaky.config.llm_config).to eq({ access_token: '1234' })
    expect(Speaky.config.vectorstore_type).to eq('faiss')
    expect(Speaky.config.vectorstore_config).to eq({ index_path: 'path/to/index' })
  end

  it "should have a model concern" do
    class TestModel < ActiveRecord::Base
      include Speaky::Model
    end

    model = TestModel.new
    expect(model).to respond_to(:as_speaky)
    expect(model).to respond_to(:create_for_speaky)
    expect(model).to respond_to(:update_for_speaky)
    expect(model).to respond_to(:destroy_for_speaky)
    expect(model).to respond_to(:save_for_speaky)
  end
end

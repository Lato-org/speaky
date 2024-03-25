# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky::Config do
  it "should be initialized with default values" do
    config = Speaky::Config.new

    expect(config.llm_type).to eq("openai")
    expect(config.llm_config).to eq({})

    expect(config.vectorstore_type).to eq("qdrant")
    expect(config.vectorstore_config).to eq({})
  end

  it "should be able to set LLM configuration" do
    config = Speaky::Config.new

    config.llm_type = "gpt3"
    config.llm_config = { api_key: "123" }

    expect(config.llm_type).to eq("gpt3")
    expect(config.llm_config).to eq({ api_key: "123" })
  end

  it "should be able to set Vectorstore configuration" do
    config = Speaky::Config.new

    config.vectorstore_type = "qdrant"
    config.vectorstore_config = { api_key: "123" }

    expect(config.vectorstore_type).to eq("qdrant")
    expect(config.vectorstore_config).to eq({ api_key: "123" })
  end
end

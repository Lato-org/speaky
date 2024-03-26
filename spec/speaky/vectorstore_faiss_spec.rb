# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky::VectorstoreFaiss do
  it "should be initialized with a configuration" do
    next unless FAISS_CONFIGURED

    vectorstore = Speaky::VectorstoreFaiss.new({
      index_path: ENV["FAISS_INDEX_PATH"]
    })

    expect(vectorstore.config).to eq({
      index_path: ENV["FAISS_INDEX_PATH"]
    })
  end

  it "should raise an error if index_path is not set" do
    next unless FAISS_CONFIGURED

    expect {
      Speaky::VectorstoreFaiss.new({})
    }.to raise_error(ArgumentError)
  end

  it "should add a vector to the index" do
    next unless FAISS_CONFIGURED && OPENAI_CONFIGURED

    # HACK: force speaky @llm to be initialized with OpenAI config
    Speaky.instance_variable_set(:@llm, Speaky::LlmOpenai.new({
      access_token: ENV["OPENAI_ACCESS_TOKEN"]
    }))

    vectorstore = Speaky::VectorstoreFaiss.new({
      index_path: ENV["FAISS_INDEX_PATH"]
    })

    vectorstore.add("test", "Hello, world!")

    # HACK: reset speaky @llm
    Speaky.instance_variable_set(:@llm, nil)
  end

  it "should remove a vector from the index" do
    next unless FAISS_CONFIGURED

    vectorstore = Speaky::VectorstoreFaiss.new({
      index_path: ENV["FAISS_INDEX_PATH"]
    })

    expect(vectorstore.remove("test")).to eq(true)
  end

  it "should query the index" do
    next unless FAISS_CONFIGURED && OPENAI_CONFIGURED

    # HACK: force speaky @llm to be initialized with OpenAI config
    Speaky.instance_variable_set(:@llm, Speaky::LlmOpenai.new({
      access_token: ENV["OPENAI_ACCESS_TOKEN"]
    }))

    vectorstore = Speaky::VectorstoreFaiss.new({
      index_path: ENV["FAISS_INDEX_PATH"]
    })

    result = vectorstore.query("Hello what?")
    expect(result).to be_an(Array)

    puts result

    # HACK: reset speaky @llm
    Speaky.instance_variable_set(:@llm, nil)
  end

  it "should reset the index" do
    next unless FAISS_CONFIGURED

    vectorstore = Speaky::VectorstoreFaiss.new({
      index_path: ENV["FAISS_INDEX_PATH"]
    })

    expect(vectorstore.reset).to eq(true)
  end
end

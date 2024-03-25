# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky::LlmOpenai do
  it "should be initialized with a configuration" do
    next unless OPENAI_CONFIGURED

    llm = Speaky::LlmOpenai.new({
      access_token: ENV["OPENAI_ACCESS_TOKEN"]
    })

    expect(llm.config).to eq({
      access_token: ENV["OPENAI_ACCESS_TOKEN"]
    })
  end

  it "should raise an error if the access token is not set" do
    expect {
      Speaky::LlmOpenai.new({})
    }.to raise_error("Openai access token is not set")
  end

  it "should embed text" do
    next unless OPENAI_CONFIGURED

    llm = Speaky::LlmOpenai.new({
      access_token: ENV["OPENAI_ACCESS_TOKEN"]
    })

    embeddings = llm.embed("Hello, world!")
    expect(embeddings).to be_a(Array)
  end

  it "should chat" do
    next unless OPENAI_CONFIGURED

    llm = Speaky::LlmOpenai.new({
      access_token: ENV["OPENAI_ACCESS_TOKEN"]
    })

    response = llm.chat("Write me: Hello, world!")
    expect(response).to be_a(String)
    expect(response).to include("Hello, world!")
  end
end

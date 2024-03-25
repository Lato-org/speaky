# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky::VectorstoreBase do
  it "should be initialized with a configuration" do
    vectorstore = Speaky::VectorstoreBase.new({
      config_key: "config_value"
    })

    expect(vectorstore.config).to eq({
      config_key: "config_value"
    })
  end

  it "should raise NotImplementedError for add" do
    vectorstore = Speaky::VectorstoreBase.new({})

    expect {
      vectorstore.add(1, "text")
    }.to raise_error(NotImplementedError)
  end

  it "should raise NotImplementedError for remove" do
    vectorstore = Speaky::VectorstoreBase.new({})

    expect {
      vectorstore.remove(1)
    }.to raise_error(NotImplementedError)
  end

  it "should raise NotImplementedError for query" do
    vectorstore = Speaky::VectorstoreBase.new({})

    expect {
      vectorstore.query("query")
    }.to raise_error(NotImplementedError)
  end

  it "should raise NotImplementedError for reset" do
    vectorstore = Speaky::VectorstoreBase.new({})

    expect {
      vectorstore.reset
    }.to raise_error(NotImplementedError)
  end
end

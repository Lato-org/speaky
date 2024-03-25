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
end

# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky::LlmBase do
  it "should be initialized with a configuration" do
    llm = Speaky::LlmBase.new({
      config_key: "config_value"
    })

    expect(llm.config).to eq({
      config_key: "config_value"
    })
  end
end

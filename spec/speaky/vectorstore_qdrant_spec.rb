# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky::VectorstoreQdrant do
  it "should be initialized with a configuration" do
    next unless QVRANT_CONFIGURED

    vectorstore = Speaky::VectorstoreQdrant.new({
      url: ENV["QDRANT_URL"],
      api_key: ENV["QDRANT_API_KEY"],
      collection_name: ENV["QDRANT_COLLECTION_NAME"]
    })

    expect(vectorstore.config).to eq({
      url: ENV["QDRANT_URL"],
      api_key: ENV["QDRANT_API_KEY"],
      collection_name: ENV["QDRANT_COLLECTION_NAME"]
    })
  end
end

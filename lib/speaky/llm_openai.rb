# frozen_string_literal: true

require "openai"

module Speaky
  class LlmOpenai < LlmBase
    def initialize(config)
      @config = config

      # check if the access token is set
      raise "Openai access token is not set" unless @config[:access_token]

      # setup client
      @client = OpenAI::Client.new(@config)

      # setup embeddings params
      # NOTE: This is a hardcoded value for now but can be made configurable in the future by passing it in the config
      @embeddings_params = {
        model: 'text-embedding-3-small',
        dimensions: 1536
      }
    end

    def embed(text)
      params = @embeddings_params.merge({
        input: text
      })

      response = @client.embeddings(parameters: params)
      response["data"].find { |d| d["object"] == "embedding" }["embedding"]
    end
  end
end

# frozen_string_literal: true

module Speaky
  # This is a class that stores the configuration of the gem.
  class Config
    # LLM configuration
    attr_accessor :llm_type, :llm_config

    # Vectorstore configuration
    attr_accessor :vectorstore_type, :vectorstore_config

    def initialize
      @llm_type = 'openai'
      @llm_config = {}

      @vectorstore_type = 'faiss'
      @vectorstore_config = {}
    end
  end
end

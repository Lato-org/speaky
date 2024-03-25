# frozen_string_literal: true

require "speaky/version"
require "speaky/config"
require "speaky/model"

require "speaky/llm_base"
require "speaky/llm_openai"

require "speaky/vectorstore_base"
require "speaky/vectorstore_qdrant"
require "speaky/vectorstore_faiss"

module Speaky
  class << self
    # This is a class method that returns a new instance of Config
    # if @config is nil. If it is not nil, it returns the existing
    # instance of Config.
    #
    # Example of usage:
    # Speaky.config.some_value
    def config
      @config ||= Config.new
    end

    # This is a method that takes a block and yields the config
    # instance to the block.
    #
    # Example of usage:
    # Speaky.configure do |config|
    #  config.some_value = "some value"
    # end
    def configure
      yield config
    end

    # This is a method that returns an instance of VectorstoreBase class.
    #
    # Example of usage:
    # Speaky.vectorstore.method_name
    def vectorstore
      return @vectorstore if defined?(@vectorstore) && @vectorstore

      case config.vectorstore_type
      when "faiss"
        @vectorstore = VectorstoreFaiss.new(config.vectorstore_config)
      when "qdrant"
        @vectorstore = VectorstoreQdrant.new(config.vectorstore_config)
      else
        raise "Invalid vectorstore type"
      end
    end

    # This is a method that returns an instance of LlmBase class.
    #
    # Example of usage:
    # Speaky.llm.method_name
    def llm
      return @llm if defined?(@llm) && @llm

      case config.llm_type
      when "openai"
        @llm = LlmOpenai.new(config.llm_config)
      else
        raise "Invalid llm type"
      end
    end
  end
end

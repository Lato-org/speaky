# frozen_string_literal: true

module Speaky
  class LlmBase
    def initialize(config)
      @config = config
    end

    def config
      @config
    end

    def embed(text)
      raise NotImplementedError
    end

    def chat(prompt)
      raise NotImplementedError
    end
  end
end

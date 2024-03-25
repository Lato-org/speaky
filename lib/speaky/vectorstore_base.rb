# frozen_string_literal: true

module Speaky
  class VectorstoreBase
    def initialize(config)
      @config = config
    end

    def config
      @config
    end

    # Add a vector to the vectorstore.
    # NOTE: If the vector already exists, it will be updated.
    # Returns a boolean.
    def add(id, data)
      raise NotImplementedError
    end

    # Remove a vector from the vectorstore.
    # NOTE: If the vector does not exist, it will be ignored.
    # Returns a boolean.
    def remove(id)
      raise NotImplementedError
    end

    # Query the vectorstore with a question.
    # Returns a string.
    def query(question)
      raise NotImplementedError
    end

    # Reset the vectorstore.
    # Returns a boolean.
    def reset
      raise NotImplementedError
    end
  end
end

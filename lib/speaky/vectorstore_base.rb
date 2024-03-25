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
    def add(id, data)
      raise NotImplementedError
    end

    # Update a vector in the vectorstore.
    # NOTE: If the vector does not exist, it will be added.
    def update(id, data)
      raise NotImplementedError
    end

    # Remove a vector from the vectorstore.
    # NOTE: If the vector does not exist, it will be ignored.
    def remove(id)
      raise NotImplementedError
    end

    def query(question)
      raise NotImplementedError
    end
  end
end

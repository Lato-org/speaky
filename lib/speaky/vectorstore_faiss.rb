# frozen_string_literal: true

require 'faiss'

module Speaky
  class VectorstoreFaiss < VectorstoreBase
    def initialize(config)
      @config = config

      # check if the index path is set
      raise ArgumentError, 'index_path is required' unless @config[:index_path]

      # load index from index_path if exists
      if File.exist?(@config[:index_path])
        @index = Faiss::Index.load(@config[:index_path])
      else
        # create a new index
        @index = Faiss::IndexFlatL2.new(1536)
        @index.save(@config[:index_path])
      end
    end

    def add(id, data)
      embeddings = Speaky.llm.embed(data)

      result = @index.add([embeddings])
      puts "@" * 100
      puts result
      puts "@" * 100
    end
  end
end

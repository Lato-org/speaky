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
        index = Faiss::IndexFlatL2.new(1536)
        @index = Faiss::IndexIDMap.new(index)
        @index.save(@config[:index_path])
      end
    end

    def add(id, data)
      embeddings = Speaky.llm.embed(data)

      @index.add_with_ids([embeddings], [string_id_to_unique_int_id(id)])

      true
    end

    def remove(id)
      # remove is not supported by Faiss
      true
    end

    private

    # This method is used to convert a string ID to a unique integer ID
    # that can be used by the Qdrant API.
    def string_id_to_unique_int_id(string_id)
      string_id.to_s.hash.abs
    end
  end
end

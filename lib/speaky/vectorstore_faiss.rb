# frozen_string_literal: true

module Speaky
  class VectorstoreFaiss < VectorstoreBase
    def initialize(config)
      raise 'This class is not implemented yet.' # TEMP

      @config = config

      # check if the index path is set
      raise ArgumentError, 'index_path is required' unless @config[:index_path]

      # load index from index_path if exists
      if File.exist?(@config[:index_path])
        @index = Faiss::Index.load(@config[:index_path])
      else
        # create a new index
        @index = Faiss::IndexFlatL2.new(768)
        @index.save(@config[:index_path])
      end
    end

    # TODO: Implement the other methods
  end
end

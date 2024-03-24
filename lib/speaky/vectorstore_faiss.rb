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
        # TODO
      end
    end
  end
end

module Speaky
  class VectorstoreQvrant < VectorstoreBase
    def initialize(config)
      @config = config

      # check if required fields are set
      raise ArgumentError, 'url is required' unless @config[:url]
      raise ArgumentError, 'api_key is required' unless @config[:api_key]
      raise ArgumentError, 'collection_name is required' unless @config[:collection_name]

      # TODO
    end
  end
end

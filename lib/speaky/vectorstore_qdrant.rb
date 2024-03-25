require 'qdrant'

module Speaky
  class VectorstoreQdrant < VectorstoreBase
    def initialize(config)
      @config = config

      # check if required fields are set
      raise ArgumentError, 'url is required' unless @config[:url]
      raise ArgumentError, 'api_key is required' unless @config[:api_key]
      raise ArgumentError, 'collection_name is required' unless @config[:collection_name]

      # setup client
      @client = Qdrant::Client.new(
        url: @config[:url],
        api_key: @config[:api_key]
      )

      # create collection if it doesn't exist
      collections_get = @client.collections.get(collection_name: @config[:collection_name])
      if !collections_get || collections_get.dig('status') != 'ok'
        collections_create = @client.collections.create(collection_name: @config[:collection_name], vectors: {})
        if !collections_create || collections_create.dig('status') != 'ok'
          raise 'Failed to create collection'
        end
      end

      # create index for field "id" in collection
      collections_create_index = @client.collections.create_index(collection_name: @config[:collection_name], field_name: 'id', field_schema: 'keyword')
      if !collections_create_index || collections_create_index.dig('status') != 'ok'
        raise 'Failed to create index for field "id" on collection'
      end
    end

    def add(id, data)
      points_upsert = @client.points.upsert(
        collection_name: @config[:collection_name],
        batch: {

        },
        wait: true
      )

      puts points_upsert
    end
  end
end

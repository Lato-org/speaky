# frozen_string_literal: true

require 'rails'
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

      # create collection
      create_collection
    end

    def add(id, data)
      embeddings = Speaky.llm.embed(data)

      points_upsert = @client.points.upsert(
        collection_name: @config[:collection_name],
        points: [
          {
            id: string_id_to_unique_int_id(id),
            vector: embeddings,
            payload: {
              content: data
            }
          }
        ],
        wait: true
      )

      if !points_upsert || points_upsert.dig('status') != 'ok'
        Rails.logger.error(points_upsert)
        raise 'Failed to add vector'
      end

      true
    end

    def remove(id)
      points_delete = @client.points.delete(
        collection_name: @config[:collection_name],
        points: [string_id_to_unique_int_id(id)],
      )

      if !points_delete || points_delete.dig('status') != 'ok'
        Rails.logger.error(points_delete)
        raise 'Failed to remove vector'
      end

      true
    end

    def query(question)
      embeddings = Speaky.llm.embed(question)

      points_search = @client.points.search(
        collection_name: @config[:collection_name],
        limit: 5,
        vector: embeddings,
        with_payload: true,
        with_vector: false
      )

      if !points_search || points_search.dig('status') != 'ok'
        Rails.logger.error(points_search)
        raise 'Failed to search vectors'
      end

      points_search.dig('result').map { |r| r.dig('payload', 'content') }
    end

    def reset
      collections_delete = @client.collections.delete(collection_name: @config[:collection_name])
      if !collections_delete || collections_delete.dig('status') != 'ok'
        Rails.logger.error(collections_delete)
        raise 'Failed to delete collection'
      end

      create_collection
    end

    private

    def create_collection
      collections_get = @client.collections.get(collection_name: @config[:collection_name])
      if !collections_get || collections_get.dig('status') != 'ok'
        collections_create = @client.collections.create(
          collection_name: @config[:collection_name],
          vectors: {
            distance: "Cosine",
            size: 1536
          }
        )
        if !collections_create || collections_create.dig('status') != 'ok'
          Rails.logger.error(collections_create)
          raise 'Failed to create collection'
        end
      end

      # create index for field "id" in collection
      collections_create_index = @client.collections.create_index(collection_name: @config[:collection_name], field_name: 'id', field_schema: 'keyword')
      if !collections_create_index || collections_create_index.dig('status') != 'ok'
        Rails.logger.error(collections_create_index)
        raise 'Failed to create index for field "id" on collection'
      end

      true
    end

    # This method is used to convert a string ID to a unique integer ID
    # that can be used by the Qdrant API.
    def string_id_to_unique_int_id(string_id)
      string_id.to_s.hash.abs
    end
  end
end

# Speaky

**UNDER DEVELOPMENT**

Store activerecord models in vector stores and query them with LLMs!

## Installation

Add the gem to your Gemfile:

```ruby
gem 'speaky'
```

Install the gem:

```bash
bundle install
```

Create a new configuration initializer:

```ruby
# config/initializers/speaky.rb

Speaky.configure do |config|
  # Set the LLM type to use for querying the vector store.
  # - 'openai' -> require 'ruby-openai' gem
  config.llm_type = 'openai'

  # Set the LLM configuration options.
  # - for 'openai' LLMs, view https://github.com/alexrudall/ruby-openai for configuration options
  config.llm_config = {
    access_token: 'YOUR_ACCESS_TOKEN',
    organization_id: 'YOUR_ORGANIZATION_ID',
  }

  # Set the vector store type to use for storing model instances.
  # - 'qdrant' -> require 'qdrant-ruby' gem
  config.vector_store_type = 'qdrant'

  # Set the vector store configuration options.
  # - for 'qdrant' vector stores, :url, :api_key, :collection_name are required
  config.vector_store_config = {
    url: 'YOUR_URL',
    api_key: 'YOUR_API_KEY',
    collection_name: 'YOUR_COLLECTION_NAME',
  }
end
```

## Usage

To use the gem, include the `Speaky::Model` module in your ActiveRecord models that should be stored in the vector store:

```ruby
class MyModel < ApplicationRecord
  include Speaky::Model

  def as_speaky
    # This method should return a string representation of the model instance data that should be stored in the vector store. The default implementation is to call `to_json` on the model instance data.
  end

  # Add any callbacks that should update the model instance data in the vector store.
  after_create :create_for_speaky
  after_update :update_for_speaky
  after_save :save_for_speaky
  after_destroy :destroy_for_speaky

  # Or auto-sync the model instance data in the vector store.
  sync_for_speaky
end
```

## Development

1. Clone the repo

2. Install dependencies with `bundle install`

3. Create your local `.env` file with `cp .env.example .env`

4. Run the tests with `bundle exec rspec`
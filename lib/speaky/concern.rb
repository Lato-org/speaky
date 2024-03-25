# frozen_string_literal: true

require 'active_support'

module Speaky
  # This is a module that should be used as a Rails concern.
  module Concern
    extend ActiveSupport::Concern

    def as_speaky
      self.to_json
    end

    def create_for_speaky
      begin
        Speaky.vectorstore.add(self.id, self.as_speaky)
      rescue StandardError => e
        Rails.logger.error(e)
        errors.add(:base, 'Failed to create for speaky')
        raise ActiveRecord::Rollback
      end
    end

    def update_for_speaky
      begin
        Speaky.vectorstore.update(self.id, self.as_speaky)
      rescue StandardError => e
        Rails.logger.error(e)
        errors.add(:base, 'Failed to update for speaky')
        raise ActiveRecord::Rollback
      end
    end

    def destroy_for_speaky
      begin
        Speaky.vectorstore.remove(self.id)
      rescue StandardError => e
        Rails.logger.error(e)
        errors.add(:base, 'Failed to destroy for speaky')
        raise ActiveRecord::Rollback
      end
    end

    def save_for_speaky
      ActiveRecord::Base.transaction do
        if self.new_record?
          create_for_speaky
        else
          update_for_speaky
        end
      end
    end
  end
end
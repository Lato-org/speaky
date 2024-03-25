# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky::Model do
  it "should have a model concern" do
    class TestModel < ActiveRecord::Base
      include Speaky::Model
    end

    model = TestModel.new
    expect(model).to respond_to(:as_speaky)
    expect(model).to respond_to(:create_for_speaky)
    expect(model).to respond_to(:update_for_speaky)
    expect(model).to respond_to(:destroy_for_speaky)
    expect(model).to respond_to(:save_for_speaky)
  end
end

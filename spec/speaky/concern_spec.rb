# frozen_string_literal: true

require "spec_helper"

RSpec.describe Speaky::Concern do
  it "should have a concern" do
    class TestModel < ActiveRecord::Base
      include Speaky::Concern
    end

    model = TestModel.new
    expect(model).to respond_to(:as_speaky)
    expect(model).to respond_to(:save_for_speaky)
    expect(model).to respond_to(:destroy_for_speaky)
  end
end

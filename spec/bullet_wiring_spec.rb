require "rails_helper"

RSpec.describe "Bullet wiring" do
  it "is loaded and enabled in the test environment" do
    expect(defined?(Bullet)).to eq("constant")
    expect(Bullet.enable?).to be true
  end

  it "does not raise on examples that touch no ActiveRecord associations" do
    expect { 1 + 1 }.not_to raise_error
  end
end

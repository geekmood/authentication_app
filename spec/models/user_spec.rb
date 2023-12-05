require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    described_class.new(
      full_name: 'John Doe',
      email: 'john@example.com',
      password: 'password123'
    )
  end

  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_length_of(:full_name).is_at_most(255) }
    
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should_not allow_value(nil).for(:password) }
  end
end

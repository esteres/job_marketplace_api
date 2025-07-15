require 'rails_helper'
require_relative '../support/shared_examples/shared_identity_validations'

RSpec.describe Client, type: :model do
  it_behaves_like "a user-like model with validated identity"

  describe 'associations' do
    it { should have_many(:opportunities).dependent(:destroy) }
  end
end

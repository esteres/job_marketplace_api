RSpec.shared_examples "a user-like model with validated identity" do
  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'normalizes email by stripping and downcasing' do
      model = described_class.create!(
        name: "Test",
        email: "  TEST@Example.COM  "
      )
      expect(model.email).to eq("test@example.com")
    end

    it 'rejects invalid email formats' do
      model = described_class.new(name: "Invalid", email: "not_an_email")
      expect(model).to be_invalid
      expect(model.errors[:email]).to include("is invalid. Please enter a valid email address")
    end

    it 'rejects emails longer than 255 characters' do
      long_email = "a" * 244 + "@example.com"
      model = described_class.new(name: "Too Long", email: long_email)
      expect(model).to be_invalid
      expect(model.errors[:email]).to include("is too long (maximum is 255 characters)")
    end
  end
end

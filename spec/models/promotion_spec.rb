require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'validation' do
    subject { FactoryBot.build(:promotion) }

    it { should validate_presence_of(:name) }
    
    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:promo_type) }
    it { should validate_inclusion_of(:promo_type).in_array(%w[item_discount]) }

  end
end

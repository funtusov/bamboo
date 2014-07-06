RSpec.shared_context "multitenancy" do
  let!(:shop) { create :shop }
  let!(:another_shop) { create :shop, domain: 'anothershop.com' }

  before :all do
    host! 'bookshop.com'
  end

  before :each do
    10.times do
      shop.products << FactoryGirl.create(:product)
    end

    5.times do
      another_shop.products << FactoryGirl.create(:product)
    end
  end
end
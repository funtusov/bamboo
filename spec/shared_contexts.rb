RSpec.shared_context "multitenancy" do
  let!(:shop) { create :shop }
  let!(:another_shop) { create :shop, domain: 'anothershop.com' }

  before :each do
    begin 
      host! 'bookshop.com'
    rescue
      @request.host = 'bookshop.com'
    end

    10.times do
      shop.products << FactoryGirl.create(:product)
    end

    5.times do
      another_shop.products << FactoryGirl.create(:product)
    end
  end
end
RSpec.shared_context 'multitenancy' do
  let!(:shop) { create :shop }
  let!(:another_shop) { create :shop, domain: 'anothershop.com' }

  before :each do
    domain = 'bookshop.com'

    if @request 
      @request.host = domain
    else
      host! domain
    end

    create_list(:product, 10, shop: shop)
    create_list(:product, 5, shop: another_shop)
  end
end

RSpec.shared_context 'visitor created' do
  let!(:current_user) { create(:user, shop: shop) }
  let!(:another_user) { create(:user, shop: shop) }

  before :each do
    if @request
      sign_in current_user
    else
      login_as current_user, scope: :user
    end
  end
end
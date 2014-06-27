require 'spec_helper'

describe Shop do
  let(:shop) { create :shop, domain: 'bookshop.com' }

  xit {
    expect(shop.domain).to eq('bookshop.com')
  }
end
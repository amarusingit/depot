class StoreController < ApplicationController
  def index
  	@products = Product.order(:title)
  	@leftbartime = Time.now
  end
end

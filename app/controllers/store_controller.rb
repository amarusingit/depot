class StoreController < ApplicationController
  def index
  	@products = Product.order(:title)
  	@leftbartime = Time.now
  	if session[:counter].nil?
  		session[:counter] = 1
  	else
  		session[:counter] += 1
  	end
  end
end

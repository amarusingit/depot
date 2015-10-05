
class PayType < ActiveRecord::Base
	has_many :order

	def self.names
    	all.collect { |pay_type| pay_type.name }
  	end
end

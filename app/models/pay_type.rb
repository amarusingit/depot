
class PayType < ActiveRecord::Base
	def self.names
    	all.collect { |pay_type| pay_type.name }
  	end
end

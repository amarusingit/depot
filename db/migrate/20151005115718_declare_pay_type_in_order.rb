class DeclarePayTypeInOrder < ActiveRecord::Migration
  def change
		Order.all.each do |order|
  			unless order.pay_type.nil?
  				current_pay_type = PayType.find_by title: order.pay_type
  				unless current_pay_type
  					current_pay_type = PayType.new title: order.pay_type
  					current_pay_type.save
  					puts "Добавили новый тип=#{current_pay_type.title}"
   				end	
  				order.pay_type_id = current_pay_type.id
  				order.save
 			end	
 		end	  	
  end
end

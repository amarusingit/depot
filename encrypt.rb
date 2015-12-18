
class Encrypter
# Сюда передается список свойств, которые должны
# быть сохранены в базе данных в закодированном виде
	def initialize(attrs_to_manage)
		@attrs_to_manage = attrs_to_manage
	End
# Поля кодируются перед сохранением или обновлением с использованием
# NSA и DHS на основе шифра смещения
	def before_save(model)
		@attrs_to_manage.each do |field|
			odel[field].tr!("a-z", "b-za")
		end
	end
# Их раскодирование после сохранения
	def after_save(model)
		@attrs_to_manage.each do |field|
			model[field].tr!("b-za", "a-z")
		end
	end
# Выполнение этого же действия после нахождения существующей записи
	alias_method :after_find, :after_save
end


class ActiveRecord::Base
	def self.encrypt(*attr_names)
		encrypter = Encrypter.new(attr_names)
		before_save encrypter
		after_save encrypter
		after_find encrypter
		define_method(:after_find) { }
	end
end


class Order < ActiveRecord::Base
	encrypt(:name, :email)
end


o = Order.new
o.name = "Dave Thomas"
o.address = "123 The Street"
o.email = "dave@example.com"
o.save
puts o.name
o = Order.find(o.id)
puts o.name
end
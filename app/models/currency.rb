class Currency < ActiveRecord::Base
	validates :curs, :datecurs, presence: true
	validates :curs, numericality: {greater_than_or_equal_to: 0.5}
    validates :curs, numericality: {less_than_or_equal_to: 2.0}
    validates :datecurs, uniqueness: {message: 'На заданную дату уже установлен курс обмена валюты !'}
end

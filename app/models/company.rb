class Company < ApplicationRecord
	belongs_to :user, optional: true
	has_many :cash_managments, dependent: :destroy
end

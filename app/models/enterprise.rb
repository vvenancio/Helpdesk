class Enterprise < ActiveRecord::Base
	belongs_to :user 
	has_many :contracts
	has_many :tickets

	validates :name, presence: true
	validates :corporate_name, presence: true
	validates :phone, presence: true
	validates :cnpj, presence: true
	validates :state_registration, presence: true
	validates :adress, presence:true
	validates :number, presence:true
	validates :district, presence:true
	validates :city, presence:true
	validates :cep, presence:true
end
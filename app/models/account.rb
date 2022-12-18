class Account < ApplicationRecord
  validates :name, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :address, presence: true
  validates :vat, presence: true, uniqueness: true

  def self.valvat(vat)
    Valvat.new("EL"+vat.to_s).exists?(detail: true)
  end
end

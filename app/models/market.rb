class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :county, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :lat, presence: true
  validates :lon, presence: true

  def vendor_count
    self.vendors.count
  end

  def self.search(search_params)
    # unless (search_params[:city] && search_params[:name]) || search_params[:name]
    unless search_params.keys.sort == [:city, :name] || search_params.keys.sort == [:city]
      where("name ILIKE ? AND city ILIKE ? AND state ILIKE ?", "%#{search_params[:name]}%", "%#{search_params[:city]}%", "%#{search_params[:state]}%")
    end 
  end
end

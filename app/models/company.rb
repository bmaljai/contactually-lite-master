class Company < ActiveRecord::Base
  has_many :users
  has_many :contacts
  def check_or_create

  end
end

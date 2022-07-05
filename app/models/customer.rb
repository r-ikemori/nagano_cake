class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :addresses, dependent: :destroy
         has_many :orders, dependent: :destroy
         has_many :cart_items
  def fullname
    first_name+last_name
  end
  def fullname_kana
    last_name_kana+first_name_kana
  end


end

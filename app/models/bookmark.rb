class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :game


  def self.filter_price(params)
    if params[:price].present?
      case params[:price]
      when "0"
        where('games.price': 0)
      when "1..500"
        where('games.price': 1..501)
      when "501..2000"
        where('games.price': 501..2000)
      when "2001..5000"
        where('games.price': 2001..5000)
      when "5001.."
        where('games.price': 5001..)
      else
        all
      end
    else
      all
    end
  end
end
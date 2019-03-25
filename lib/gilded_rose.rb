require "lib/item_obj.rb"
def update_quality(items)
  items.each do |item|
    item_obj = ItemObj.new(item.name, item.sell_in, item.quality)
    if item_obj.brie
      if item_obj.sell_in_present && item_obj.qual_less_than_fifty
        add_quality(item, 1) 
      elsif item_obj.sell_in_zero_or_less && item_obj.qual_less_than_or_eq_max_by(2)
        add_quality(item, 2)
      else  
        item.quality = 50
      end
      decrease_sell_in_date(item)
    elsif item_obj.sulfuras
    elsif item_obj.backstage         
      if item_obj.sell_in_zero_or_less 
        item.quality = 0
      elsif item_obj.backstage_check_for_add_two
        add_quality(item, 2)
      elsif item_obj.backstage_check_for_add_three
        add_quality(item, 3)
      elsif item.sell_in > 10 && item_obj.qual_less_than_fifty
        add_quality(item, 1)
      end
      decrease_sell_in_date(item)
    elsif item_obj.conjured 
      (item_obj.sell_in_present ? remove_quality(item, 2) : remove_quality(item, 4)) unless item_obj.qual_zero
      decrease_sell_in_date(item)
    else
      (item_obj.sell_in_present ? remove_quality(item, 1) : remove_quality(item, 2)) unless item_obj.qual_zero
      decrease_sell_in_date(item)
    end
  end
end

def decrease_sell_in_date(item)
  item.sell_in -= 1 
end

def add_quality(item, inc)
  item.quality += inc 
end

def remove_quality(item, dec)
  item.quality -= dec
end
#----------------------------
# DO NOT CHANGE THINGS BELOW
#----------------------------

Item = Struct.new(:name, :sell_in, :quality)

class ItemObj < Item

  def brie
    name == 'Aged Brie'
  end

  def sulfuras
    name == 'Sulfuras, Hand of Ragnaros'
  end

  def backstage
    name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def conjured
    name == 'Conjured Mana Cake'
  end

  def qual_zero
      quality == 0
  end

  def sell_in_present
      sell_in > 0
  end

  def qual_less_than_fifty
      quality < 50
  end
  def sell_in_less_than_or_eq(num)
      sell_in <= num
  end

  def sell_in_zero_or_less
      sell_in_less_than_or_eq(0)
  end

  def max_qual
    50
  end

  def qual_less_than_or_eq_max_by(num)
      quality <= (max_qual - num)
  end

  def backstage_check_for_add_two
      sell_in_present && sell_in_less_than_or_eq(10) && sell_in > 5 && qual_less_than_or_eq_max_by(2)
  end

  def backstage_check_for_add_three
      sell_in_present && sell_in_less_than_or_eq(5) && qual_less_than_or_eq_max_by(3)
  end

end
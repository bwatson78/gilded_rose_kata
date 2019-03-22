def update_quality(items)
  items.each do |item|
    case item.name
    when 'Aged Brie'
      if sell_in_present(item) && qual_less_than_fifty(item)
        add_quality(item, 1) 
      elsif sell_in_zero_or_less(item) && qual_less_than_or_eq_max_by(item, 2)
        add_quality(item, 2)
      else  
        item.quality = 50
      end
      decrease_sell_in_date(item)
    when 'Sulfuras, Hand of Ragnaros'
    when 'Backstage passes to a TAFKAL80ETC concert'
      if sell_in_zero_or_less(item) 
        item.quality = 0
      elsif backstage_check_for_add_two(item)
        add_quality(item, 2)
      elsif backstage_check_for_add_three(item)
        add_quality(item, 3)
      elsif item.sell_in > 10 && qual_less_than_fifty(item)
        add_quality(item, 1)
      end
      decrease_sell_in_date(item)
    when 'Conjured Mana Cake'
      (sell_in_present(item) ? remove_quality(item, 2) : remove_quality(item, 4)) unless qual_zero(item)
      decrease_sell_in_date(item)
    else
      (sell_in_present(item) ? remove_quality(item, 1) : remove_quality(item, 2)) unless qual_zero(item)
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

def qual_zero(item)
  item.quality == 0
end

def sell_in_present(item)
  item.sell_in > 0
end

def qual_less_than_fifty(item)
  item.quality < 50
end

def sell_in_less_than_or_eq(item, num)
  item.sell_in <= num
end

def sell_in_zero_or_less(item)
  sell_in_less_than_or_eq(item, 0)
end

def max_qual
  50
end

def qual_less_than_or_eq_max_by(item, num)
  item.quality <= (max_qual - num)
end

def backstage_check_for_add_two(item)
  sell_in_present(item) && sell_in_less_than_or_eq(item, 10) && item.sell_in > 5 && qual_less_than_or_eq_max_by(item, 2)
end

def backstage_check_for_add_three(item)
  sell_in_present(item) && sell_in_less_than_or_eq(item, 5) && qual_less_than_or_eq_max_by(item, 3)
end
#----------------------------
# DO NOT CHANGE THINGS BELOW
#----------------------------

Item = Struct.new(:name, :sell_in, :quality)

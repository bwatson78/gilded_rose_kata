def update_quality(items)
  items.each do |item|
    case item.name
    when 'Aged Brie'
      if item.sell_in > 0 && item.quality < 50
        add_quality(item, 1) 
      elsif item.sell_in <= 0 && item.quality <= 48
        item.quality += 2 
      else  
        item.quality = 50
      end
      decrease_sell_in_date(item)
    when 'Sulfuras, Hand of Ragnaros'
    when 'Backstage passes to a TAFKAL80ETC concert'
      if item.sell_in <= 0 
        item.quality = 0
      elsif item.sell_in > 0 && item.sell_in <= 10 && item.sell_in > 5 && item.quality <= 48
        item.quality += 2
      elsif item.sell_in > 0 && item.sell_in <= 5 && item.quality <= 47
        item.quality += 3 
      elsif item.sell_in > 10 && item.quality < 50
        item.quality += 1
      end
      decrease_sell_in_date(item)
    when 'Conjured Mana Cake'
      (item.sell_in > 0 ? item.quality -= 2 :  item.quality -= 4) unless item.quality == 0
      decrease_sell_in_date(item)
    else
      (item.sell_in > 0 ? item.quality -= 1 :  item.quality -= 2) unless item.quality == 0
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
#----------------------------
# DO NOT CHANGE THINGS BELOW
#----------------------------

Item = Struct.new(:name, :sell_in, :quality)

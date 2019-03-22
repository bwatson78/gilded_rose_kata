def update_quality(items)
  items.each do |item|
    case item.name
    when 'Aged Brie'
      if item.sell_in > 0 && item.quality < 50
        item.quality += 1 
      elsif item.sell_in <= 0 && item.quality <= 48
        item.quality += 2 
      else  
        item.quality = 50
      end
      item.sell_in -= 1 
    when 'Sulfuras, Hand of Ragnaros'
    else
      (item.sell_in > 0 ? item.quality -= 1 :  item.quality -= 2) unless item.quality == 0
      item.sell_in -= 1 
    end
  end
end

#----------------------------
# DO NOT CHANGE THINGS BELOW
#----------------------------

Item = Struct.new(:name, :sell_in, :quality)

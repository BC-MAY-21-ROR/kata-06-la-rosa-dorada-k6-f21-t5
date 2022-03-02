# frozen_string_literal: true

# Class 
class GildedRose
  def initialize(items)
    @items = items
  end

  def normal_item(item)
    if item.quality.positive?
      item.quality = if item.sell_in.positive? || item.quality == 1
                       item.quality - 1
                     else
                       item.quality - 2 
                     end
    else
      item.quality = 0
    end
  end

  def backstage_quality(item)
    if item.quality < 50
      item.quality += 1
      item.quality += 1 if item.sell_in < 11 && item.quality < 50
      item.quality += 1 if item.sell_in < 6 && item.quality < 50
    end
    item.quality = 0 if item.sell_in <= 0
  end

  def aged_brie_quality(item)
    if item.quality < 50
      item.quality += 1
      item.quality += 1 if item.sell_in <= 0 && item.quality < 50
    end
  end

  def update_quality
    @items.each do |item|
      next if item.name == 'Sulfuras, Hand of Ragnaros'

      case item.name
      when 'Aged Brie' then aged_brie_quality(item)
      when 'Backstage passes to a TAFKAL80ETC concert' then backstage_quality(item)
      else
        normal_item(item)
      end
      item.sell_in = item.sell_in - 1
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end



# -------- day 0 --------
# name, sellIn, quality
# +5 Dexterity Vest, 10, 20
# Aged Brie, 2, 0
# Elixir of the Mongoose, 5, 7
# Sulfuras, Hand of Ragnaros, 0, 80
# Sulfuras, Hand of Ragnaros, -1, 80
# Backstage passes to a TAFKAL80ETC concert, 15, 20
# Backstage passes to a TAFKAL80ETC concert, 10, 49
# Backstage passes to a TAFKAL80ETC concert, 5, 49
# Conjured Mana Cake, 3, 6

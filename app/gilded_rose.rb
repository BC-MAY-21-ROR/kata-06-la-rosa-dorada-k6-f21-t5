# frozen_string_literal: true

# Class
class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def normal_item(item)
    if item.quality.positive?
      item.quality -= (item.sell_in.positive? || item.quality == 1) ? 1 : 2
    end
  end

  def conjured_item?(item)
    normal_item(item)
    normal_item(item) if item.name.include?("Conjured")
  end

  def upgrade_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def backstage_quality(item)
    upgrade_quality(item)
    upgrade_quality(item) if item.sell_in < 11
    upgrade_quality(item) if item.sell_in < 6
    item.quality = 0 if item.sell_in <= 0
  end

  def aged_brie_quality(item)
    upgrade_quality(item)
    upgrade_quality(item) if item.sell_in <= 0
  end

  def update_quality
    @items.each do |item|
      next if item.name == 'Sulfuras, Hand of Ragnaros'
      update_quality_cases(item)
      item.sell_in = item.sell_in - 1
    end
  end

  def update_quality_cases(item)
    case item.name
    when 'Aged Brie' then aged_brie_quality(item)
    when 'Backstage passes to a TAFKAL80ETC concert' then backstage_quality(item)
    else conjured_item?(item)
    end
  end
end

# Class
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

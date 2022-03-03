# frozen_string_literal: true
require 'rspec'
require_relative '../app/gilded_rose'
require_relative '../app/item.rb'

normal_items = [Item.new('foo', 20, 30), Item.new('foo', -1, 5), Item.new('foo', -1, 0)]
upgrade_items = [Item.new('Backstage',13,5), Item.new('Backstage',13,50)]
backstage_items = [Item.new('Backstage',13,10), Item.new('Backstage',7,10),Item.new('Backstage',1,10),Item.new('Backstage',0,10)]
aged_brie_items = [Item.new('Aged Brie',13,10), Item.new('Aged Brie',-1,10)]
update_items = [
  Item.new('Conjured Mirro',13,10), Item.new('Aged Brie',-1,10), 
  Item.new('Backstage passes to a TAFKAL80ETC concert',4,10), 
  Item.new('Sulfuras, Hand of Ragnaros',30,50), Item.new('foo', 20, 30)
]
gilded_rose = GildedRose.new(update_items)

describe GildedRose do
  # .normal_item test
  describe '.normal_item test' do
    3.times { |item| gilded_rose.normal_item(normal_items[item]) }
    context 'when sell_in > 0: ' do
      it 'should reduce quality in 1' do
        expect(normal_items[0].quality).to eq 29
      end
    end
    context 'when sell_in < 0: ' do
      it 'should reduce quality in 2' do
        expect(normal_items[1].quality).to eq 3
      end
    end
    
    context 'when quality become 0: ' do
      it 'quality shouldnt be negative' do
        expect(normal_items[2].quality).to eq 0
      end
    end
  end
  

  describe '.upgrade_quality' do
      upgrade_items.each {|item| gilded_rose.upgrade_quality(item)}
    context 'when quality is < 50 add 1' do
      it 'should add 1' do
        expect(upgrade_items[0].quality).to eq 6
      end
    end

    context 'when quality is == 50 stays the same' do
      it 'does nothing' do
        expect(upgrade_items[1].quality).to eq 50
      end
    end
  end
  
  # .backstage_quality test
  describe '.backstage_quality' do
    backstage_items.each {|item| gilded_rose.backstage_quality(item)}
    context 'when item.sell_in > 10:' do
      it 'should increase quality in 1' do
        expect(backstage_items[0].quality).to eq 11
      end
    end

    context 'when item.sell_in <= 10 and > 5:' do
      it 'should increase quality in 2 ' do
        expect(backstage_items[1].quality).to eq 12
      end
    end

    context 'when item.sell_in < 5 and > 0:' do
      it 'should increase quality in 3' do
        expect(backstage_items[2].quality).to eq 13
      end
    end

    context 'when item.sell_in <= 0:' do
      it 'should decrease quality to 0' do
        expect(backstage_items[3].quality).to eq 0
      end
    end
    
  end

  # .aged_brie_quality test
  describe '.aged_brie_quality' do
    2.times {|item| gilded_rose.aged_brie_quality(aged_brie_items[item])}
    context 'when item.sell_in > 0:' do
      it 'should increase quality in 1' do
        expect(aged_brie_items[0].quality).to eq 11
      end
    end

    context 'when item.sell_in <= 0:' do
      it 'should increase quality in 2 ' do
        expect(aged_brie_items[1].quality).to eq 12
      end
    end
  end

  # .conjured_item? test
  describe '.conjured_item?' do
    context 'when item is <Conjured>:' do
      it 'should degrade in Quality twice' do
        item = Item.new('Conjured Mirro',13,10)
        gilded_rose.conjured_item?(item)
        expect(item.quality).to eq 8
      end
    end
  end

  describe '.update_quality' do
    gilded_rose.update_quality
    context 'when a item is Conjured:' do
      it 'quality changes according to its rules' do
        expect(gilded_rose.items[0].quality).to eq 8
      end
    end
    
    context 'when a item is Aged Brie:' do
      it 'quality changes according to its rules' do
        expect(gilded_rose.items[1].quality).to eq 12
      end
    end

    context 'when a item is Backstage passes to a TAFKAL80ETC concert:' do
      it 'quality changes according to its rules' do
        expect(gilded_rose.items[2].quality).to eq 13
      end
    end

    context 'when a item is Sulfuras, Hand of Ragnaros:' do
      it 'quality changes according to its rules' do
        expect(gilded_rose.items[3].quality).to eq 50
      end
    end
    context 'when a item is normal:' do
      it 'quality changes according to its rules' do
        expect(gilded_rose.items[4].quality).to eq 29
      end
    end
  end
  
end


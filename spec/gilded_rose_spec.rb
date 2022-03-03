# frozen_string_literal: true
require 'rspec'
require_relative '../app/gilded_rose'


describe GildedRose do
  before(:each) do
    items = []
    @gilded_rose = GildedRose.new(items)
  end

  # .normal_item test
  describe '.normal_item test' do
    before(:each) do
      @products = [Item.new('foo', 20, 30), Item.new('foo', -1, 5), Item.new('foo', -1, 0)]
      @products.each {|item| @gilded_rose.normal_item(item)}
    end
    context 'when sell_in > 0: ' do
      it 'should reduce quality in 1' do
        expect(@products[0].quality).to eq 29
      end
    end
    
    context 'when sell_in < 0: ' do
      it 'should reduce quality in 2' do
        expect(@products[1].quality).to eq 3
      end
    end
    
    context 'when quality become 0: ' do
      it 'quality shouldnt be negative' do
        expect(@products[2].quality).to eq 0
      end
    end
  end

  # .update_quality test
  describe '.upgrade_quality' do
    before(:each) do
      @items = [Item.new('Backstage',13,5), Item.new('Backstage',13,50)]
      @items.each {|item| @gilded_rose.upgrade_quality(item)}
    end
    context 'when quality is < 50 add 1' do
      it 'should add 1' do
        expect(@items[0].quality).to eq 6
      end
    end

    context 'when quality is == 50 stays the same' do
      it 'does nothing' do
        expect(@items[1].quality).to eq 50
      end
    end
  end
  
  # .backstage_quality test
  describe '.backstage_quality' do
    before(:each) do
      @items = [Item.new('Backstage',13,10), Item.new('Backstage',7,10), Item.new('Backstage',1,10), Item.new('Backstage',0,10)]
      @items.each {|item| @gilded_rose.backstage_quality(item)}
    end
    context 'when item.sell_in > 10:' do
      it 'should increase quality in 1' do
        expect(@items[0].quality).to eq 11
      end
    end

    context 'when item.sell_in <= 10 and > 5:' do
      it 'should increase quality in 2 ' do
        expect(@items[1].quality).to eq 12
      end
    end

    context 'when item.sell_in < 5 and > 0:' do
      it 'should increase quality in 3' do
        expect(@items[2].quality).to eq 13
      end
    end

    context 'when item.sell_in <= 0:' do
      it 'should decrease quality to 0' do
        expect(@items[3].quality).to eq 0
      end
    end
    
  end

  # .aged_brie_quality test
  describe '.aged_brie_quality' do
    before(:each) do
      @items = [Item.new('Aged_brie',13,10), Item.new('Aged_brie',-1,10)]
      @items.each {|item| @gilded_rose.aged_brie_quality(item)}
    end
    context 'when item.sell_in > 0:' do
      it 'should increase quality in 1' do
        expect(@items[0].quality).to eq 11
      end
    end

    context 'when item.sell_in <= 0:' do
      it 'should increase quality in 2 ' do
        expect(@items[1].quality).to eq 12
      end
    end
  end

  # .conjured_item? test
  describe '.conjured_item?' do
    context 'when item is <Conjured>:' do
      it 'should degrade in Quality twice' do
        item = Item.new('Conjured Mirro',13,10)
        @gilded_rose.conjured_item?(item)
        expect(item.quality).to eq 8
      end
    end
  end

  describe '.update_quality' do
    before(:each) do
      items = [Item.new('Conjured Mirro',13,10), Item.new('Aged Brie',-1,10), Item.new('Backstage passes to a TAFKAL80ETC concert',4,10), Item.new('Sulfuras, Hand of Ragnaros',30,50)]
      @gilded_rose = GildedRose.new(items)
      @gilded_rose.update_quality
    end
    context 'when a item is Conjured:' do
      it 'quality changes according to its rules' do
        expect(@gilded_rose.items[0].quality).to eq 8
      end
    end
    
    context 'when a item is Aged Brie:' do
      it 'quality changes according to its rules' do
        expect(@gilded_rose.items[1].quality).to eq 12
      end
    end

    context 'when a item is Backstage passes to a TAFKAL80ETC concert:' do
      it 'quality changes according to its rules' do
        expect(@gilded_rose.items[2].quality).to eq 13
      end
    end

    context 'when a item is Sulfuras, Hand of Ragnaros:' do
      it 'quality changes according to its rulesm' do
        expect(@gilded_rose.items[3].quality).to eq 50
      end
    end
  end
  
end

#items = [Item.new('Conjured Mirro',13,10), Item.new('Aged Brie',-1,10), Item.new('Backstage passes to a TAFKAL80ETC concert',4,10), Item.new('Sulfuras, Hand of Ragnaros',30,50), ]


# frozen_string_literal: true
require 'rspec'
require_relative '../gilded_rose'


describe GildedRose do
  before(:each) do
    items = []
    @gilded_rose = GildedRose.new(items)
  end

  # .normal_item test
  describe '.normal_item test' do
    context 'when sell_in > 0: ' do
      it 'should reduce quality in 1' do
        product = [Item.new('foo', 20, 30)]
        10.times {@gilded_rose.normal_item(product[0])}
        expect(product[0].quality).to eq 20
      end
    end
    
    context 'when sell_in < 0: ' do
      it 'should reduce quality in 2' do
        product = [Item.new('foo', -1, 30)]
        11.times {@gilded_rose.normal_item(product[0])}
        expect(product[0].quality).to eq 8
      end
    end
    
    context 'when quality become 0: ' do
      it 'quality shouldnt be negative' do
        product = [Item.new('foo', -1, 5)]
        11.times {@gilded_rose.normal_item(product[0])}
        expect(product[0].quality).to eq 0
      end
    end
  end

  # .update_quality test
  describe '.upgrade_quality' do

    context 'when quality is < 50 add 1' do
      it 'should add 1' do
        item = Item.new('Backstage',13,5)
        @gilded_rose.upgrade_quality(item)
        expect(item.quality).to eq 6
      end
    end

    context 'when quality is == 50 stays the same' do
      it 'does nothing' do
        item = Item.new('Backstage',13,50)
        @gilded_rose.upgrade_quality(item)
        expect(item.quality).to eq 50
      end
    end
  end
  
  # .backstage_quality test
  describe '.backstage_quality' do

    context 'when item.sell_in > 10:' do
      it 'should increase quality in 1' do
        item = Item.new('Backstage',13,10)
        @gilded_rose.backstage_quality(item)
        expect(item.quality).to eq 11
      end
    end

    context 'when item.sell_in <= 10 and > 5:' do
      it 'should increase quality in 2 ' do
        item = Item.new('Backstage',7,10)
        @gilded_rose.backstage_quality(item)
        expect(item.quality).to eq 12
      end
    end

    context 'when item.sell_in < 5 and > 0:' do
      it 'should increase quality in 3' do
        item = Item.new('Backstage',1,10)
        @gilded_rose.backstage_quality(item)
        expect(item.quality).to eq 13
      end
    end

    context 'when item.sell_in <= 0:' do
      it 'should decrease quality to 0' do
        item = Item.new('Backstage',0,10)
        @gilded_rose.backstage_quality(item)
        expect(item.quality).to eq 0
      end
    end
    
  end

  # .aged_brie_quality test
  describe '.aged_brie_quality' do

    context 'when item.sell_in > 0:' do
      it 'should increase quality in 1' do
        item = Item.new('Aged_brie',13,10)
        @gilded_rose.aged_brie_quality(item)
        expect(item.quality).to eq 11
      end
    end

    context 'when item.sell_in <= 0:' do
      it 'should increase quality in 2 ' do
        item = Item.new('Aged_brie',-1,10)
        @gilded_rose.aged_brie_quality(item)
        expect(item.quality).to eq 12
      end
    end
  end
  
end

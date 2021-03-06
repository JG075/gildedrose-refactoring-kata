class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if should_be_updated?(item)
        case item.name
        when "Aged Brie" then update_aged_brie(item)
        when "Backstage passes to a TAFKAL80ETC concert" then update_passes(item)
        when "Conjured" then update_conjured(item)
        else update_normal_items(item)
        end
        item.sell_in -= 1 if item.name
      end
    end
  end

  private

  def should_be_updated?(item)
    item.name != "Sulfuras, Hand of Ragnaros" && item.quality < 50
  end

  def update_aged_brie(item)
    item.quality += 1
  end

  def update_conjured(item)
    item.quality -= 2
  end

  def update_passes(item)
    if item.sell_in > 10
      item.quality += 1
    else
      item.sell_in <= 5 ? item.quality += 3 : item.quality +=2
    end
    item.quality = 0 if item.sell_in <= 0
  end

  def update_normal_items(item)
    item.sell_in <= 0 ? item.quality -= 2 : item.quality -= 1
    item.quality = 0 if item.quality < 0
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

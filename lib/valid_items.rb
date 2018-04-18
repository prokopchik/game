class Validitems
  def initialize(items)
    @items = items.uniq
  end

  attr_reader :items

  def call
    raise "Insufficient unique items in the configuration" if items.size < 3

    return items if items.size.odd?

    items[0..(items.size - 2)]
  end
end
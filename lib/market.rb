class Market

  attr_reader :name,
              :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    result = []
    @vendors.each do |vendor|
      result << vendor if vendor.inventory[item] > 0
    end
    result
  end

  def total_inventory
    result = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        sum_total = vendors_that_sell(item).sum do |sum_vendor|
          sum_vendor.inventory[item]
        end
        result[item] = {quantity: sum_total, vendors: vendors_that_sell(item)}
      end
    end
    result
  end

  def overstocked_items
    result = []
    total_inventory.each do |item, info|
      result << item if info[:quantity] > 50 && info[:vendors].count > 1
    end
    result
  end


end

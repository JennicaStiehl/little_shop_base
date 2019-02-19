require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
  end

  describe 'Class Methods' do
    before :each do
      @o1 = create(:completed_order)
      @o2 = create(:completed_order)
      @o3 = create(:completed_order)
      @o4 = create(:completed_order)
      @o5 = create(:cancelled_order)
      @o6 = create(:completed_order)
      @o7 = create(:completed_order)
      oi1 = create(:fulfilled_order_item, order: @o1)
      oi2 = create(:fulfilled_order_item, order: @o7)
      oi3 = create(:fulfilled_order_item, order: @o2)
      oi4 = create(:order_item, order: @o6)
      oi5 = create(:order_item, order: @o3)
      oi6 = create(:fulfilled_order_item, order: @o5)
      oi7 = create(:fulfilled_order_item, order: @o4)
    end

    it '.sorted_by_items_shipped' do
      expect(Order.sorted_by_items_shipped.to_a).to eq([@o4, @o2, @o7, @o1])
    end

    it '.top_orders_by_items_shipped' do
      expect(Order.top_orders_by_items_shipped(3)).to eq([@o4, @o2, @o7])
      expect(Order.top_orders_by_items_shipped(3)[0].id).to eq(@o4.id)
      expect(Order.top_orders_by_items_shipped(3)[0].quantity).to eq(16)
      expect(Order.top_orders_by_items_shipped(3)[1].id).to eq(@o2.id)
      expect(Order.top_orders_by_items_shipped(3)[1].quantity).to eq(8)
      expect(Order.top_orders_by_items_shipped(3)[2].id).to eq(@o7.id)
      expect(Order.top_orders_by_items_shipped(3)[2].quantity).to eq(6)
    end
  end

  describe 'instance methods' do
    before :each do
      user = create(:user)
      @item_1 = create(:item)
      @item_2 = create(:item)
      yesterday = 1.day.ago

      @order = create(:order, user: user, created_at: yesterday)
      @oi_1 = create(:order_item, order: @order, item: @item_1, price: 1, quantity: 1, created_at: yesterday, updated_at: yesterday)
      @oi_2 = create(:fulfilled_order_item, order: @order, item: @item_2, price: 2, quantity: 1, created_at: yesterday, updated_at: 2.hours.ago)
    end

    it '.total_item_count' do
      expect(@order.total_item_count).to eq(@oi_1.quantity + @oi_2.quantity)
    end

    it '.total_cost' do
      expect(@order.total_cost).to eq((@oi_1.quantity*@oi_1.price) + (@oi_2.quantity*@oi_2.price))
    end
  end
end

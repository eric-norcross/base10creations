class ItemPresenter < BasePresenter
  attr_reader :item

  def initialize(instance)
    super(instance)
    @item = instance
  end

end
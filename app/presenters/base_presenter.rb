class BasePresenter < SimpleDelegator
  attr_reader :class_name
  attr_reader :model

  def initialize(instance)
    super(instance)
    @model      = instance
    @class_name = instance.class.name.demodulize.tableize
  end

  # def main_image
  #   if self.images.present?
  #     self.images.sort_by(&:id).first
  #   end
  # end

  # def aggregate_images
  #   self.images
  # end
end
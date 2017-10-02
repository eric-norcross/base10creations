module ImagePresenter
  extend ActiveSupport::Concern
  
  def main_image
    aggregate_images.first
  end

  def random_image
    if figures.length > 0
      # TODO: Add randomization here
      figures.sort_by(&:id).first
    end
  end

  def aggregate_images
    # For whatever reason, sorting is required here to ensure proper functionality :-/
    figures.sort_by(&:order).reject{ |figure| !figure.active }
  end
end
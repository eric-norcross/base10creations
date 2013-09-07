class MessagesController < ApplicationController
  before_filter :find_messenger

  def create
    @message_requirements = {to: params[:to], from: params[:from], subject: params[:subject]}
    @message = @messenger.new(params[params[:message_type]])
    @page = Section.find(params[:section_id])
    @side_nav_elements = Section.where(parent_id: @page.parent_id)

    if @message.valid?
      ContactMailer.format(@message, @message_requirements).deliver
      redirect_to section_path(@page), flash: { notice: @message.success }
    else
      render @page.skin.template
    end
  end

  private

  def find_messenger
    @messenger = params[:message_type].classify.constantize
  end
end

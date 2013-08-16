class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    @side_nav_elements = Section.where(parent_id: 0)
    @page = Section.find(params[:section_id])

    if @message.valid?
      ContactMailer.get_in_touch(@message).deliver
      # TODO send message here
      render @page.skin.template, locals: { notice: "Message sent! Thank you for contacting us." }
    else
      render @page.skin.template
    end
  end
end

class EventsController < ApplicationController

  def index
    @events = Event.find :all, :order => '"when"'
  end

  def view_event
    @event = Event.find params[:id]
  end
  
  def edit_event
    if params[:id]
      @event = Event.find params[:id]
    else
      @event = Event.new :person => @logged_in
    end
    unless @event.admin?(@logged_in)
      raise 'You are not authorized to edit this event.'
    end
    if request.post?
      params[:event].cleanse 'when'
      if @event.update_attributes params[:event]
        redirect_to :action => 'view_event', :id => @event
      else
        flash[:notice] = @event.errors.full_messages.join('; ')
      end
    end
  end
  
  def delete_event
    @event = Event.find params[:id]
    @event.destroy if @event.admin? @logged_in
    redirect_to :action => 'index'
  end

end

class Authenticated::MainController < AuthenticatedController


  def set_viewed_notifications
    @profile_notifications = current_profile.notifications.filter_new
    @profile_notifications.update_all(state: 'viewed')
  end

  def to_teach_workshop
    @workshop = Workshop.find(params[:id])
    @workshop_schedules = @workshop.workshop_schedules
    @workshop_schedule_active = @workshop_schedules.first
    @workshop_schedule_message = WorkshopScheduleMessage.new(workshop_schedule: @workshop_schedule_active)

    @workshop_schedule_active.workshop_schedule_message_observers.state_new.joins(:workshop_schedule).where(workshop_schedules: {id: @workshop_schedule_active}).where(profile: current_profile).update_all(state: :viewed)
  end

  def to_learn_workshop
    @workshop = Workshop.find(params[:id])
    @workshop_schedules = @workshop.workshop_schedules
    @workshop_schedule_active = @workshop_schedules.first
    @workshop_schedule_message = WorkshopScheduleMessage.new(workshop_schedule: @workshop_schedule_active)

    @workshop_schedule_active.workshop_schedule_message_observers.state_new.joins(:workshop_schedule).where(workshop_schedules: {id: @workshop_schedule_active}).where(profile: current_profile).update_all(state: :viewed)
  end  


  def to_teach_workshop_schedule
    @workshop_schedule_active = WorkshopSchedule.find(params[:id])
    @workshop_schedule_message = WorkshopScheduleMessage.new(workshop_schedule: @workshop_schedule_active)


    @workshop_schedule_active.workshop_schedule_message_observers.state_new.joins(:workshop_schedule).where(workshop_schedules: {id: @workshop_schedule_active}).where(profile: current_profile).update_all(state: :viewed)


  end


  def workshop_schedule_message
    @workshop_schedule_message = WorkshopScheduleMessage.new(workshop_schedule_message_params)
    @workshop_schedule_message.profile = current_profile
    if @workshop_schedule_message.save
      @workshop_schedule_message_created = @workshop_schedule_message
      @workshop_schedule_message = WorkshopScheduleMessage.new(workshop_schedule: @workshop_schedule_message_created.workshop_schedule)
      flash[:success] = t(:success)
    else
      flash[:danger] = t(:error)
    end
  end



  def to_teach_workshops
      @state = params[:state] || :all
      @state = @state.to_sym
      @workshops = current_profile.workshops

      
      case @state
      when :draft
        @workshops = @workshops.filter_state_draft
      when :open
        @workshops = @workshops.filter_state_open
      when :in_progress
        @workshops = @workshops.filter_state_in_progress
      when :finish
        @workshops = @workshops.filter_state_finsh
      end
      @workshops = @workshops.uniq

  end

  def to_learn_workshops
      @state = params[:state] || :all
      @state = @state.to_sym
      @workshops = current_profile.subscribed_workshops
      if params[:id]
        @workshop = Workshop.find(params[:id])
      end 
      
      case @state
      when :open
        @workshops = @workshops.filter_state_open
      when :in_progress
        @workshops = @workshops.filter_state_in_progress
      when :finish
        @workshops = @workshops.filter_state_finsh
      end
      @workshops = @workshops.uniq

  end



  def workshop_comment
    @workshop_comment = WorkshopComment.new(workshop_comment_params)
    if @workshop_comment.save
      @workshop_comment_created = @workshop_comment
      @workshop_comment = WorkshopComment.new(normal_profile: current_profile, workshop: @workshop_comment.workshop)
      flash[:success] = t(:success)
    else
      flash[:danger] = t(:error)
    end
  end

  def destroy_workshop_comment
    @workshop_comment = WorkshopComment.find(params[:id])


    if @workshop_comment.destroy && @workshop_comment.normal_profile == current_profile
      flash[:success] = t(:success)
    else
      flash[:danger] = t(:error)
    end
  end


  def wishlist
      @workshops = current_profile.favorite_workshops
  end

  private


  def workshop_comment_params
    params.require(:workshop_comment).permit! if params[:workshop_comment]
  end


  def workshop_schedule_message_params
    params.require(:workshop_schedule_message).permit! if params[:workshop_schedule_message]
  end


end





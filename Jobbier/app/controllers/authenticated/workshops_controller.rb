class Authenticated::WorkshopsController < AuthenticatedController
  helper :application
  before_action :set_workshop, only: [:toggle_workshop_favorite, :main_wizard, :step, :update, :destroy]



  #---------------------------------------------------------------
  def create
    @workshop = Workshop.new(normal_profile: current_profile)
    current_profile
    @workshop.country = current_profile.country if current_profile.country.present?
    @workshop.province = current_profile.province if current_profile.province.present?
    @workshop.city = current_profile.city if current_profile.city.present?
    @workshop.street = current_profile.street if current_profile.street.present?
    @workshop.number = current_profile.number if current_profile.number.present?
    @workshop.floor = current_profile.floor if current_profile.floor.present?
    @workshop.apartment = current_profile.apartment if current_profile.apartment.present?


    @workshop.save
    redirect_to authenticated_workshops_main_wizard_path(@workshop)
  end



  def toggle_workshop_schedule_subscribed
    @workshop_schedule = WorkshopSchedule.find_by(id: params[:id])
    @workshop = @workshop_schedule.workshop

    if @workshop_schedule.present? && current_profile.present?

      workshop_schedule_subscribed = WorkshopScheduleSubscribed.where(normal_profile: current_profile, workshop_schedule: @workshop_schedule).first
      if workshop_schedule_subscribed.nil?
        @operation = 'added'




        @workshop_schedule.actual_quota += 1
        @workshop_schedule.save


        WorkshopScheduleSubscribed.create(normal_profile: current_profile, workshop_schedule: @workshop_schedule)
        #Antes de mostrar el mensaje de success envia un mail para confirmar la inscripción
        manager=MailerManager.new(
          sender: 'Soporte jobbier',
          sender_email:'no-reply@jobbier.com',
          subject: 'Confirmacion taller',
          recipients: [current_profile.email],
          template_name: 'jobbier-confirmacion-curso',
          template_params: {
            nombre: current_profile.name,
            workshop: @workshop.activity_title
                    })
        manager.call
        flash[:success] = t(:success)
      else
        @operation = 'removed'

        @workshop_schedule.actual_quota -= 1
        @workshop_schedule.save

        @id = params[:id]

        workshop_schedule_subscribed.destroy
        flash[:success] = t(:success)
      end
    end

    rescue ActiveRecord::StaleObjectError => e
      flash[:danger] = t(:error)
  end


  def toggle_workshop_favorite

    if @workshop.present? && current_profile.present?

      workshop_favorite = WorkshopFavorite.where(normal_profile: current_profile, workshop: @workshop).first
      if workshop_favorite.nil?
        @operation = 'added'
        WorkshopFavorite.create(normal_profile: current_profile, workshop: @workshop)
      else
        @operation = 'removed'
        workshop_favorite.destroy
      end

    end
  end


  def main_wizard
  end

  def step
    @workshop.step = params[:step]

    if @workshop.step == 'step_final'
      @similar_workshops = Workshop.filter_state_to_show.order('RAND()').limit(2)
    end


  end


  def update
    #-------------------------------------------------------------
    if @workshop.update(workshop_params)

      flash[:success] = t(:success)

      if (@workshop.step == 'step_final')
        @workshop.set_state_open
        redirect_to authenticated_main_to_teach_workshops_path
      else

        @workshop.set_step_true(@workshop.step)
        if @workshop.all_steps_finish?
          redirect_to authenticated_workshops_step_path(@workshop, 'step_final')
        else
          if ['step3', 'step5', 'step6'].include?(@workshop.step)
            redirect_to authenticated_workshops_main_wizard_path(@workshop)
          else
            redirect_to authenticated_workshops_step_path(@workshop, @workshop.next_step)
          end
        end

      end



    else
      flash[:danger] = t(:error)
      if @workshop.step == 'step_final'
        @similar_workshops = Workshop.filter_state_to_show.order('RAND()').limit(2)
      end
      render :step
    end
  end



  #---------------------------------------------------------------
  # DELETE /workshops/1
  def destroy
    if @workshop.destroy
      flash[:success] = t(:success)
    else
      flash[:danger] = t(:error)
    end
    respond_to do |format|
      format.html { redirect_to authenticated_main_to_teach_workshops_path }
      format.js
    end
  end





  private

  #---------------------------------------------------------------
  # Use callbacks to share common setup or constraints between actions.
  def set_workshop
    @workshop = Workshop.find_by(id: params[:id])
  end

  #---------------------------------------------------------------
  # Only allow a trusted parameter "white list" through.
  def workshop_params
    params.require(:workshop).permit!
  end

  #---------------------------------------------------------------
  def filter_params
    params.require(:filter).permit! if params[:filter]
  end

end

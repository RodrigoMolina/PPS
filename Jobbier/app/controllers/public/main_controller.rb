class Public::MainController < PublicController


  def index

    @filter = FrontendWorkshopFilter.new(label: 'Mi Ubicación', label_old: 'Mi Ubicación')

    @workshops = Workshop.filter_state_to_show.order('RAND()').uniq.limit(4)
    @categories = WorkshopCategory.order('RAND()')
  end

  def workshop_category
    @workshop_category = WorkshopCategory.find_by(id: params[:id])
    @workshops = @workshop_category.workshops.filter_state_to_show
    #TODO Paginacion
  end

  def workshop
    @workshop = Workshop.find_by(id: params[:id])
    @workshop_comment = WorkshopComment.new(normal_profile: current_profile, workshop: @workshop)
  end

  def profile
  	@profile = Profile.find_by(id: params[:id])
  end

  def how_to_instruct ; end

  def workshop_comments
    @workshop = Workshop.find_by(id: params[:id])
    @workshop_comments = @workshop.workshop_comments
  end

  def why_workshop ; end



  def who_can_be_a_instructor ; end
  def who_guarantee_workshops ; end

  def contact
    @message_normal_form = MessageNormalForm.new
  end

  def contact_send
    @message_normal_form = MessageNormalForm.new(message_normal_form_params)
    if @message_normal_form.save
      flash[:notice] = @message_normal_form.result_msg
      redirect_to public_main_contact_path
      manager = MailerManager.new(
        sender:     "#{@message_normal_form.name}",
        subject:    'Mensaje de sugerencia',
        recipients: ['hola@jobbier.com'],
        header:     'Tengo una sugerencia',
        body:       "#{@message_normal_form.content}"
      ).call
    else
      flash[:danger] = @message_normal_form.result_msg
      render :contact
    end
  end

  def about_us ; end

  def work_with_us ; end

  def search_workshop
    @filter = FrontendWorkshopFilter.new(filter_params)
    @workshops = @filter.call(current_profile)
    if @workshops.empty? then
      @workshop_all = Workshop.all
      filter_params[:query] = ""
      filter_params[:workshop_category_id] = ""
      @filter_near = FrontendWorkshopFilter.new(filter_params)
      @workshops_near = @filter_near.call(current_profile)
    end
    respond_to do |format|
      format.html {
        @workshop_categories = WorkshopCategory.order_default
      }
      format.js {
      }
    end
  end

  def catalogue
    @workshop = Workshop.find_by(id: params[:id])
    @workshops_near = (@workshop.city.present?)? Workshop.filter_state_to_show.where(city: @workshop.city).where.not(id: @workshop.id).limit(4) : []
    @workshops_same_category = (@workshop.workshop_category.present?)? Workshop.filter_state_to_show.where(workshop_category: @workshop.workshop_category).where.not(id: @workshop.id).limit(4) : []
    @last_workshops = Workshop.filter_state_to_show.order("created_at desc").where.not(id: @workshop.id).limit(4)
  end



  private

  def filter_params
    (params[:filter])? params.require(:filter).permit! : {}
  end

  def message_normal_form_params
    params.require(:message_normal_form).permit! if params[:message_normal_form]
  end

end

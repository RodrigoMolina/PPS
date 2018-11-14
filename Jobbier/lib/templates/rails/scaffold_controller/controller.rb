<% @will_paginate_instaled = Gem::Specification.collect{|x| x.name}.include?('will_paginate') %>
<% @kaminari_instaled = Gem::Specification.collect{|x| x.name}.include?('kaminari') %>
<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class Backend::<%= controller_class_name %>Controller < BackendController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  #---------------------------------------------------------------
  # GET <%= route_url %>
  def index
    @filter = <%= class_name %>Filter.new(filter_params)
    <%- if @will_paginate_instaled -%>
    @<%= plural_table_name %> = @filter.call.paginate(page: params[:page], per_page: Const::PER_PAGE)
    <%- else -%>
      <%- if @kaminari_instaled -%>
    @<%= plural_table_name %> = @filter.call.page(params[:page]).per(Const::PER_PAGE)
      <%- else -%>
    @<%= plural_table_name %> = @filter.call
      <%- end -%>
    <%- end -%>
  end

  #---------------------------------------------------------------
  # GET <%= route_url %>/1
  def show
  end

  #---------------------------------------------------------------
  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  #---------------------------------------------------------------
  # GET <%= route_url %>/1/edit
  def edit
  end

  #---------------------------------------------------------------
  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      flash[:success] = t(:success)
      respond_to do |format|
        format.html { redirect_to backend_<%= index_helper %>_path }
        format.js
      end
    else
      flash[:danger] = t(:error)
      render :new
    end
  end

  #---------------------------------------------------------------
  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      flash[:success] = t(:success)
      respond_to do |format|
        format.html { redirect_to backend_<%= index_helper %>_path }
        format.js
      end
    else
      flash[:danger] = t(:error)
      render :edit
    end
  end

    border-top: #B00100 solid 4px;
    border-top-left-radius: 9px;
    border-top-right-radius: 9px;
  #---------------------------------------------------------------
  # DELETE <%= route_url %>/1
  def destroy
    if @<%= orm_instance.destroy %>
      flash[:success] = t(:success)
    else
      flash[:danger] = t(:error)
    end
    respond_to do |format|
      format.html { redirect_to backend_<%= index_helper %>_path }
      format.js
    end
  end


  private

  #---------------------------------------------------------------
  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  #---------------------------------------------------------------
  # Only allow a trusted parameter "white list" through.
  def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
    params.fetch(:<%= singular_table_name %>, {})
    <%- else -%>
    params.require(:<%= singular_table_name %>).permit!
    <%- end -%>
  end
  
  #---------------------------------------------------------------
  def filter_params
    params.require(:filter).permit! if params[:filter]
  end

end
<% end -%>

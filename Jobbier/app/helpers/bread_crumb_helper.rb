 module BreadCrumbHelper

   def print_bread_crumbs(controller_name, action_name)
    steps = []
    # 
    case "#{controller_name}/#{action_name}"
    when 'main/index'
      steps << "<li class='active'>#{t :home}</li>"
    when 'registrations/edit', 'registrations/update'
      steps << "<li><a href='#{backend_root_url}'>#{t :home}</a></li>"
      steps << "<li class='active'>#{t :edit_profile}</li>"        
    end

    "<ol class='breadcrumb'>#{steps.join()}</ol>".html_safe if steps.any?
   end

end
class Rails::CustomErbGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      include Rails::Generators::ResourceHelpers

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def create_root_folder
        empty_directory File.join("app/views/backend", controller_file_path)
      end

      def copy_view_files


        if (self.behavior == :invoke)
          puts ''
          puts '    ╔══════════════════════════════════════════════════════════╗'
          puts "    ║ Form Normal      ->        (0)[Default]                  ║"
          puts "    ║ Form AJAX        ->        (1)                           ║"
          puts '    ╚══════════════════════════════════════════════════════════╝'
          @selected_form_mode = ask('')
          @selected_form_mode = '0' if @selected_form_mode.blank?

          puts ''
          puts '    ╔══════════════════════════════════════════════════════════╗'
          puts "    ║ Paginación Normal    ->        (0)[Default]              ║"
          puts "    ║ Paginacion Infinita  ->        (1)                       ║"
          puts '    ╚══════════════════════════════════════════════════════════╝'
          @selected_pagination_mode = ask('')
          @selected_pagination_mode = '0' if @selected_pagination_mode.blank?

        else
          @selected_form_mode = '2'
        end

        #Creo el filtro de la entidad creada
        template 'model_filter.rb', File.join("app/filters", "#{@file_name}_filter.rb")

        #Seteo variables, veo si esta instalado will_paginate o kaminari
        @will_paginate_instaled = Gem::Specification.collect{|x| x.name}.include?('will_paginate')
        @kaminari_instaled = Gem::Specification.collect{|x| x.name}.include?('kaminari')


        available_views.each do |view|
          if view == '_model.html.erb'
            template view, File.join("app/views/backend", controller_file_path, "_#{@file_name}.html.erb")
          else
            template view, File.join("app/views/backend", controller_file_path, view)
          end
        end


        run "mv app/controllers/#{controller_file_path}_controller.rb app/controllers/backend/#{controller_file_path}_controller.rb "

      end

    protected



      def available_views
        case @selected_form_mode
        when '0'
          ['index.html.erb', 'index.js.erb', 'edit.html.erb', 'show.html.erb', 'new.html.erb', '_form.html.erb', '_filter.html.erb', '_model.html.erb'] 
        when '1'
          ['index.html.erb', 'index.js.erb', 'edit.js.erb', 'show.js.erb', '_modal_show.html.erb', 'new.js.erb', '_form.html.erb', '_modal.html.erb', '_filter.html.erb', 'create.js.erb', 'update.js.erb', 'destroy.js.erb', '_model.html.erb'] 
        when '2'
          ['index.html.erb', 'index.js.erb', 'edit.html.erb', 'edit.js.erb', 'show.html.erb', 'show.js.erb', '_modal_show.html.erb', 'new.html.erb', 'new.js.erb', '_form.html.erb', '_modal.html.erb', '_filter.html.erb', 'create.js.erb', 'update.js.erb', 'destroy.js.erb', '_model.html.erb'] 
        end
      end


end


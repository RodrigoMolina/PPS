class FrontendWorkshopFilter
  include ActiveModel::Model

  attr_accessor :query, :order, :direction, :workshop_category_id, :label, :label_old, :label_changed, :latitude, :longitude, :este, :oeste, :norte, :sur, :zoom, :center_latitude, :center_longitude, :geo_ok


  def call(current_profile)
    require 'net/http'
    require 'json'



    radius = 0.5 #KM

    # 
    #if @label_changed == 'true'
    #  @label_changed = true  
    #else
      @label_changed = false
    #end


      # 

      if @label != @label_old
        @label_changed = true
        @label_old = @label
      end 

      # 
      if @label_changed && @label.present? && @label != 'Mi Ubicación'
        # 
        new_label = "#{@label} Argentina"
        uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{new_label}&key=#{Const::GMAPS_KEY}")
        response = Net::HTTP.get uri
        locations_json = JSON.parse(response)
        if locations_json['results'].any?
          @latitude = locations_json['results'][0]['geometry']['location']['lat']
          @longitude = locations_json['results'][0]['geometry']['location']['lng']
          @center_latitude = locations_json['results'][0]['geometry']['location']['lat']
          @center_longitude = locations_json['results'][0]['geometry']['location']['lng']
          @este = nil
          @oeste = nil
          @norte = nil
          @sur = nil
          @geo_ok = true
          # 
          @zoom = 13
        end

      elsif @label.blank?
        # 

          @latitude = -34.722468
          @longitude = -58.259128
          @center_latitude = -34.722468
          @center_longitude = -58.259128

          @geo_ok = false
          @zoom = 5

      else
        # 
        unless set_lat_and_lng?
          # 
          #QUILMES
          #-34.722468, -58.259128
          #LA PLATA
          #-34.92133765544518 , -57.95445442548953


          @latitude = -34.92133765544518
          @longitude = -57.95445442548953
          @center_latitude = -34.92133765544518
          @center_longitude = -57.95445442548953

          if current_profile.present?

            if current_profile.country_id.present? && current_profile.province_id.present? && current_profile.city_id.present?
              country = current_profile.country
              province = current_profile.province
              city = current_profile.city

              new_label = "#{city} #{province} #{country}"
              uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{new_label}&key=#{Const::GMAPS_KEY}")
              response = Net::HTTP.get uri
              locations_json = JSON.parse(response)
              if locations_json['results'].any?
                aux_latitude = locations_json['results'][0]['geometry']['location']['lat']
                aux_longitude = locations_json['results'][0]['geometry']['location']['lng']
                @latitude = aux_latitude
                @longitude = aux_longitude
                @center_latitude = aux_latitude
                @center_longitude = aux_longitude
              end
            end


          end

          @geo_ok = false
          @zoom = 12
        else
          # 
          @latitude = (@latitude.blank?)? -34.92133765544518 : @latitude
          @longitude = (@longitude.blank?)? -57.95445442548953 : @longitude
          @center_latitude = (@center_latitude.blank?)? -34.92133765544518 : @center_latitude
          @center_longitude = (@center_longitude.blank?)? -57.95445442548953 : @center_longitude
          @zoom = (@zoom.blank?)? 15 : @zoom
        end
      end


    # 
    unless set_points? #Se cargo una vez, hay que cargar la segunda para saber cada punto cardinal
      # 
      workshops = []
    else
      # 
      workshops = Workshop.joins(:workshop_category).filter_state_to_show
      workshops = workshops.select("workshops.*, (acos(sin(radians(#{@latitude})) * sin(radians(workshops.latitude)) + cos(radians(#{@latitude})) * cos(radians(workshops.latitude)) * cos(radians(#{@longitude}) - radians(workshops.longitude))) * 6371) as distanciaKm") if @geo_ok.to_s == 'true'
      workshops = workshops.where('(workshops.latitude BETWEEN ? AND ?) AND (workshops.longitude BETWEEN ? AND ?)', @sur, @norte, @oeste, @este).uniq
      workshops = workshops.where('workshops.workshop_category_id = ?', @workshop_category_id) if @workshop_category_id.present?



    if @query.present?
      array_part = []
      @query.split(' ').each do |part|
        part = "'%#{part}%'"
        array_part << "(workshops.activity_title LIKE #{part} OR workshops.activity_description LIKE #{part})"
      end
      workshops = workshops.where(array_part.join(' AND '))
    end



      @order = @order || 'close' 
      @direction = @direction || 'asc'
      ordering = [order_field, @direction].compact.join(' ')


      
      workshops = workshops.order(ordering)
    end
    workshops
  end


  def workshop_category
    WorkshopCategory.find(@workshop_category_id) if @workshop_category_id.present?
  end

  def set_points?
    (@norte.present? && @sur.present? && @este.present? && @oeste.present?)
  end

  def set_lat_and_lng?
    (@latitude.present? && @longitude.present?)
  end

  def order_field
    case @order
    when 'activity_title'         then 'workshops.activity_title'
    when 'close'         then 'distanciaKm'
    end
  end
end

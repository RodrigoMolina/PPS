class Public::ApiController < PublicController


  def countries
	  countries = CountryFilter.new(query: params[:query]).call
    render json: countries.map { |x| { id: x.id, name: x.to_s } }
  end

  def provinces
    provinces = ProvinceFilter.new(query: params[:query]).call(params[:country_id])
    render json: provinces.map { |x| { id: x.id, name: x.to_s } }
  end

  def cities
    cities = CityFilter.new(query: params[:query]).call(params[:province_id])
    render json: cities.map { |x| { id: x.id, name: x.to_s } }
  end


end


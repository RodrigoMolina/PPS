module SelectHelper

  def gender_kind_types
	  Workshop::GENDER_TYPES.map{|x| [t(x, scope: :gender_kind_types),x]}
  end

  def level_kind_types
	  Workshop::LEVEL_TYPES.map{|x| [t(x, scope: :level_kind_types),x]}
  end



  def price_unit_types
      Workshop::PRICE_UNITS.map{|x| [t(x, scope: :price_unit_types),x]}
  end



  def preference_place_types
      NormalProfile::PREFERENCE_PLACE_TYPES.map{|x| [t(x, scope: :preference_place_types),x]}
  end

  def preference_assistance_types
      NormalProfile::PREFERENCE_ASSISTANCE_TYPES.map{|x| [t(x, scope: :preference_assistance_types),x]}
  end

  def preference_time_types
      NormalProfile::PREFERENCE_TIME_TYPES.map{|x| [t(x, scope: :preference_time_types),x]}
  end    


end

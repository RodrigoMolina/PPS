module WorkshopsHelper

  def state_name(state)
	  case state
	    when :draft       then 'Borrador'
        when :open        then 'Abierto'
        when :in_progress then 'En curso'
        when :finish      then 'Terminado'
        when :all         then 'Todos'
	  end
  end

end

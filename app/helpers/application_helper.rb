module ApplicationHelper

  def flash_type(flash_type)
    { success: 'alert-success',
      error:   'alert-danger',
      alert:   'alert-warning',
      notice:  'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_icon(flash_type)
    { success: 'check',
      error:   'times',
      alert:   'warning',
      notice:  'info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_label(flash_type)
    { success: 'Sucesso',
      error:   'Erro',
      alert:   'Atenção',
      notice:  'Info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, "#", method: :delete)
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

end



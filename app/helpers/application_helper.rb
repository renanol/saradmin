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

end

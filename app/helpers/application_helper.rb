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

  def pode_alterar(perm)
    current_user.pode_alterar(perm)
  end

  def pode_visualizar(perm)
    current_user.pode_visualizar(perm)
  end

  def tem_permissao(perm)
    current_user.tem_permissao(perm)
  end

end

module ApplicationHelper

  class ActionView::Helpers::FormBuilder
    # http://stackoverflow.com/a/2625727/1935918
    include ActionView::Helpers::FormTagHelper
    include ActionView::Helpers::FormHelper
    include ActionView::Helpers::FormOptionsHelper

    def enum_select(name, options = {})
      # select_tag "company[time_zone]", options_for_select(Company.time_zones
      #   .map { |value| [value[0].titleize, value[0]] }, selected: company.time_zone)
      select_tag @object_name + "[#{name}]", options_for_select(@object.class.send(name.to_s.pluralize)
                                                                    .map { |value| [value[0].titleize, value[0]] }, selected: @object.send(name))
    end

    def input_data name, options={}

      content = ""
      content += label name, options[:value], {class: 'col-md-1 control-label no-padding-right'}
      content << "<div class='col-md-3'>"
      content += text_field_tag @object_name, name, {class: 'form-control date-picker hasDatepicker', data:{date_format: 'dd/mm/yyyy' }}
      content << "</div>"

      raw(content)

    end

  end

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

  def title_page

    action = params[:action]

    if action == "index"
      action = "Listar"
    elsif action == "show"
      action = "Visualizar"
    elsif action == "edit" || action == "update"
      action = "Editar"
    elsif action == "new" || action == "create"
      action = "Cadastrar"
    end

    "#{action} #{params[:controller].gsub("_", " ").gsub("/", " ").gsub("Reports", "Relatório").capitalize}"

  end


end



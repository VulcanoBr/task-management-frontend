module ApplicationHelper

  def format_date(date_str)
    return 'Não definido' if date_str.blank?

    begin
      Date.parse(date_str).strftime('%d/%m/%Y')
    rescue ArgumentError, TypeError
      'Data inválida'
    end
  end

  def status_badge(status)
    status_class = case status
                   when 'concluido' then 'bg-success'
                   when 'em_andamento' then 'bg-warning'
                   else 'bg-secondary'
                   end

    status_text = case status
                  when 'concluido' then 'Concluído'
                  when 'em_andamento' then 'Em andamento'
                  else 'Pendente'
                  end

    content_tag(:span, status_text, class: "badge #{status_class}")
  end

end

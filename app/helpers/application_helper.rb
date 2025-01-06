module ApplicationHelper
  def bootstrap_devise_error_messages!
    error_key = "errors.messages.not_saved"
    sentence = ""

    unless flash.empty?
      sentence = flash[:error] if flash[:error]
      sentence = flash[:alert] if flash[:alert]
      sentence = flash[:notice] if flash[:notice]
    end

    return "" if resource.errors.empty? && sentence.blank?

    messages = resource.errors.full_messages.map { |message| content_tag(:li, message) }.join
    sentence ||= I18n.t(
      error_key,
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase,
      )

    unless messages.blank?
      html = <<-HTML
      <div class="alert alert-danger" role="alert">
        <p class="alert-heading">#{sentence}</p>
        <ul class="mb-0">#{messages}</ul>
      </div>
      HTML
    else
      html = <<-HTML
      <div class="alert alert-danger" role="alert">
        <p class="alert-heading mb-0">#{sentence}</p>
      </div>
      HTML
    end

    html.html_safe
  end

  def date_format(date)
    date.strftime("%d/%m/%Y")
  end

  def active?(pages)
    return request.path.split("/")&.last == pages unless pages

    pages.split(",").any? { |page| request.path.split("/")&.last == page }
  end
end

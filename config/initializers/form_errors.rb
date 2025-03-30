ActionView::Base.field_error_proc = ->(html_tag, instance) {
  unless html_tag =~ /^<label/
    html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
<<<<<<< HEAD
    html.children.each { |child| child.add_class("is-danger") }
=======
    html.children.add_class("is-danger")
>>>>>>> users-and-sign-ups

    error_message_markup = <<~HTML
      <p class="help is-danger">
        #{sanitize(instance.error_message.to_sentence)}
      </p>
    HTML

    "#{html}#{error_message_markup}".html_safe
  else
    html_tag
  end
}

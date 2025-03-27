module ApplicationHelper
  def title
    return t("advertangazo") unless content_for?(:title)

    "#{content_for(:title)} | #{t("advertangazo")}"
  end
end

class CampaignDecorator < Draper::Decorator
  delegate_all

  def created_at
    # move the strftime format to the application_helper.rb file
    # object.created_at.strftime("%Y-%b-%d")
    h.formatted_date object.created_at
  end

  def goal
    h.number_to_currency object.goal
  end
  
  def state
    object.aasm_state.capitalize
  end

  def decorated_categories
    object.categories.map(&:name).join(", ")
  end

  def edit_button
    if h.can? :edit, object
      h.link_to "Edit", h.edit_campaign_path(object), class: "btn btn-info"
    end
  end

  def delete_button
    if h.can? :delete, object
      h.link_to "Delete", h.campaign_path(object), method: :delete,class: "btn btn-danger", data: { confirm: "Sure to delete?" }
    end
  end

  def label_class
    { "draft" => "label-info", 
      "published?" => "label-warning",
      "cancelled?" => "label-danger",
      "funded" => "label-success",
      "unfunded" => "label-warning",
      "paused" => "label-primary"
    }.fetch(object.aasm_state, "label-default")

  #   if object.draft?
  #     "label-info"
  #   elsif object.published?
  #     "label-warning"
  #   elsif object.cancelled?
  #     "label-danger"
  #   elsif object.funded?
  #     "label-success"
  #   elsif object.unfunded?
  #     "label-warning"
  #   elsif object.paused?
  #     "label-primary"
  #   else
  #     "label-default"
  #   end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end

class EmailFormatValidator < ActiveModel::EachValidator

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate_each(object, attribute, value)
    unless value =~ EMAIL_REGEX
      object.errors[attribute] << 
        (options[:message] || "not formatted properly!")
    end
    object.errors
  end

end
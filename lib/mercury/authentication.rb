module Mercury
  module Authentication
    def can_edit?
      admin_user_signed_in?
    end
  end
end

class FormController < UIViewController
  URL_REGEX = /https?:\/\/[\S]+/

  attr_reader :form

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor
    self.title = 'Settings'

    @form = MotionForm.form_for(view) do |form|
      form.section 'Profile' do |section|
        section.input :name,      icon: :contact, required: true
        section.input :username,  icon: :user,    required: true
        section.input :email,     icon: :email,   email: true
        section.input :pinterest, icon: :pinterest
        section.input :twitter,   icon: :twitter
        section.input :website,   icon: :website, validate_with: url_validator
        section.input :bio,       icon: :info
      end

      form.section 'Account' do |section|
        section.button :change_password, icon: :lock,  action: notify_action
        section.button :change_email,    icon: :email, action: notify_action
      end
    end
  end

  def url_validator
    lambda do |value|
      value && value[URL_REGEX]
    end
  end

  def notify_action
    lambda do
      navigationController.pushViewController(password_controller, animated: true)
    end
  end

  def password_controller
    PasswordController.alloc.init
  end
end

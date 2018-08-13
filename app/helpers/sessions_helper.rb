module SessionsHelper
  def log_in_vnu
    agent = Mechanize.new
    page = agent.get Settings.base_url
    form = page.forms.first
    form["LoginName"] = params[:session][:student_id]
    form["Password"] = params[:session][:password]
    form.submit
  end

  def get_student_name page
    student_info = page.search("span.user-name").text.strip
    student_info[10..40].strip
  end

  def log_in page
    student_id = params[:session][:student_id]
    name = get_student_name page
    user = User.find_by_student_id student_id
    user = User.create student_id: student_id, name: name if user.nil?
    session[:student_id] = user.student_id
  end

  def log_out
    session.delete :student_id
  end

  def logged_in?
    session[:student_id].present?
  end

  def current_user
    User.find_by_student_id session[:student_id]
  end
end

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
    student = Student.find_by_id student_id
    student = Student.create id: student_id, name: name if student.nil?
    session[:student_id] = student.id
  end

  def log_out
    session.delete :student_id
  end

  def logged_in?
    session[:student_id].present?
  end

  def current_user
    Student.find_by_id session[:student_id]
  end
end

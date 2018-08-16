class ClassDetailsController < ApplicationController
  def index
    # crawl_data_from_list
    @courses = current_user.courses
    @class_details = current_user.class_details
  end
end

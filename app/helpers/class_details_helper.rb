module ClassDetailsHelper
  def crawl_data_from_list
    agent = Mechanize.new
    cookies = session[:login_cookies]
    agent.cookie_jar.load StringIO.new(cookies)

    result = agent.get "#{Settings.base_url}xem-va-in-ket-qua-dang-ky-hoc/1?layout=main"
    crawl_courses result
    crawl_class_details result
  end

  private

  def crawl_courses page
    rows = page.search("table")[2].search("tr")
    1.upto(rows.size - 2) do |index|
      strid = rows[index].search("td")[6].text.strip
      course = Course.find_by_strid strid
      if course.nil?
        name = rows[index].search("td")[2].text.strip
        number_of_part = rows[index].search("td")[3].text.strip.to_i
        Course.create strid: strid, name: name, number_of_part: number_of_part,
          student_id: current_user.id
      end
    end
  end

  def crawl_class_details page
    rows = page.search("table")[2].search("tr")
    1.upto(rows.size - 2) do |index|
      strid = rows[index].search("td")[6].text.strip
      course = Course.find_by_strid strid

      # Day of week
      day_of_week = rows[index].search("td")[7].text.strip
      # Thoi gian mon hoc bat dau
      time = get_time rows[index]
      # Thoi luong cua tiet hoc
      duration = get_duration rows[index]
      # Giang duong
      place = get_place rows[index]

      ClassDetail.create! day_of_week: day_of_week[1].to_i, place: place[0],
        class_time: time[0],
        duration: duration[0],
        course_id: course.id, student_id: current_user.id

      # Neu mon hoc hoc trong 2 ngay
      if day_of_week.include? ","
        ClassDetail.create! day_of_week: day_of_week[4].to_i, place: place[1],
          class_time: time[1],
          duration: duration[1],
          course_id: course.id, student_id: current_user.id
      end
    end
  end

  def split_time row
    time = row.search("td")[8].text.strip
    time.gsub!(/\s+/, "")
    split = time.split ","
  end

  def class_in_one_day? row
    time = row.search("td")[8].text.strip
    time.count("-").eql? 1
  end

  def get_time row
    split = split_time row
    return [split[0][0].to_i] if class_in_one_day? row
    [split[0][0].to_i, split[1][0].to_i]
  end

  def get_duration row
    split = split_time row
    duration1 = (split[0][0].to_i - split[0][2..split[0].size].to_i).abs + 1
    return [duration1] if class_in_one_day? row
    duration2 = (split[1][0].to_i - split[1][2..split[1].size].to_i).abs + 1
    [duration1, duration2]
  end

  def get_place row
    str = row.search("td")[9].text.strip
    if !has_two_place? str
      [str]

    # VD: 202T4103T3
    elsif str.count("T").eql?(2)
      [str[0..4], str[5, 10]]

    # VD: Phongmay203T4
    elsif str.include?("Phòng máy") && str.include?("T")

      # Phong may nam sau
      return [str[0..4], "Phòng máy"] if str.index("T").eql? 3
      ["Phòng máy", str[9..(str.size - 1)]]
    end
  end

  def has_two_place? str
    if str.count("T").eql?(2) || (str.include?("Phòng máy") && str.include?("T"))
      return true
    end
    false
  end
end

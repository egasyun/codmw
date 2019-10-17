class Ps4sController < ApplicationController
  def codmw

    @ps4 = Ps4.new
    @results = Ps4.where(title: "codmw").paginate(page: params[:page], per_page: 5)

    # 以下一定時間経過後削除機能
    @day = []
    @threeDays =[]
    @week = []
    @twoWeeks = []
    @month = []
    @results.each do |r|
      if r.period == "day"
        @day.push(r)
      elsif r.period == "3days"
        @threeDays.push(r)
      elsif r.period == "1week"
        @week.push(r)
      elsif r.period == "2weeks"
        @twoWeeks.push(r)
      else
        @month.push(r)
      end
    end

    @day.each do |d|
      if (Time.now - d.created_at) > 1.day
        d.destroy
      end
    end

    @threeDays.each do |d|
      if (Time.now - d.created_at) > 3.day
        d.destroy
      end
    end

    @week.each do |d|
      if (Time.now - d.created_at) > 1.week
        d.destroy
      end
    end

    @twoWeeks.each do |d|
      if (Time.now - d.created_at) > 2.week
        d.destroy
      end
    end

    @month.each do |d|
      if (Time.now - d.created_at) > 1.month
        d.destroy
      end
    end


    # 以下検索機能
    if params[:s_purpose]
      @results = @results.where(purpose: params[:s_purpose])

      if params[:s_skill] == "6"

      elsif params[:s_skill] == "1"
        @results = @results.where(skill: "senior")
      elsif params[:s_skill] == "2"
        @results = @results.where(skill: "senior").or(@results.where(skill: "Intermediate"))
      elsif params[:s_skill] == "3"
        @results = @results.where(skill: "Intermediate")
      elsif params[:s_skill] == "4"
        @results = @results.where(skill: "Intermediate" || "beginner")
      elsif params[:s_skill] == "5"
        @results = @results.where(skill: "beginner")
      end

      if params[:s_lowAge] ==  "" && params[:s_highAge] ==  ""

      elsif params[:s_lowAge] == ""
        @results = @results.where('age <= ?', params[:s_highAge].to_i)
      elsif params[:s_highAge] ==  ""
        @results = @results.where('age >= ?', params[:s_lowAge].to_i)
      else
        @results = @results.where('age >= ? and age <= ?', params[:s_lowAge].to_i, params[:s_highAge].to_i)
      end

      if params[:s_vc] == "true"
        @results = @results.where(vc: true)
      elsif params[:s_vc] == "false"
        @results = @results.where(vc: false)
      else

      end
    end

    # 以下検索条件の表示
    unless params[:s_purpose].blank?
      @purpose = (params[:s_purpose])
    end
    unless params[:s_vc].blank?
      @vc = (params[:s_vc])
    end
    unless params[:s_skill].blank?
      @skill = (params[:s_skill])
    end
    unless params[:s_lowAge].blank?
      @lowAge = (params[:s_lowAge])
    end
    unless params[:s_highAge].blank?
      @highAge = (params[:s_highAge])
    end

  end


  def create
    path = Rails.application.routes.recognize_path(request.referer)
    @ps4 = Ps4.new(ps4_params)
    if path[:action] == "codmw"
      @ps4.title = "codmw"
    end
    if @ps4.save && path[:action] == "codmw"
      redirect_to :action => "codmw"
    else

    end

  end

  private
  def ps4_params
   params.require(:ps4).permit(:title, :psId, :purpose, :vc, :age, :period, :comment, :skill)
  end

end

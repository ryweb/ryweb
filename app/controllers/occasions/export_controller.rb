class Occasions::ExportController < ApplicationController

  def new

    respond_to do |format|
      format.html
    end
  end

  def csv
    begin
      start_time = params[:occasion_export][:start_date].to_date
      end_time = params[:occasion_export][:end_date].to_date
    rescue
      start_time = nil
      end_time = nil
    end

    if start_time.nil? || end_time.nil?
      flash[:error] = "Syötetty virheellinen päivämäärä!"
      render :action => :new
    else
      @occasions = Occasion.find( :all,
                                  :conditions => [ "start_time > ? AND start_time < ?",
                                                   start_time, end_time ] )
      csv_string = FasterCSV.generate( :force_quotes => true ) do |csv|
        csv << ["Päiväys ja klo", "Tapahtuma", "Paikka", "Tapahtumatyyppi"]
        
        @occasions.each do |o|
          csv << [ o.start_date_only_str,
                   o.name,
                   o.location.nil? ? "" : o.location.name,
                   o.occasion_type.nil? ? "" : o.occasion_type.name ]
        end
      end
      filename = "Tapahtumat-#{start_time.strftime("%d_%m") + "-" + end_time.strftime("%d_%m")}.csv"
      send_data(csv_string,
                :type => 'text/csv; charset=utf-8; header=present',
                :filename => filename)

    end
  end
end

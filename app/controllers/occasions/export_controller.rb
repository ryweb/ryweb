require 'iconv'

class Occasions::ExportController < ApplicationController
  before_filter :login_required

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
        csv << [convert_str("Päiväys ja klo"),
                convert_str("Tapahtuma"),
                convert_str("Paikka"),
                convert_str("Tapahtumatyyppi"),
                convert_str("Sisäinen lisätieto"),
                convert_str("Julkinen lisätieto")]
        
        @occasions.each do |o|
          csv << [ convert_str(o.start_date_only_str) + " " + convert_str(o.start_time_only_str),
                   convert_str(o.name),
                   convert_str(o.location.nil? ? "" : o.location.name),
                   convert_str(o.occasion_type.nil? ? "" : o.occasion_type.name),
                   convert_str(o.internal_info),
                   convert_str(o.public_info) ]
        end
      end
      filename = "Tapahtumat-#{start_time.strftime("%d_%m") + "-" + end_time.strftime("%d_%m")}.csv"
      send_data(csv_string,
                :type => 'text/csv; charset=iso-8859-15; header=present',
                :filename => filename)

    end
  end

  def convert_str(str)
    Iconv.conv("ISO-8859-15", "utf-8", str)
  end
end

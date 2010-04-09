class Occasions::ImportController < ApplicationController
  before_filter :login_required

  def new

    respond_to do |format|
      format.html
    end
  end

  def refine
    @columns = columns

    if params[:occasion_import] && params[:occasion_import][:csv_data]
      @data = params[:occasion_import][:csv_data].split("\n").map { |line| line.rstrip.split("\t") }
      session[:import] = {}
      session[:import][:data] = @data.clone
      logger.debug "\n\n Set data to session"
    elsif session[:import][:data]
      @data = session[:import][:data]
      logger.debug "\n\n Get data from session"
    end

    respond_to do |format|
      format.html
    end
  end

  def validate
    @columns = params[:occasion_import][:selected_column].delete_if{ |c| c.empty? }
    @data = params[:occasion_import][:column_data]

    @occasions = []
    0.upto(@data["0"].length-1) do |data_index|
      new_occasion = {}
      0.upto(@columns.length-1) do |column_index|
        new_occasion[ @columns[column_index] ] = @data[column_index.to_s][data_index]
      end
      @occasions.push Occasion.new(new_occasion)
    end

    session[:import] = {} unless session.has_key?(:import)
    session[:import][:occasions] = @occasions

    respond_to do |format|
      if @occasions.map { |o| o.valid? }.include?(false)
        flash[:error] = "Tapahtumien tiedot ovat virheellisiä!"
        # FIXME: Lisätään lomakkeen tulostus, mikäli kaikki tapahtumat eivät ole valideja
        format.html { redirect_to refine_occasion_import_path }
      else
        flash[:notice] = "Tapahtumien tietojen tarkistuksessa ei löydetty virheitä"
        format.html { redirect_to preview_occasion_import_path }
      end
    end
  end

  def preview
    @columns = columns
    @occasions = session[:import][:occasions]
    
    respond_to do |format|
      format.html
    end
  end

  def create
    @occasions = session[:import][:occasions]
     
    @occasions.each do |occasion|
      occasion.save
    end

    respond_to do |format|
      flash[:notice] = "Tapahtumien massalisäys onnistui"
      format.html { redirect_to show_occasion_import_path }
    end
  end

  def show

  end

  private

  def columns
    [ ["start_time", "Päiväys ja klo"],
      ["name", "Tapahtuma"],
      ["location", "Paikka"],
      ["occasion_type", "Tapahtumatyyppi"] ]
          
  end
end

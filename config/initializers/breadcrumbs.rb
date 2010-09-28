Breadcrumb.configure do
  # Specify name, link title and the URL to link to
  crumb :locations, "Paikat", :locations_path
  crumb :location_name, '#{@location.name}', :locations_path

  crumb :occasion_types, "Tapahtumatyypit", :occasion_types_path
  crumb :occasion_type_name, '#{@occasion_type.name}', :occasion_types_path

  crumb :occasions_list, "Listanäkymä", :occasions_path, :params => [:view, :start_date]
  crumb :occasions_calendar, "Kalenterinäkymä", :occasions_path, :params  => :start_date
  crumb :occasion_name, '#{@occasion.name}', :occasions_path

  crumb :settings, "Asetukset", :settings_path
  crumb :users, "Käyttäjät", :userlist_path
  crumb :user_name, '#{@user.login}', :users_path
  crumb :customers, "Yhdistykset", :customers_path
  crumb :customer_name, '#{@customer.name}', :customers_path

  crumb :pages, "Sivut", :pages_path
  crumb :page_name, '#{@page.name}', :pages_path

  crumb :layouts, "Ulkoasut", :layouts_path
  crumb :layout_name, '#{@layout.name}', :layouts_path


  # Specify controller, action, and an array of the crumbs you specified above
  #trail :accounts, :show, [:root, :profile]
  #trail :home, :index, [:root]
  #trail :locations, :index, [:locations]
  trail :locations, :show, [:occasions_list, :locations, :location_name], :if => :calendar?
  trail :locations, :show, [:locations, :location_name], :unless => :calendar?
  trail :locations, [:new, :edit], [:locations, :location_name]

  trail :occasion_types, [:show, :new, :edit], [:occasion_types, :occasion_type_name]

  trail :occasions, [:new, :edit], [:occasions_list, :occasion_name], :if => :calendar?
  trail :occasions, :show, [:occasions_list, :occasion_name], :if => :calendar?
  trail :occasions, [:new, :edit], [:occasions_calendar, :occasion_name], :unless => :calendar?
  trail :occasions, :show, [:occasions_calendar, :occasion_name], :unless => :calendar?

  trail :users, :list, [:settings, :users]
  trail :users, [:show, :edit, :new], [:settings, :users, :user_name]

  trail :customers, :index, [:settings, :customers]
  trail :customers, [:show, :edit, :new], [:settings, :customers, :customer_name]

  trail :pages, [:new, :edit], [:pages, :page_name]
  trail :layouts, [:new, :edit], [:layouts, :layout_name]


  # Specify the delimiter for the crumbs
  delimit_with "&nbsp;&raquo;&nbsp;"

  dont_link_last_crumb

end

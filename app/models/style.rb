class Style < CustomerData
  using_access_control

has_attachment  :storage => :file_system,
                  :max_size => 1.megabytes,
                  :min_size => 0.kilobytes,
                  :content_type => ['text/css'],
                  :path_prefix => 'public/styles'

  validates_as_attachment
end

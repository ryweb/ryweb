class Graphic < CustomerData
has_attachment  :storage => :file_system,
                  :max_size => 1.megabytes,
                  :min_size => 0.kilobytes,
                  :content_type => ['image/jpeg', 'image/gif', 'image/png', 'image/pjpeg'],
                  :path_prefix => 'public/images'

  validates_as_attachment
end

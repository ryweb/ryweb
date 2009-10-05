Tinymce::Hammer.plugins = %w(safari table paste tabfocus preview contextmenu)
Tinymce::Hammer.languages = ['fi','en']
Tinymce::Hammer.themes = ['advanced']
Tinymce::Hammer.init = [
  [:paste_convert_headers_to_strong, true],
  [:paste_convert_middot_lists, true],
#  [:paste_remove_spans, true],
#  [:paste_remove_styles, true],
#  [:paste_strip_class_attributes, true],
  [:theme, 'advanced'],
  [:theme_advanced_toolbar_align, 'left'],
  [:theme_advanced_toolbar_location, 'top'],
  [:theme_advanced_buttons1,  %w{formatselect fontselect fontsizeselect bold italic underline strikethrough separator undo redo separator preview code}.join(',')],
#'undo,redo,cut,copy,paste,pastetext,|,bold,italic,strikethrough,blockquote,charmap,bullist,numlist,removeformat,|,link,unlink,image,|,cleanup,code'],
  [:theme_advanced_buttons2,  %w{justifyleft justifycenter justifyright indent outdent separator bullist numlist forecolor backcolor separator link unlink image}.join(',') ],
  [:theme_advanced_buttons3, ''],
#  [:valid_elements, "a[href|title],blockquote[cite],br,caption,cite,code,dl,dt,dd,em,i,img[src|alt|title|width|height|align],li,ol,p,pre,q[cite],small,strike,strong/b,sub,sup,u,ul"],
]

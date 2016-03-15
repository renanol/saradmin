class PdfReport < Prawn::Document

  # Often-Used Constants
  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  TABLE_FONT_SIZE = 8
  TABLE_BORDER_STYLE = :grid

  def initialize(default_prawn_options={})
    super(default_prawn_options)
    font_size 8
  end

  def header(title=nil)
    image "#{Rails.root}/public/logo.png", height: 30
    text "My Organization", size: 15, style: :bold, align: :center
    text "", size: 15, style: :bold, align: :center
    if title
      text title, size: 11, style: :bold_italic, align: :center
    end
  end

  def footer
    # ...
  end

  # ... More helpers
end
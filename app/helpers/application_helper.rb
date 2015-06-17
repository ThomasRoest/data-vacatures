module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Datavacature.nl"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def formatted_price(amount)
 	sprintf("€%0.2f per maand", amount / 100.0)
  end
end
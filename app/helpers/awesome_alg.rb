helpers do

  def movie_sorter(params)
    key = "12fw-AWJXaTFhaYLT6Si5AcMd3imqtMTZqu-gDZw15TY"
    spreadsheet = HTTParty.get("https://spreadsheets.google.com/feeds/cells/#{key}/od6/public/basic?alt=json")
    terms = []

    spreadsheet.parsed_response["feed"]["entry"].each do |entry|
      terms << entry["content"]["$t"]
    end


    terms.map! do |term|
      if /\d+/.match(term)
        term.to_i
      else
        term
      end
    end
    p 'does it get here'
    return terms.sample

  end

end

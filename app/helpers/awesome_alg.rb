helpers do

  def movie_sorter(params)
    key = "12fw-AWJXaTFhaYLT6Si5AcMd3imqtMTZqu-gDZw15TY"
    spreadsheet = HTTParty.get("https://spreadsheets.google.com/feeds/cells/#{key}/od6/public/basic?alt=json")
    terms = []

    spreadsheet.parsed_response["feed"]["entry"].each do |entry|
      terms << entry["content"]["$t"]
    end

    spreadsheet = parse_google_doc(terms)
    spreadsheet = create_database_rows(spreadsheet)
    get_keyword(spreadsheet, params)

  end

  private

  def parse_google_doc(input)

    input.map! do |term|
      if /\d+/.match(term)
        term.to_i
      else
        term
      end
    end
    return input

  end

  def create_database_rows(input)

    input.map!.with_index do |x, index| 
      if x.is_a?(String)
        x = [x]
      else
        x 
      end
    end

    array_indexes = []
    input.each_with_index do |x, index|
      if x.is_a?(Array)
        array_indexes << index
      end
    end


    input.map!.with_index do |x, index|
      if index > array_indexes[0] && index < array_indexes[1]
        input[array_indexes[0]] << x
      elsif index > array_indexes[1] && index < array_indexes[2]
        input[array_indexes[1]] << x
      elsif index > array_indexes[2] && index < array_indexes[3]
        input[array_indexes[2]] << x
      elsif index > array_indexes[3] 
        input[array_indexes[3]] << x
      else
        x
      end
    end
    return input.uniq
  end

  def get_keyword(input, params)
    input.each do |row|
      if row[0].downcase == params[:mood].downcase
        return row[1..-1].sample
      end
    end
  end

end

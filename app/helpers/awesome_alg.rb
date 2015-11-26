helpers do

  def movie_sorter(params)
    key = "12fw-AWJXaTFhaYLT6Si5AcMd3imqtMTZqu-gDZw15TY"
    mood_spreadsheet = determine_worksheet(HTTParty.get("https://spreadsheets.google.com/feeds/cells/#{key}/1/public/basic?alt=json"))
    company_spreadsheet = determine_worksheet(HTTParty.get("https://spreadsheets.google.com/feeds/cells/#{key}/2/public/basic?alt=json"))

      mood = get_keyword(mood_spreadsheet, params[:mood])
      company = get_keyword(company_spreadsheet, params[:company])


      return [mood, company]

    end

    private

    def determine_worksheet(input)

      terms = []
      input.parsed_response["feed"]["entry"].each do |entry|
        terms << entry["content"]["$t"]
      end

      input = parse_google_doc(terms)
      input = create_database_rows(input)
    end

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
      p "*" * 90
      p "Return value: #{input.uniq}"
      return input.uniq
    end

    def get_keyword(input, params)
      input.each do |row|
        if row[0].downcase == params.downcase
          return row[1..-1].sample
        end
      end
    end

  end

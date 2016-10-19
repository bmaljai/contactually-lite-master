module PagesHelper
    def check_parse(parsed_file_array)
    field_count = parsed_file_array.first.count
    problem_row_hash = {}
    parsed_file_array.each_with_index do |parsed_item, index|
      if parsed_item.count <= field_count
        puts "do next step of normalization"
      else
        problem_row_hash["#{index}"] = parsed_item
      end
    end
    return problem_row_hash
  end
end

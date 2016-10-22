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

  #   def normalize_phone(string_phone)
  #   chars = ["(", ")", ".", "-"]
  #   new_string = ""
  #   string_phone.split("").each do |string_phone_char|
  #     if chars.include?(string_phone_char)
  #       next
  #     else
  #       new_string += string_phone_char
  #     end
  #   end
  #   return new_string
  # end

  def normalize_phone(string_phone)
    split_string_phone = string_phone.split(/[(, ), ., -]/)
    if split_string_phone[0] == ""
      return split_string_phone[1..-1]
    else
      return split_string_phone
    end
  end

  def split_ext(array_phone)
    if array_phone[-1].include?("x")
      return "#{array_phone[0..-2].join('-')} #{array_phone[-1]}"
    else
      return "#{array_phone.join('-')}"
    end
  end

  # def extensionify(string_phone)
  #   string_phone = string_phone.split("x")
  #   phone_number = ""
  #   extension = "Ext. "
  #   string_phone.each_with_index do |string, index|
  #     case index
  #     when 0
  #         string.insert(-5, "-")
  #         string.insert(-9, "-")
  #       if string.length > 12
  #         string.insert(-13, "-")
  #       end
  #       phone_number = string
  #     when 1
  #       extension += string
  #     end
  #   end
  #   return "#{phone_number} #{extension if extension.length > 5}"
  # end
end

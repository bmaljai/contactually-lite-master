module PagesHelper

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
end

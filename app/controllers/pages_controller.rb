require "csv"
class PagesController < ApplicationController
  def new

  end

  def index
    @parsed_file = parse_tsv("data.tsv")
    @parsed_file2 = parse_tsv("data2.tsv")
    #@normalized = normalize_from_parse(@parsed_file)
    @normal = normalized_users(@parsed_file)
  end

  def create_from_file
    parsed_file = parse_tsv("data.tsv")
    users = normalized_users(parsed_file)
    parsed_file.each do |user_entry|
      update_or_create_user(user_entry)
    end
    redirect_to "/pages"
  end

  private

  def parse_tsv(file_name)
    tsv_array = CSV.read("#{file_name}", {:col_sep => "\t"})
    if check_parse(tsv_array)
      return check_parse(tsv_array)
    else
      return tsv_array
    end
  end

  def check_parse(parsed_file_array)
    field_count = parsed_file_array.first.count
    problem_row_hash = {}
    parsed_file_array.each_with_index do |parsed_item, index|
      if parsed_item.count <= field_count
        next
      else
        problem_row_hash["#{index}"] = parsed_item
      end
    end

    if problem_row_hash.empty?
      return false
    else
      return problem_row_hash
    end
  end

  def normalize_company(parsed_file_array)
    companies = Hash.new(0)
    parsed_file_array.each do |parsed_item|
      companies["#{parsed_item[-1]}"] += 1
    end
    return companies
  end

  def normalize_user(parsed_file_array)
    users = Hash.new(0)
    parsed_file_array.each do |parsed_item|
      users["#{parsed_item[2]}"] += 1
    end
    return users
  end

  def normalized_users(parsed_file_array)
    users = Hash.new(0)
    parsed_file_array.each do |parsed_item|
      users["#{parsed_item[2]}"] = parsed_item - [parsed_item[2]]
    end
    return users
  end

  def find_or_create_company(company_name)
    return Company.find_by(name: company_name).try(:id) || Company.create(name: company_name).id
  end

  def update_or_create_user(user_array)
    company_id = find_or_create_company(user_array[4])
    user = User.find_by(email_address: user_array[2])
    if user
      user.update(first_name: user_array[0], last_name:user_array[1], phone_number: user_array[3], company_id: company_id)
    else
      User.create(first_name: user_array[0], last_name: user_array[1], email_address: user_array[2], phone_number: user_array[3], company_id: company_id)
    end
  end

  def normalize_phone(string_phone)
    chars = ["(", ")", ".", "-"]
    new_string = ""
    string_phone.split("").each do |string_phone_char|
      chars.each do |char|
        if string_phone_char != char
          new_string += string_phone_char
        end
      end
    end
    return new_string
  end
  # def normalize()
  #   company_keys = Hash.new(0)
  #   email_keys = Hash.new(0)
  #   parsed_file_array.each do |parsed_item|
  #     company_keys << parsed_item[-1]
  #   end
  # end
end

#create before action for create normalization
# or helper method
# can take row number in reading/parsing to return error if problem

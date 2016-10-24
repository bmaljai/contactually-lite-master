require "csv"
class ContactsController < ApplicationController
  def index
    @contacts = User.all
  end

  def create
    parsed_file = parse_tsv(params[:file])
    parsed_file[1..-1].each do |user_entry|
      update_or_create_user(user_entry)
    end
    redirect_to "/contacts"
  end

  def destroy
    user = User.find(params[:id]).delete
    render json: user
  end

  private

  def parse_tsv(file)
    myfile = file
    tsv_array = CSV.read(myfile.path, {:col_sep => "\t"})
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


  def find_or_create_company(company_name)
    return Company.find_by(name: company_name).try(:id) || Company.create(name: company_name).id
  end

  def update_or_create_user(user_array)
    company_id = find_or_create_company(user_array[4])
    user = User.find_by(email_address: user_array[2])
    if user
      user.update(first_name: user_array[0], last_name:user_array[1], phone_number: normalize_phone(user_array[3]), company_id: company_id)
    else
      User.create(first_name: user_array[0], last_name: user_array[1], email_address: user_array[2], phone_number: normalize_phone(user_array[3]), company_id: company_id)
    end
  end

  def split_phone(string_phone)
    split_string_phone = string_phone.split(/[(, ), ., -]/)
    if split_string_phone[0] == ""
      return split_string_phone[1..-1]
    else
      return split_string_phone
    end
  end

  def join_phone(array_phone)
    if array_phone[-1].include?("x")
      return "#{array_phone[0..-2].join('-')} #{array_phone[-1]}"
    else
      return "#{array_phone.join('-')}"
    end
  end

  def normalize_phone(string_phone)
    return join_phone(split_phone(string_phone))
  end
end

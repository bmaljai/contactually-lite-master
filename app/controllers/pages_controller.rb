require "csv"
class PagesController < ApplicationController
  def index
    @parsed_file = parse_tsv("data.tsv")
    @parsed_file2 = parse_tsv("data2.tsv")
    #@normalized = normalize_from_parse(@parsed_file)

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

  def normalize()
    company_keys = Hash.new(0)
    email_keys = Hash.new(0)
    parsed_file_array.each do |parsed_item|
      company_keys << parsed_item[-1]
    end
  end
end

#create before action for create normalization
# or helper method
# can take row number in reading/parsing to return error if problem

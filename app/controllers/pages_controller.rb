require "csv"
class PagesController < ApplicationController
  def index
    @parsed_file = CSV.read("data.tsv", {:col_sep => "\t"})
    
  end
end

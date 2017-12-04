# frozen_string_literal: true

class SearchController < ApplicationController
  def index; end

  def find_dimensions
    data = PhonearenaService.new(params[:term]).data
    render json: { message: data[:dimensions] }, status: data[:status]
  end
end

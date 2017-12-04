# frozen_string_literal: true

class SearchController < ApplicationController
  def index; end

  def find_dimensions
    render json: { message: PhonearenaService.new(params[:term]).dimensions }, status: 200
  end
end

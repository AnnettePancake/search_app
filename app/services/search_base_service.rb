# frozen_string_literal: true

require 'capybara/dsl'
require 'capybara/poltergeist'

class SearchBaseService
  include Capybara::DSL

  def initialize(term)
    @term = term
    @status = 200
  end

  def data
    { dimensions: dimensions, status: @status }
  end

  private

  def dimensions
    search_dimensions_scenario
  rescue Capybara::ElementNotFound => e
    @status = 404
    'No dimensions found'
  rescue StandardError => e
    @status = 500
    e.message
  end

  def search_dimensions_scenario
    raise 'Undefined scenario'
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

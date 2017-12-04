# frozen_string_literal: true

require 'capybara/dsl'
require 'capybara/poltergeist'

class PhonearenaService
  include Capybara::DSL

  URL = 'https://www.phonearena.com'

  def initialize(term)
    @term = term
  end

  def dimensions
    begin
      visit URL
      fill_in_search
      wait_for_ajax
      click_first_result
      wait_for_ajax
      find_dimensions
    rescue => e
      'No dimensions found'
    end
  end

  private

  def fill_in_search
    within('#site_search') do
      fill_in 'term', with: @term
      find('button[type="submit"]').click
    end
  end

  def click_first_result
    within('.s_listing') do
      first('div > a').click
    end
  end

  def find_dimensions
    find('strong', text: 'Dimensions:').first(:xpath,".//..").first('li').text
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

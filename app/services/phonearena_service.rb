# frozen_string_literal: true

class PhonearenaService < SearchBaseService
  URL = 'https://www.phonearena.com'

  private

  def search_dimensions_scenario
    visit URL
    fill_in_search
    click_first_result
    find_dimensions
  end

  def fill_in_search
    within('#site_search') do
      fill_in 'term', with: @term
      find('button[type="submit"]').click
    end
    wait_for_ajax
  end

  def click_first_result
    within('.s_listing') do
      first('div > a').click
    end
    wait_for_ajax
  end

  def find_dimensions
    find('strong', text: 'Dimensions:').first(:xpath, './/..').first('li').text
  end
end

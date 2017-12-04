# frozen_string_literal: true

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, debug: false)
end

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

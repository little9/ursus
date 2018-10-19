# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'catalog/_bookmark_control.html.erb' do
  let(:document) { SolrDocument.new id: 'xyz', format: 'a' }
  let(:blacklight_config) { Blacklight::Configuration.new }

  before do
    assign :document, document
    allow(view).to receive(:blacklight_config).and_return blacklight_config
    allow(view).to receive(:document) { document }
    allow(view).to receive(:documents) { [document] }
    allow(view).to receive(:bookmarked?) { false }
  end

  it 'does not display if turned off' do
    Rails.application.config.user_account_ui_enabled = 'false'
    render
    expect(rendered).to eq('')
  end

  it 'displays if it is turned on' do
    Rails.application.config.user_account_ui_enabled = 'true'
    render
    expect(rendered).to match(/bookmark-toggle/)
  end
end

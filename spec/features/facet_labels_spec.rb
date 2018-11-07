# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'The facet sidebar', :clean, js: false do
  before do
    solr = Blacklight.default_index.connection
    solr.add(work_attributes)
    solr.commit
  end

  let(:work_attributes) do
    {
      id: '123',
      has_model_ssim: ['Work'],
      has_model_sim: ['Work'],
      subject_sim: ['Subj 1', 'Subj 2'],
      resource_type_sim: ['Photograph'],
      genre_sim: ['news photographs'],
      named_subject_sim: ['Los Angeles County (Calif.). Board of Supervisors'],
      year_isim: [1947],
      medium_sim: ['1 photograph'],
      dimensions_sim: ['10 x 12.5 cm.'],
      language_sim: ['No linguistic content'],
      location_sim: ['LA']
    }
  end

  it 'displays expected facet labels' do
    visit('/catalog')
    facet_headings = page.all(:css, 'h3.facet-field-heading/a').to_a.map { |a| a.text }
    expect(facet_headings).to contain_exactly(
      'Subject',
      'Resource Type',
      'Genre',
      'Name (subject)',
      'Location',
      'Date',
      'Medium',
      'Dimensions',
      'Language'
    )
  end
end
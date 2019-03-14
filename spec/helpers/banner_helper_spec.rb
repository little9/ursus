# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BannerHelper, type: :helper do
  let(:doc) { {} }
  describe '#collection?' do
    it 'can determine if something is a collection' do
      doc['has_model_ssim'] = ['Collection']
      expect(collection?(doc)).to eq(true)
    end

    it 'can determine if something is not a collection' do
      doc['has_model_ssim'] = ['Work']
      expect(collection?(doc)).to eq(false)
    end
  end

  describe '#render_banner_tag' do
    it 'returns nil if there is a problem with the http request' do
      doc['has_model_ssim'] = ['Collection']
      expect(render_banner_tag(doc)).to eq(nil)
    end
  end

  describe '#get_img_path' do
    it 'returns nil if there is a problem with the http request' do
      expect(get_img_path('1')).to eq(nil)
    end

    describe '#get_branding_info' do
      it 'returns nil if there is a problem with the http request' do
        expect(get_branding_info('1')).to eq(nil)
      end
    end
  end
end

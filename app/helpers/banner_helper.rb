# frozen_string_literal: true

module BannerHelper
  def render_banner_tag(document)
    return unless collection?(document)
    img_path = get_img_path(document['id'])
    return unless img_path
    "<img width='800' alt='Collection banner' height='100' src='#{img_path}'/>".html_safe
  end

  def collection?(document)
    document['has_model_ssim'][0] == 'Collection'
  end

  def get_img_path(collection_id)
    return unless get_branding_info(collection_id)
    "#{Rails.config.thumbnail_url}/#{get_branding_info(collection_id)[1]}"
  end

  def get_branding_info(collection_id)
    begin
      response = HTTParty.get(branding_info_url(collection_id))
      branding_info_json = response.parsed_response["local_path"]
      branding_info_json.split('/public/')
    rescue
      nil
    end
  end
end

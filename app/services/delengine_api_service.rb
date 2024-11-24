class DelengineApiService
  def self.fetch_regions
    response = HTTParty.get(
      "https://api.delengine.com/v1.0/regions",
      query: { token: DELENGINE_API_KEY }
    )
    handle_response(response)
  end

  def self.fetch_districts(region_id)
    response = HTTParty.get(
      "https://api.delengine.com/v1.0/districts",
      query: { region_uuid: region_id, token: DELENGINE_API_KEY }
    )
    handle_response(response)
  end

  def self.fetch_settlements(district_id)
    response = HTTParty.get(
      "https://api.delengine.com/v1.0/settlements",
      query: { district_uuid: district_id, token: DELENGINE_API_KEY }
    )
    handle_response(response)
  end

  def self.fetch_post_offices(settlement_id)
    response = HTTParty.get(
      "https://api.delengine.com/v1.0/departments",
      query: { settlement_uuid: settlement_id, token: DELENGINE_API_KEY }
    )
    handle_response(response)
  end

  private

  def self.handle_response(response)
    if response.success?
      response.parsed_response["data"]
    else
      Rails.logger.error("Delengine API Error: #{response.code} - #{response.body}")
      []
    end
  end
end

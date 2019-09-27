class SuggestionsDadata
  include Interactor

  API_ENDPOINT = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party'.freeze

  def call
    @token = Rails.application.credentials.dig(:dadata, :token)
    @query = context.query
    context.suggestions = parse_response(request)
  end

  private

  def parse_response(response)
    response.dig('suggestions').map do |suggestion|
      {
        name: suggestion.dig('data', 'name', 'short'),
        form_of_ownership: suggestion.dig('data', 'opf', 'short'),
        inn: suggestion.dig('data', 'inn'),
        ogrn: suggestion.dig('data', 'ogrn')
      }
    end
  end

  def request
    response = connection.post do |request|
      request.body = { 'query': @query }.to_json
    end
    JSON.parse(response.body)
  end

  def connection
    @connection ||= Faraday.new(API_ENDPOINT) do |connection|
      connection.headers['Content-Type'] = 'application/json'
      connection.headers['Accept'] = 'application/json'
      connection.headers['Authorization'] = "Token #{@token}"
      connection.adapter Faraday.default_adapter
    end
  end
end

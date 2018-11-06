module Chekonline

  class Client
    PRODUCTION_BASE_URL = 'https://kkt.chekonline.ru'.freeze
    DEVELOPMENT_BASE_URL = 'https://fce.chekonline.ru:4443'.freeze
    API_URL = 'fr/api/v2/Complex'.freeze

    attr_reader :api_url, :mode, :agent
    attr_accessor :lines

    def initialize(mode: 'development', cert:, key:)
      @mode = mode
      @api_url = [mode == 'production' ? PRODUCTION_BASE_URL : DEVELOPMENT_BASE_URL, API_URL].join('/')
      @agent = Mechanize.new
      @agent.cert = cert
      @agent.key = key
      @lines = []
    end

    def add_line(qty:, price:, pay_attribute:, tax_id:, description:)
      @lines << {
          'Qty' => qty, # The number in thousandths
          'Price' => price, # Unit price
          'PayAttribute' => pay_attribute, # Sign of the method of calculation
          'TaxId' => tax_id, # Код налога
          'Description' => description # Heading item
      }
    end

    def request(device: 'auto',
                request_id: (0...16).map {(65 + rand(26)).chr}.join,
                document_type: 0,
                tax_mode: 1,
                place:,
                phone_or_email:)

      json_data = {
          'Device' => device, # Device
          'RequestId' => request_id, # The unique identifier of the request
          'DocumentType' => document_type, # Document Type: Replenishment
          'Lines' => lines,
          'NonCash' => [lines.inject(0) {|sum, x| sum + (x['Qty'] / 1000 * x['Price'])}], # Breakdown by type: Splitting is not required.
          'TaxMode' => tax_mode, # Simplified tax system, income
          'Place' => place, # Place of payment
          'PhoneOrEmail' => phone_or_email #
      }.to_json

      begin
        page = agent.post(api_url, json_data, {'Content-Type' => 'application/json; charset=utf-8'})
        @lines = []
        JSON.parse(page.content)
      rescue => error
        { error: error.message }.to_json
      end

    end

  end

end

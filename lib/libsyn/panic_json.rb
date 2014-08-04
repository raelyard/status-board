require 'json'

module Libsyn
  class PanicJson
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def totals
      episodes, downloads, months = parse(input)

      datapoints = []

      months.reverse.each do |month|
        datapoints << {
          "title" => month, "value" => downloads[month].inject(&:+)
        }
      end

      {
        "graph" => {
          "title" => "Downloads",
          "refreshEveryNSeconds" => 120,
          "datasequences" => [{
            "title" => "Total",
            "datapoints" => datapoints
          }]
        }
      }.to_json
    end

    def most_recent
      episodes, downloads, months = parse(input)

      datapoint = { "title" => months.first, "value" => downloads[months.first].first }

      {
        "graph" => {
          "title" => episodes.first,
          "refreshEveryNSeconds" => 120,
          "datasequences" => [{
            "title" => "Downloads",
            "datapoints" => [ datapoint ]
          }]
        }
      }.to_json
    end

    private

    def parse(input)
      downloads = Hash.new { |h, k| h[k] = [] }
      episodes  = []

      months = input.dup.shift.slice(2..-2).map do |month|
        month.gsub("downloads__", "").capitalize
      end

      input.each do |line|
        episode, _, *dls = *line
        next if episode.split(':').count == 1

        episodes << episode

        0.upto(months.count).each { |i| downloads[months[i]] << dls[i].to_i }
      end

      [episodes, downloads, months]
    end
  end
end
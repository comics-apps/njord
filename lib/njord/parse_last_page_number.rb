module Njord
  module ParseLastPageNumber
    def self.call(body)
      Nokogiri::HTML(body)
        .xpath('//div[@class="pagenavi"]/a')
        .to_a
        .last
        .text
        .to_i
    end
  end
end

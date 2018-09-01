module Njord
  module ParseProxies
    def self.call(body)
      proxies = []
      document = Nokogiri::HTML(body)
      rows = document.xpath('//table[@id="tblproxy"]/tr')
      rows.each do |row|
        cols = row.xpath('td').to_a
        next if cols.size <= 1

        proxy = {
          ip: cols[1].text.scan(/document\.write\(\'(.+)\'\)/)[0][0],
          port: cols[2].text.scan(/document\.write\(gp\.dep\(\'(.+)\'\)\)/)[0][0].to_i(16),
          level: cols[3].text,
          country: cols[4].text,
          uptime: cols[6].text.strip,
          response_time: cols[7].text.to_i
        }

        CheckAndPersistProxyJob.enqueue(
          proxy[:ip], proxy[:port], proxy[:response_time]
        )
        proxies << proxy
      end

      proxies
    end
  end
end

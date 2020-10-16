require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    web_page = Nokogiri::HTML(open(index_url))
    profiles = web_page.css("div.student-card")
    profiles.each do |profile|
      student = {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").attribute("href").value
      }
      students << student
    end
    binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end


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
    students
  end

  def self.scrape_profile_page(profile_url)
    web_page = Nokogiri::HTML(open(profile_url))
    social = web_page.css("div.social-icon-container a").map{|x| x.attribute("href").value}
    details = {
      :profile_quote => web_page.css("div.profile-quote").inner_html,
      :bio => web_page.css("div.description-holder p").text
    }
    social.each do |possible_social|
      case possible_social
      when /twitter\.com/
        details[:twitter] = possible_social
      when /linkedin\.com/
        details[:linkedin] = possible_social
      when /github\.com/
        details[:github] = possible_social
      else 
        details[:blog] = possible_social
      end
    end
    details
  end

end

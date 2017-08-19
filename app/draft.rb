# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'
require 'byebug'
#
# def url_scraper
#   array = []
#   alphabet=('a'..'z').to_a
#   url = 'https://www.nybits.com/managers/'
#   url_2 = '_letter_managers.html'
#   alphabet.each do |letter|
#     doc = Nokogiri::HTML(open(url+letter+url_2))
#       doc.css('ul.spacyul a').each do |link|
#         array.push(link['href'])
#       end
#   end
#   puts(array.uniq)
# end

def url_scraper
  array = []
  doc = Nokogiri::HTML(open('https://www.nybits.com/managers/residential_property_managers.html'))
  doc.css('ul.spacyul a').each do |link|
    array.push(link['href'])
  end
  array.uniq
end


def building_scraper
  array = []
  url_scraper.each do |url|
    doc = Nokogiri::HTML(open(url))
    doc.css('ul.spacyul a').each do |link|
      array.push(link['href'])
    end
    end
    array.uniq
end

def create_data
  # building_scraper.each do |url|
    doc = Nokogiri::HTML(open('https://www.nybits.com/apartments/33-25_81st_st_qn.html'))
    building_name = doc.css('div#dancefloor h1').children.text
    table = doc.css('div#dancefloor table#summarytable tr')
      rows_array = table.map {|row| row.children.text}
    #row 1
        address = rows_array[0].split(":")[1].split("(map)")
        address[0].slice!(0..1)
      street_address = address[0]
        zip_code=address[1].split[2]


    #row 2
        hood_parse = rows_array[1].split(", ")[0].split(":")[1]
        hood_parse.slice!(0..1)
        neighborhood = hood_parse
        boro = rows_array[1].split(", ")[1]

    #row 3
          leasing = rows_array[2].split(":")[1]
          leasing.slice!(0..1)
          mgmt_name = leasing
          byebug
        # mgmtInstance = BuildingMgmt.find_or_create_by(name: mgmt_name)
        #
        # building = Building.create(street_address: street_address, neighborhood: neighborhood, zip_code: zip_code, boro: boro building_mgmt: mgmtInstance)
    # end
  end



create_data



#
# def building_scraper
#   url_scraper.each do |url|
#     doc = Nokogiri::HTML(open(url))
#       mgmt = doc.css('div#dancefloor h1')
#       mgmt_name = mgmt.children.text
#       if mgmt_name != "Brodsky Organization" &&  mgmt_name !='IBEC Living' && mgmt_name != 'Landmark Resources LLC' && mgmt_name != 'M & R Management' && mgmt_name != 'Rose Associates, Inc' && mgmt_name != 'RY Management Co., Inc'
#       mgmtInstance = BuildingMgmt.find_or_create_by(name: mgmt_name)
#       doc.css('ul.spacyul li').each do |building|
#         details = building.content
#         parsed_info = details.split(")")[0].split("\n")
#         parsed_info[0].slice!(0)
#         address=parsed_info[0]
#         parsed_info[1].slice!(0)
#         neighborhood = parsed_info[1]
#         building = Building.create(street_address: address, neighborhood: neighborhood, building_mgmt: mgmtInstance)
#     end
#     end
#   end
# end

# building_scraper
# scrapper.rb
require 'nokogiri'
require 'open-uri'



def filter_links(rows, regex)
  # takes in rows and returns uses
  # regex to only return links
  # that have "pup", "puppy", or "dog"
  # keywords

  if rows.content.match(regex)
    matches = rows
    puts matches.text
    puts "*" * 60
  end
end

def get_todays_rows(doc, date_str)
  #  1.) open chrome console to look in inside p.row to see
  #  if there is some internal date related content
  #  2.) figure out the class that you'll need to select the
  #   date from a row

  doc.each do |el|
    if el.css(".date").text.match(/Aug 12/)
      filter_links(el, /Dog|dog|puppies|Puppies|Puppy|puppy|Pup|pup/)
    end
  end
end

def get_page_results
  url = "today.html"
  @doc = Nokogiri::HTML(open(url))
  rows = @doc.css(".row")
  date = @doc.css(".date").text

  get_todays_rows(rows, date)
end

def search(date_str)
  get_page_results()
end

# want to learn more about
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
# today = Time.now.strftime("%b %d")
today = "Aug 12"
search(today)
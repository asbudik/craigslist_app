# scrapper.rb
require 'nokogiri'
require 'open-uri'



def filter_links(rows, regex)
  # takes in rows and returns uses
  # regex to only return links
  # that have "pup", "puppy", or "dog"
  # keywords
  if rows.content.match(regex) && rows.css(".p").text.match(/pic/)
    puts "http://sfbay.craigslist.org#{rows.css("a")[0]["href"]}"
    puts rows.text
    puts "*" * 60
    return true
  end
end

def get_todays_rows(rows)
  #  1.) open chrome console to look in inside p.row to see
  #  if there is some internal date related content
  #  2.) figure out the class that you'll need to select the
  #   date from a row
  rows.each do |el|
    if (el.css(".date").text.match(/Aug 12/))
      if (!el.content.match(/item|house|boots|Rescue/))
        filter_links(el, /Dog|dog|DOG|PUP|Pup|pup/)
      end
    end
  end
end

def get_page_results
  url = "http://sfbay.craigslist.org/sfc/pet/"
  @doc = Nokogiri::HTML(open(url))
  rows = @doc.css(".row")

  get_todays_rows(rows)
end

def search(date_str)
  get_page_results()
end

# want to learn more about
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
@today = Time.now.strftime("%b %d")
# today = "Aug 12"
search(@today)
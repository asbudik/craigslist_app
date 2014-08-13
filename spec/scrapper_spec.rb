require "./scrapper"

describe "scrapper" do

  before(:each) do
    @doc = Nokogiri::HTML(open("today.html"))
    @today = "Aug 12"
  end

  describe "filter_links" do
    it "should here is an example of using the befor each data" do
      rows = @doc.css(".row")
      # puts rows[0].content
      # rows.each do |row|
      #   puts row.content
      # end
      expect(filter_links(rows[0].content, /Albino|dog|puppies/)).to be(true)
    end
  end

  describe "get_todays_rows" do
    it "should return today's rows" do
      count = 0
      @doc.css(".date").each do |el|
        if el.content = "Aug 12"
          puts el
          puts count += 1
        end
      end
      expect(get_todays_rows(@doc, "Aug 12")).to eql(100)
    end
  end
end
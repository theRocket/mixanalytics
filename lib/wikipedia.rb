require 'net/http'
require 'uri'
    
class Wikipedia < SourceAdapter
  attr_accessor :search_query
  
  
  def initialize(source,credential)
    puts "Wikipedia initialize with #{source.inspect.to_s}"
    
    super(source,credential)
  end
  
  #
  # direct response to query from device
  # in the case of wikipedia we return 2 objects per page
  # the header object has information about the page, and
  # the data object has the contents of the page
  #
  # we split this in 2 becasue the data portions are large and we only want
  # to load them selectively for pages to conserve RAM usage on device
  #
  def ask(question)
    puts "Wikipedia ask with #{question.inspect.to_s}\n"
    
    data = ask_wikipedia question
    
    header_id = "header_#{question}"
    data_id = "data_#{question}"
    
    # return array of objects that correspond
    [ 
      ObjectValue.new(:source_id=>@source.id, :object => header_id, 
                      :attrib => "section", :value => "header"),
                      
      ObjectValue.new(:source_id=>@source.id, :object => header_id, 
                      :attrib => "created_at", :value => DateTime.now.to_s),
                    
      ObjectValue.new(:source_id=>@source.id, :object => header_id, 
                      :attrib => "question", :value => question),
                      
      ObjectValue.new(:source_id=>@source.id, :object => header_id, 
                      :attrib => "data_id", :value => data_id),
                                  
      #########
      
      ObjectValue.new(:source_id=>@source.id, :object => data_id, 
                      :attrib => "section", :value => "data"),
                      
      ObjectValue.new(:source_id=>@source.id, :object => data_id, 
                      :attrib => "data_length", :value => data.length.to_s),
                      
      ObjectValue.new(:source_id=>@source.id, :object => data_id, 
                      :attrib => "data", :value => data),

    ]
  end
  
  # NO-OP
  def sync
  end
    
  protected
  
  def wiki_name(raw_string)
    raw_string == "::Home" ? raw_string : ERB::Util.url_encode(raw_string.gsub(" ", "_"))
  end
  
  def ask_wikipedia(search)
    path = "/wiki/#{wiki_name(search)}"
 
    # temporarily we hardcode these headers which are required by m.wikipedia.org
    headers = {
      'User-Agent' => 'Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1C28'
    }
    
    response, data = fetch(path, headers)
    data = rewrite_urls(data)
    
    [data].pack("m").gsub("\n", "")
  end
  
  # follow redirects here on the server until we are at final page
  def fetch(path, headers, limit = 10)
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0
 
    mobile_wikipedia_server_url = @source.url
    mobile_wikipedia_server_url.gsub!('http://', '')
    
    http = Net::HTTP.new(mobile_wikipedia_server_url)
    http.set_debug_output $stderr
    
    response, data = http.get(path, headers)
    
    puts "Code = #{response.code}"
    puts "Message = #{response.message}"
    response.each {|key, val|
      puts key + ' = ' + val
    }
    
    case response
    when Net::HTTPSuccess then
      nil
    when Net::HTTPRedirection then
      # location has changed so in effect new search query
      @search_query = response['location'].sub('/wiki/', '')
      response, data = fetch(response['location'], headers, limit - 1)
    else
      response.error!
    end
    
    return response, data
  end
 
  #
  # wikipedia pages are shown in an iframe in the Rhodes app
  # here we rewrite URLs so that they work in that context
  #
  # rewrite URLs of the form:
  # <a href="/wiki/Feudal_System"
  # to
  # <a href="/Wikipedia/WikipediaPage/{Feudal_System}/fetch"
  #
  
  # Did you mean: <a href="/w/index.php?title=Special:Search&amp;search=blackberry&amp;fulltext=Search&amp;ns0=1&amp;redirs=0" title="Special:Search">
  # <em>blackberry</em>
  # </a>
  
  def rewrite_urls(html)
    # images
    html = html.gsub('<img src="/images/logo-en.png" />', '<img src="http://en.m.wikipedia.org/images/logo-en.png" />')
    html = html.gsub(%Q(src='/images/w.gif'), %Q(src='http://en.m.wikipedia.org/images/w.gif'))
    
    # javascripts
    html = html.gsub('window.location', 'top.location')
    html = html.gsub('/wiki/::Random', '/Wikipedia/WikipediaPage/{::Random}/fetch')
    #stylesheets
    html = html.gsub('<link href=\'/stylesheets/application.css\'', '<link href=\'http://m.wikipedia.org/stylesheets/application.css\'')
    # links to other articles
    html = html.gsub(/href=\"\/wiki\/([\w\(\)%:\-\,._]*)\"/i,'href="/Wikipedia/WikipediaPage/{\1}/fetch" target="_top"')
    # redlinks
    html.gsub(%Q(href="/w/index.php?), %Q(target="_top" href="http://en.wikipedia.org/w/index.php?))
  end
end
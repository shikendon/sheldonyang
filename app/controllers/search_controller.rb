require 'net/http'

class SearchController < ApplicationController
  def index
    @page_title = @site_name
    @tag_i18ns = TagI18n.all.load
    search if params[:q]
  end

  def show
    page = params[:page].to_i rescue nil
    example_ids = TagI18n.find(tag_id).tags.map{ |tag| tag.example_id }
    puts example_ids
    @examples = Example.where(id: example_ids).page(page).load
  end

  def search
    query = params[:q].strip
    @query = query
    page = params[:page].to_i
    @page = page < 1 ? 1 : page

    @page_title = "Search『#{query}』- #{@site_name}"

    if query.present?
      @related_words = search_sinica(query) + search_kwuntung(query)
      @related_words.uniq!
    else
      @related_words = []
      flash.now[:alert] = '您至少必須輸入一個關鍵字才能開始查詢。'
    end

    comments = Comment.where('transtext IN (?)', @related_words)
    example_ids = comments.map{ |comment| comment.example_id }
    @examples = Example.where(id: example_ids)

    render :action => 'search'
  end

  def search_sinica(word)
    begin
      kw0 = word.encode(Encoding::BIG5)
      uri = URI('http://proj1.sinica.edu.tw/~swjz/ftms-bin/scripts/look_for_sym.pl')
      res = post_form(uri, kw0: kw0)
      break if not res.is_a?(Net::HTTPSuccess)
      doc = Nokogiri::HTML(res.body)
      return doc.css('font').map{ |w| w.text.gsub(/\([0-9]+\)/, '').strip }
    rescue => e
      puts e.message
    end while false
    return Array.new
  end

  def search_kwuntung(word)
    begin
      sense = word.encode(Encoding::BIG5)
      uri = URI('http://www.kwuntung.net/synonym/synonym_result2.php')
      uri.query = URI.encode_www_form(Sense: sense)
      res = get_response(uri)
      break if not res.is_a?(Net::HTTPSuccess)
      doc = Nokogiri::HTML(res.body)
      part_1 = doc.css('p.text').first.text.split('\\').map{ |w| w.gsub(/[[:space:]]*/, '').strip }.reject(&:empty?)
      part_2 = doc.css('p a.b').map(&:text)
      return part_1 + part_2
    rescue => e
      puts e.message
    end while false
    return Array.new
  end

  def tag_id
    params[:id]
  end
end

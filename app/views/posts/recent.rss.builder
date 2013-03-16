xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "The List Firehose"
    xml.description "Everything posted to The List"
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post_url(post)
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post.url
        xml.guid post.url
      end
    end
  end
end
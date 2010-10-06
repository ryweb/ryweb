module PublicHelper
  def current(args)
    if args.include?(params[:id])
      return 'current'
    end
  end

  def parseFeed (url, length)
    feed_url = url
    output = "";
    open(feed_url) do |http|
      response = http.read
      result = RSS::Parser.parse(response, false)
      output = "<span class=\"feedTitle\">#{result.channel.title}</span><br /><ul>"
      output = "<table>"
          result.items.each_with_index do |item, i|
        if ++i < length
          output += "<tr><td><strong><a href=\"#{item.link}\" target=\"_blank\">#{item.title}</a></strong></td></tr>"
          output += "<tr><td>#{item.description}</td></tr>"
        end

      end
      output += "</table>"
    end
    return output
  end
end

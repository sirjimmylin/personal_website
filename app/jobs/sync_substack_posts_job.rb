require "rss"
require "open-uri"

class SyncSubstackPostsJob < ApplicationJob
  queue_as :default

  FEED_URL = ENV.fetch("SUBSTACK_FEED_URL", "https://sirjimmylin.substack.com/feed")

  def perform
    URI.open(FEED_URL, "User-Agent" => "Rails-Substack-Sync") do |raw_feed|
      feed = RSS::Parser.parse(raw_feed, false)
      return unless feed&.items

      feed.items.each do |item|
        slug = extract_slug(item.link)
        next if slug.blank?

        raw_html = item.content_encoded.presence || item.description.to_s
        clean_summary = ActionView::Base.full_sanitizer.sanitize(item.description.to_s).squish.truncate(220)

        post = Post.find_or_initialize_by(slug: slug)
        post.assign_attributes(
          title: item.title.to_s.strip,
          body: raw_html,
          summary: post.summary.presence || clean_summary,
          tag: post.tag.presence || item.categories.first&.content,
          published_at: item.pubDate || Time.current,
          external_url: item.link,
          is_html: true
        )
        post.save!
      end
    end
  end

  private

  def extract_slug(url)
    return nil if url.blank?

    URI.parse(url).path.split("/p/").last&.split("/")&.first
  rescue URI::InvalidURIError
    nil
  end
end
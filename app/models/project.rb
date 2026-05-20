require "uri"

class Project < ApplicationRecord
  include PgSearch::Model

  # This creates a "global" search scope
  multisearchable against: [ :title, :summary, :body ]

  validate :repo_link_must_be_http_url
  validate :demo_link_must_be_http_url

  def published?
    published_at.present? && published_at <= Time.current
  end

  # Friendly URLs (e.g., /posts/my-data-science-project)
  def to_param
    slug
  end

  private

  def repo_link_must_be_http_url
    validate_http_url(:repo_link, repo_link)
  end

  def demo_link_must_be_http_url
    validate_http_url(:demo_link, demo_link)
  end

  def validate_http_url(attribute, value)
    return if value.blank?

    uri = URI.parse(value)
    return if uri.is_a?(URI::HTTP) && uri.host.present?

    errors.add(attribute, "must be a valid HTTP(S) URL")
  rescue URI::InvalidURIError
    errors.add(attribute, "must be a valid HTTP(S) URL")
  end
end

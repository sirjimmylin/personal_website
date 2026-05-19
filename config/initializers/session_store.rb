Rails.application.config.session_store :cookie_store,
  key: "_personal_website_session",
  same_site: :lax,
  secure: Rails.env.production?

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.base_uri :self
    policy.font_src :self, :https, :data, "https://cdn.jsdelivr.net"
    policy.img_src :self, :https, :data
    policy.object_src :none
    policy.script_src :self, "https://cdn.jsdelivr.net", "https://cdnjs.cloudflare.com"
    policy.style_src :self, "https://cdn.jsdelivr.net", "https://cdnjs.cloudflare.com"
    policy.form_action :self
    policy.frame_ancestors :none
    policy.block_all_mixed_content
  end

  # Generate session nonces for permitted importmap, inline scripts, and inline styles.
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src]

  # Automatically add `nonce` to `javascript_tag`, `javascript_include_tag`, and `stylesheet_link_tag`
  # if the corresponding directives are specified in `content_security_policy_nonce_directives`.
  config.content_security_policy_nonce_auto = true
end

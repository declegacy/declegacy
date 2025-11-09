# frozen_string_literal: true
if ENV['SENTRY_DSN'].present?
  Sentry.init do |config|
    config.dsn = ENV['SENTRY_DSN']
    config.breadcrumbs_logger = %i[active_support_logger http_logger]
    config.traces_sample_rate = 1.0
    config.send_default_pii = true
  end
end

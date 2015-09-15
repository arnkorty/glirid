#because sidekiq's work don't support http access, so Temporarily using normal access Update
class SyncStatus
  def self.sync(job_id)
    # Rails.logger.info "http://www.baidu.com"
    # url = Rails.application.secrets.host + '/sync_status?jid=' + job_id.to_s
    # Thread.new do
    #   # require 'net/http'
    #   `/usr/local/bin/wget #{url}`
    #   # Rails.logger.info Net::HTTP.get_response 'http://www.baidu.com'
    #   Rails.logger.info "http://www.baidu.com" * 10
    # end
    # # Rails.logger.info Rails.application.secrets.host + '/sync_status?jid=' + job_id.to_s
    # # `/usr/local/bin/wget #{Rails.application.secrets.host + '/sync_status?jid=' + job_id.to_s}`
  end
end

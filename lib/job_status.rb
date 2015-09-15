class JobStatus
  STATUS = [:queued, :working, :complete]
  class << self
    def redis
      @@redis ||= Redis::Namespace.new(
        'JobStatus', redis: Redis.new(url: Rails.application.secrets.redis_url)
      )
    end

    def set_status(jid, status)
      redis.set(jid, status)
      # SyncStatus.sync(jid)
      # Rails.logger.info '*' * 100
    end

    def status(jid)
      redis.get(jid)
    end

    STATUS.each do |st|
      define_method "#{st}?" do |jid|
        redis.get(jid).to_sym == st
      end
    end
  end
  attr_accessor :status, :jid
  def initialize(jid)
    @jid = jid
    @status = JobStatus.status(jid)
  end

  STATUS.each do |st|
    define_method "#{st}?" do
      redis.get(jid).to_sym == st
    end
  end
end

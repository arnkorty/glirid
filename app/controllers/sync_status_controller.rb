class SyncStatusController < ActionController::Base
  def index
    if params[:jid]
      job_id = params[:jid]
      search = Search.find_by(current_work_id: job_id)
      if search
        status = JobStatus.new job_id
        MessageBus.publish "/channel/#{search.account_id}",{
          search_id: search.id,
          en_status: status.status,
          status: I18n.t('job_status.' + status.status)
        }
      end
    end
    render nothing: true
  end
end

class PagesController < ApplicationController
  def about

  end

  def audit_log
    @audit_logs = AuditLog.all.includes(:moderator).order(:created_at => :desc).limit(100)
    # TODO: paginate
  end


  def people
  end

  def faq
  end

  def differences
  end

  def governance
  end

  if Rails.env.development?
    def test_flash
      type = (params[:type] || "alert").to_sym
      msg = params[:message].presence || "Some test flash"
      flash[type] = msg
      redirect_to "/"
    end
  end
end

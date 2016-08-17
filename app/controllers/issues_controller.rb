class IssuesController < ApplicationController
  before_action :set_issue, only: [:update]

  def index
    @issues = Issue.where(:active => true)
  end

  def update
    if @issue.update!(issue_params)
      redirect_to issues_path, notice: 'Issue has been successfully updated.'
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:active)
  end
end

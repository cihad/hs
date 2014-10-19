NodeFilter = Struct.new(:params) do
  def status
    status = params[:status] || ""
    status.empty? ? Node.workflow_spec.state_names.first.to_s : status
  end
end
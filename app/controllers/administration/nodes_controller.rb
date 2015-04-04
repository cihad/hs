require 'node_filter'

module Administration
  class NodesController < BaseController
    def index
      @node_filter = NodeFilter.new(params.fetch :node_filter, {})
      @nodes = Node.where(status: @node_filter.status)
    end

    def destroy
      @node = Node.find params[:id]
      authorize @node
      @node.destroy
      redirect_to administration_nodes_path, notice: I18n.t('nodes.flash.destroyed')
    end
  end
end
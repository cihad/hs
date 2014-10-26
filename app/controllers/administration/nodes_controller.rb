require 'node_filter'

module Administration
  class NodesController < BaseController
    def index
      @node_filter = NodeFilter.new(params[:node_filter] || {})
      @nodes = Node.where(status: @node_filter.status)
    end

    def update
      @node = Node.find(params[:id])
      @node.send(:"#{params[:event]}!")

      
      redirect_path = if params[:event] == "review"
                        edit_node_path(@node)
                      else
                        administration_nodes_path
                      end

      redirect_to redirect_path
    end
  end
end
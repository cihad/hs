# RSpec matcher to spec delegations.
#
# Usage:
#
#     describe Post do
#       it { is_expexted.to delegate(:name).to(:author).with_prefix } # post.author_name
#       it { is_expexted.to delegate(:month).to(:created_at) }
#       it { is_expexted.to delegate(:year).to(:created_at) }
#     end
 
RSpec::Matchers.define :delegate do |method|
  match do |delegator|
    @method = @prefix ? :"#{@to}_#{method}" : method
    @delegator = delegator

    unless @delegator.class.instance_methods.include? method
      raise NoMethodError
    end

    allow(@delegator).to receive(@to).and_return double('receiver')
    allow(@delegator.send(@to)).to receive(method).and_return :called
    @delegator.send(@method) == :called
  end
 
  description do
    "delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end
 
  failure_message do |text|
    "expected #{@delegator} to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end
 
  failure_message_when_negated do |text|
    "expected #{@delegator} not to delegate :#{@method} to its #{@to}#{@prefix ? ' with prefix' : ''}"
  end
 
  chain(:to) { |receiver| @to = receiver }
  chain(:with_prefix) { @prefix = true }
 
end
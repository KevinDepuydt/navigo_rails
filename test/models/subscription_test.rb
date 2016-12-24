require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test 'should not save subscription without amount' do
    subscription = Subscription.new
    assert_not subscription.save, 'Saved the post without an amount'
  end
end

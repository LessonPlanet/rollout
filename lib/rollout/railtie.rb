require 'rollout/context_provider'

ActionController::Base.class_eval do
  class_attribute :rollout_context_class
end

module Rollout
  class Railtie < Rails::Railtie
    initializer 'rollout.controller_extension' do
      ActionController::Base.send(:include, Rollout::ContextProvider)
    end
  end
end
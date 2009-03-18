require 'erb'

# load the common tasks
load "config/deploy/base"

STAGES = %w(development staging production) 
STAGES.each do |name| 
  desc "Set the target stage to `#{name}'." 
  task(name) do 
    set :stage, name.to_sym
    set :rails_env, name.to_sym 
    load "config/deploy/#{stage}" 
  end 
end 
 
on :start, :except => STAGES do 
  if !exists?(:stage) 
    abort "no stage specified, please choose one of #{STAGES.join(", ")}" 
  end 
end
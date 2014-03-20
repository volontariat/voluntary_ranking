module TaskFactoryMethods
  def new_task(name, options = {})
    factory = options[:factory] || :task
    attributes = options[:attributes] || {}
    
    attributes.merge!({name: name})
    set_task_defaults(attributes)
    @task = Factory(factory, attributes)
    @task.reload
    
    @task
  end
    
  def set_task_defaults(attributes)
    attributes[:story_id] ||= @story.id if @story && !attributes[:story_id]
  end
end

World(TaskFactoryMethods)

Given /^a task named "([^\"]*)"$/ do |name|
  new_task(name)
end
class TaskItemComponent < ViewComponent::Base
  include Turbo::FramesHelper
  # include ActionView::Helpers::TagHelper
  # include ActionView::Context

  attr_reader :task

  def initialize(task:)
    @task = task
  end

  def format_time_range
    if task.start_time.to_date == Date.today
      "Today #{task.start_time.strftime('%I:%M %p')} - #{task.end_time.strftime('%I:%M %p')}"
    else
      "#{task.start_time.strftime('%d/%m %I:%M %p')} - #{task.end_time.strftime('%I:%M %p')}"
    end
  end
end

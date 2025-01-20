module TasksHelper
  SORT_OPTIONS = {
    'created_at' => 'Created Date',
    'title' => 'Title',
    'project' => 'Project Name',
    'start_time' => 'Start Time'
  }.freeze

  def sort_label(sort_by)
    SORT_OPTIONS[sort_by] || SORT_OPTIONS['created_at']
  end

  def sort_options
    SORT_OPTIONS
  end
end

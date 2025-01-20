class TabsComponent < ViewComponent::Base
  def initialize
    @tasks = Task.all
  end

  def all_count
    @tasks.count
  end

  def pending_count
    @tasks.open.count
  end

  def completed_count
    @tasks.completed.count
  end
end

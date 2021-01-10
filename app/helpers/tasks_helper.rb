module TasksHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
    elsif action_name == 'edit'
      task_path
    end
  end
end

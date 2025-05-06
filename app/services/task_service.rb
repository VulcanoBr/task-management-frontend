class TaskService < ApiService
  def all(project_id)
    response = self.class.get(api_path("/projects/#{project_id}/tasks"), headers: headers)
    handle_response(response)
  end

  def find(project_id, id)
    response = self.class.get(api_path("/projects/#{project_id}/tasks/#{id}"), headers: headers)
    handle_response(response)
  end

  def create(project_id, task_params)


    puts("task service = #{task_params.inspect}")
    response = self.class.post(api_path("/projects/#{project_id}/tasks"),
      body: { task: task_params }.to_json,
      headers: headers
    )
    handle_response(response)
  end

  def update(project_id, id, task_params)
    response = self.class.put(api_path("/projects/#{project_id}/tasks/#{id}"),
      body: { task: task_params }.to_json,
      headers: headers
    )
    handle_response(response)
  end

  def destroy(project_id, id)
    response = self.class.delete(api_path("/projects/#{project_id}/tasks/#{id}"), headers: headers)
    handle_response(response)
  end
end

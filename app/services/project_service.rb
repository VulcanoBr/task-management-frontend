class ProjectService < ApiService
  def all
    response = self.class.get(api_path('/projects'), headers: headers)
    handle_response(response)
  end

  def find(id)
    response = self.class.get(api_path("/projects/#{id}"), headers: headers)
    handle_response(response)
  end

  def create(project_params)
    response = self.class.post(api_path('/projects'),
      body: { project: project_params }.to_json,
      headers: headers
    )
    handle_response(response)
  end

  def update(id, project_params)
    response = self.class.put(api_path("/projects/#{id}"),
      body: { project: project_params }.to_json,
      headers: headers
    )
    handle_response(response)
  end

  def destroy(id)
    response = self.class.delete(api_path("/projects/#{id}"), headers: headers)
    handle_response(response)
  end
end

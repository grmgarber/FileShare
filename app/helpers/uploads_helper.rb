# Helper for uploads_controller
module UploadsHelper
  def errors_for(model, attr)
    return if model.errors[attr].empty?
    haml_tag('div', class: 'errors') do
      if attr == :upl_file && model.errors[attr][0] == "can't be blank"
        model.errors[attr][0] = 'File selection is required'
      end
      haml_concat model.errors[attr].join(', ')
    end
  end
end

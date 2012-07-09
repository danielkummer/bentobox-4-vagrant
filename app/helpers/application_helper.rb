module ApplicationHelper



  def link_to_add_fields(name, f, association, html_class = "")
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to('#', class: "add_fields #{html_class}", title: name, data: {id: id, fields: fields.gsub("\n", "")}) do
      content_tag :i, '', class: "icon-plus-sign"
    end
  end

  def link_to_add_one_embedded(name, f, field, html_class = "")
    return unless f.object.send(field).nil?
    klass = field.to_s.singularize.camelize.constantize
    obj = klass.new
    id = obj.object_id
    f.object.send("#{field}=", obj)
    fields = f.simple_fields_for(field, obj) do |builder|
      render(field.to_s + "_fields", f: builder)
    end
    link_to('#', class: "add_fields #{html_class} embedd_one", title: name, data: {id: id, fields: fields.gsub("\n", "")}) do
      content_tag :i, '', class: "icon-plus-sign"
    end
  end

  def true_false_label(bool)
    case bool
      when true
        content_tag :span, content_tag(:i, "", :class => "icon-ok-sign"), :class => "badge badge-success"
      when false
        content_tag :span, content_tag(:i, "", :class => "icon-remove-sign"), :class => "badge badge-important"
    end
  end
end



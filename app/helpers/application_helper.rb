module ApplicationHelper
  def code_block(code = nil)
    if block_given?
      code = yield
    end

    render "crypted_notes/code_block", code: code
  end

  def inline_svg(key, width: "23px", height: nil)
    height ||= width

    html = "<svg style=\"width: #{width}; height: #{height}\" viewBox=\"0 0 24 24\" fill=\"none\">"
    html += File.read(File.join(Rails.root, "/app/assets/images/#{key}.svg")).html_safe
    html += "</svg>"
    html.html_safe
  end
end

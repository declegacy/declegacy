module ApplicationHelper
  def code_block(code = nil)
    if block_given?
      code = yield
    end

    render "crypted_notes/code_block", code: code
  end
end

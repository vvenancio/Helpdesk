class TicketMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  def agent_reply(comment)
    @comment = comment
    @to = "#{@comment.ticket.user} <#{@comment.ticket.user.email}>"
    @from = "#{@comment.user} <#{@comment.user.email}>"
    mail(:to => @to, :from => @from, :subject => "Re: #{@comment.ticket.subject}")
  end
end
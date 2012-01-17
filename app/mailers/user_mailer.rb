class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def membership_invitation_email(membership)
    @inviter = User.find_by_id(membership.invited_by)
    @user = membership.user
    @group = membership.group
    @url = accept_membership_url(:id => membership.id, :membership_code => membership.membership_code)
    mail(:to => @user.email, :subject => "You've been invited to join a Zone One group")
  end
end

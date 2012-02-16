class MembershipsController < ApplicationController

  access_control do
    allow logged_in, :to => [:resend_invite, :group_accept, :group_decline]
    allow all, :to => [:accept]
  end

  before_filter :load_object, :only => [:group_accept, :group_decline]

  def resend_invite
    # Limit query to an unaccepted invite to avoid invite emails and acceptances
    # crossing in-flight
    membership = Membership.where(:id => params[:id], :joined_at => nil).limit(1).try :first

    if membership
      if membership.invited_by != current_user.id
        membership.update_attribute(:invited_by, current_user.id)
      end
      membership.send_invitation_email
    else
      ::Rails.logger.warn "Failed to find unaccepted invite in resend_invite() for id: #{params[:id]}"
    end

    head :ok
  end

  def accept
    begin
      membership = Membership.find_by_membership_code(params[:membership_code])
      accept_and_redirect(membership)
    rescue Exception => e
      # Should never happen
      log_exception e
      redirect_to :root
    end
  end

  def group_accept
    # Helper action to accept a group invite without knowing its membership_id
    # or membership_code. Requires logged in user. Used in /groups/index
    accept_and_redirect(@membership)
  end

  def group_decline
    # Helper action, opposite of group_accept
    @membership.try :destroy
    redirect_to groups_path, :notice => "Group invite declined"
  end


  private

  def load_object
    @membership = Membership.where(:group_id => params[:group_id], :user_id => current_user.id).try :first
  end

  def accept_and_redirect(membership)
    if membership.try :accept
      notice = "Thank you for confirming your group membership."
      path = current_user ? groups_path : :root
    else
      notice = "Sorry, but this group invite is expired or invalid. Please contact the group owner directly to request another invite."
      path = :root
    end

    redirect_to path, :notice => notice
  end
end

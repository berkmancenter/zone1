class MembershipsController < ApplicationController

  def resend_invite
    membership = Membership.find(params[:id])
    
    if membership.invited_by != current_user.id
      membership.update_attribute(:invited_by, current_user.id)
    end
    
    membership.send_invitation_email
    head :ok
  end

  def accept
    begin
      membership = Membership.find_by_membership_code(params[:membership_code])
      if membership.try :accept
        notice = "Thank you for confirming your group membership."
        path = current_user ? groups_path : :root
      else
        notice = "Sorry, but this group invite is expired or invalid. Please contact the group owner directly to request another invite."
        path = :root
      end

      redirect_to path, :notice => notice
    rescue Exception => e
      # Should never happen
      log_exception e
      redirect_to :root
    end
  end
end

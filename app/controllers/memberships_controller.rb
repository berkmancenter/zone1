class MembershipsController < ApplicationController
  def accept
    begin
    @membership = Membership.find(params[:id])
    if @membership.membership_code == params[:membership_code]
      @membership.accept
    end
    rescue Exception => e
      log_exception e
    end

    # Redirect and thank regardless of whether or not code was confirmed.
    # Keeps out brute force attempts.

    redirect_to :root, :notice => "Thank you for confirming your membership."
  end
end

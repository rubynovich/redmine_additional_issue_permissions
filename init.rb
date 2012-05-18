require 'redmine'
require 'dispatcher'
require_dependency 'issue_patch'

Dispatcher.to_prepare do
  Issue.send(:include, IssuePatch) unless Issue.include? IssuePatch
end

Redmine::Plugin.register :redmine_additional_issue_permissions do
  name 'Redmine Additional Issue Permissions plugin'
  author 'Roman Shipiev'
  description 'Redmine plugin adding 14 new issue permissions (for edit)'
  version '0.0.2'
  url 'https://github.com/rubynovich/redmine_additional_issue_permissions'
  author_url 'http://roman.shipiev.me'
  
  project_module :issue_tracking do
    permission :edit_status_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_status_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    
    permission :edit_start_date_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_start_date_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    
    permission :edit_due_date_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_due_date_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    
    permission :edit_assigned_to_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_assigned_to_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
         
    permission :edit_parent_issue_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_parent_issue_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}

    permission :edit_done_ratio_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_done_ratio_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    
    permission :edit_estimated_hours_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_estimated_hours_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
  end  
end

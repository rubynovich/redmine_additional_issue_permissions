require 'redmine'

Redmine::Plugin.register :redmine_additional_issue_permissions do
  name 'Additional permissions for issues'
  author 'Roman Shipiev'
  description 'The plugin add new permissions for following fields: status, start_date, due_date, assigned_to, parent_issue, done_ratio, estimated_hours. Each of these permissions is available in two variants: for author and for performer.'
  version '0.0.4'
  url 'https://bitbucket.org/rubynovich/redmine_additional_issue_permissions'
  author_url 'http://roman.shipiev.me'

  project_module :issue_tracking do
    permission :edit_status, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_status_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_status_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}

    permission :edit_start_date, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_start_date_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_start_date_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}

    permission :edit_due_date, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_due_date_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_due_date_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}

    permission :edit_assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_assigned_to_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_assigned_to_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}

    permission :edit_parent_issue, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_parent_issue_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_parent_issue_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}

    permission :edit_done_ratio, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_done_ratio_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_done_ratio_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}

    permission :edit_estimated_hours, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_estimated_hours_4author, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
    permission :edit_estimated_hours_4assigned_to, {:issues => [:edit, :update, :bulk_edit, :bulk_update, :update_form], :journals => [:new], :attachments => :upload}
  end
end

if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
end

object_to_prepare.to_prepare do
  [:issue].each do |cl|
    require "aip_#{cl}_patch"
  end

  [
    [Issue, AdditionalIssuePermissionsPlugin::IssuePatch]
  ].each do |cl, patch|
    cl.send(:include, patch) unless cl.included_modules.include? patch
  end
end

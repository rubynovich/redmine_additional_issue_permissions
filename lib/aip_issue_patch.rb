require_dependency 'issue'

module AdditionalIssuePermissionsPlugin
  module IssuePatch
    def self.included(base)
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      base.class_eval do
        edit_attributes = ['tracker_id',
          'status_id',
          'category_id',
          'assigned_to_id',
          'priority_id',
          'fixed_version_id',
          'subject',
          'description',
          'start_date',
          'due_date',
          'done_ratio',
          'estimated_hours',
          'custom_field_values',
          'custom_fields',
          'lock_version',
          'notes']
        @safe_attributes = @safe_attributes.reject{ |a,b| a == edit_attributes }
        safe_attributes *edit_attributes, if: ->(issue, user) {
          issue.new_record? || user.allowed_to?(:edit_issues, issue.project) ||
          (issue.author == user) && user.allowed_to?(:edit_issues_4author, issue.project) ||
          (issue.assigned_to == user) && user.allowed_to?(:edit_issues_4assigned_to, issue.project)
        }

        validates_presence_of :assigned_to_id, :due_date
        validate :validate_year_start_date, if: ->(o) { o.start_date && (o.start_date.year < Date.today.year - 1) }
        validate :validate_year_due_date, if: ->(o) { o.due_date && (o.due_date.year < Date.today.year - 1) }

        alias_method_chain :attachments_deletable?, :author_and_assigned_to_permissions

        safe_attributes 'status_id',
          :if => lambda {|issue, user|
            (
              (user == issue.assigned_to) &&
                user.allowed_to?(:edit_status_4assigned_to, issue.project)
            ) || (
              (user == issue.author) &&
                user.allowed_to?(:edit_status_4author, issue.project)
            ) ||
              user.allowed_to?(:edit_status, issue.project)
          }
        safe_attributes 'assigned_to_id',
          :if => lambda {|issue, user|
            (
              (user == issue.assigned_to) &&
                user.allowed_to?(:edit_assigned_to_4assigned_to, issue.project)
            ) || (
              (user == issue.author) &&
                user.allowed_to?(:edit_assigned_to_4author, issue.project)
            ) ||
              user.allowed_to?(:edit_assigned_to, issue.project)
          }
        safe_attributes 'done_ratio',
          :if => lambda {|issue, user|
            (
              (user == issue.assigned_to) &&
                user.allowed_to?(:edit_done_ratio_4assigned_to, issue.project)
            ) || (
              (user == issue.author) &&
                user.allowed_to?(:edit_done_ratio_4author, issue.project)
            ) ||
              user.allowed_to?(:edit_done_ratio, issue.project)
          }
        safe_attributes 'start_date',
          :if => lambda {|issue, user|
            (
              (user == issue.assigned_to) &&
                user.allowed_to?(:edit_start_date_4assigned_to, issue.project)
            ) || (
              (user == issue.author) &&
                user.allowed_to?(:edit_start_date_4author, issue.project)
            ) ||
              user.allowed_to?(:edit_start_date, issue.project)
          }
        safe_attributes 'due_date',
          :if => lambda {|issue, user|
            (
              (user == issue.assigned_to) &&
                user.allowed_to?(:edit_due_date_4assigned_to, issue.project)
            ) || (
              (user == issue.author) &&
                user.allowed_to?(:edit_due_date_4author, issue.project)
            ) ||
              user.allowed_to?(:edit_due_date, issue.project)
          }
        safe_attributes 'parent_issue_id',
          :if => lambda {|issue, user|
            (
              (user == issue.assigned_to) &&
                user.allowed_to?(:edit_parent_issue_4assigned_to, issue.project)
            ) || (
              (user == issue.author) &&
                user.allowed_to?(:edit_parent_issue_4author, issue.project)
            ) ||
              user.allowed_to?(:edit_parent_issue, issue.project)
          }
        safe_attributes 'estimated_hours',
          :if => lambda {|issue, user|
            (
              (user == issue.assigned_to) &&
                user.allowed_to?(:edit_estimated_hours_4assigned_to, issue.project)
            ) || (
              (user == issue.author) &&
                user.allowed_to?(:edit_estimated_hours_4author, issue.project)
            ) ||
              user.allowed_to?(:edit_estimated_hours, issue.project)
          }
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def attachments_deletable_with_author_and_assigned_to_permissions?(user=User.current)
        (respond_to?(:visible?) ? visible?(user) : true) && ((
          (user == self.author) && user.allowed_to?(:edit_issues_4author, self.project)
        ) || (
          (user == self.assigned_to) && user.allowed_to?(:edit_issues_4assigned_to, self.project)
        ) || (
          user.allowed_to?(self.class.attachable_options[:view_permission], self.project)
        ))
      end

      def allowed_additional_premissions?(user=User.current)
        %w{status assigned_to done_ratio start_date due_date parent_issue estimated_hours}.any?{ |field|
          (
            (user == self.assigned_to) &&
              (user.allowed_to?(:"edit_#{field}_4assigned_to", self.project))
          ) || (
            (user == self.author) &&
              (user.allowed_to?(:"edit_#{field}_4author", self.project))
          ) || user.allowed_to?(:"edit_#{field}", self.project)
        }
      end

      def status_allowed?(user=User.current)
        if user == self.author
          user.allowed_to?(:edit_status_4author, self.project)
        elsif user == self.assigned_to
          user.allowed_to?(:edit_status_4assigned_to, self.project)
        else
          self.new_record? ||
            user.allowed_to?(:edit_issues, self.project) ||
            user.allowed_to?(:edit_status, self.project)
        end
      end

      def assigned_to_allowed?(user=User.current)
        if user == self.author
          user.allowed_to?(:edit_assigned_to_4author, self.project)
        elsif user == self.assigned_to
          user.allowed_to?(:edit_assigned_to_4assigned_to, self.project)
        else
          self.new_record? ||
            user.allowed_to?(:edit_issues, self.project) ||
            user.allowed_to?(:edit_assigned_to, self.project)
        end
      end

      def done_ratio_allowed?(user=User.current)
        if user == self.author
          user.allowed_to?(:edit_done_ratio_4author, self.project)
        elsif user == self.assigned_to
          user.allowed_to?(:edit_done_ratio_4assigned_to, self.project)
        else
          self.new_record? ||
            user.allowed_to?(:edit_issues, self.project) ||
            user.allowed_to?(:edit_done_ratio, self.project)
        end
      end

      def validate_year_start_date
        errors.add :start_date, :inclusion
      end

      def validate_year_due_date
        errors.add :due_date, :inclusion
      end
    end
  end
end

module GitHelper
  class << self
    include ActionView::Helpers::TagHelper

    attr_accessor :output_buffer

    def git_info
      @@info ||= begin
        {
          application: app_name = (Rails.application.class.to_s.split('::').first rescue ""),
          environment: Rails.env,
          remote_url: `git remote -v`,
          remote_branch: `git branch -r`,
          last_commit: `git log --max-count=1`,
          tag: `git describe --abbrev=0 --tags --always`
        }
      rescue
        {}
      end
    end

    def info_text
      return git_info.map do |k, v|
        content_tag(:div) do
          out = content_tag(:span, "#{k.to_s.humanize} : ", :class => "strong")
          out.concat content_tag(:span, "#{v}")
        end
      end.join()
    end

    def tag_text
      content_tag(:p) do
        out = "Version: "
        out.concat git_info[:tag]
      end

    end
  end
end

::ActionController::Base.send :include, GitHelper
::ActionView::Base.send :include, GitHelper
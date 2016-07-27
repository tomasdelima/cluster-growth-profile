require Rails.root.join('lib', 'rails_admin_download_report.rb')

RailsAdmin.config do |config|
  module RailsAdmin
    module Config
      module Actions
        class DownloadReport < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    # bulk_delete
    show
    edit
    # delete
    # show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    download_report
  end

  config.model 'Admin' do
    fields :email, :password
    fields :created_at, :updated_at, :last_sign_in_at, :sign_in_count do
      visible true
      read_only true
    end
  end

  config.model 'User' do
    fields :name, :email, :password, :clusters
    fields :created_at, :updated_at, :last_sign_in_at, :sign_in_count do
      visible true
      read_only true
    end
    field(:password) { label 'Alterar a senha' }
    list do
      field(:password) { hide }
    end
  end

  config.model 'Cluster' do
    include_all_fields
    exclude_fields :id
  end

  config.model 'SuperCluster' do
    include_all_fields
    exclude_fields :id
  end

  config.model 'City' do
    include_all_fields
    exclude_fields :id
  end

  config.model 'GrowthProfile' do
    label 'Perfil de crescimento'
    field(:id) { hide }
    include_all_fields
    exclude_fields :id, :gregorian_cycle

    fields(:external_human_resources, :active_internal_human_resources, :youth_conferences_accompaniments) do
      read_only true
      pretty_value do
        bindings[:object][name].reduce('') do |memo1, line|
          memo1 += line.reduce("") do |memo2, (k,v)|
            k = "activerecord.attributes.growth_profile.#{name}_fields.#{k}"
            memo2 += "<strong>#{I18n.t k}:</strong> #{v}; "
            memo2
          end
          memo1 += "<br/>"
        end.html_safe
      end
    end

    fields(:accumulated_pyramid, :growth_pyramid) do
      read_only true
      pretty_value do
        bindings[:object][name].sort.reduce('') do |memo, (k, v)|
          k = "activerecord.attributes.growth_profile.#{name}_fields.#{k}"
          memo += "<strong>#{I18n.t k}:</strong> #{v}<br/>"
        end.html_safe
      end
    end
  end
end

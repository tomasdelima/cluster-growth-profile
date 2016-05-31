class ClusterGrowthController < ApplicationController
  before_action :find_cluster, only: [:new, :create]
  before_action :find_growth_profile, only: [:new, :create]

  def new
  end

  def create
    growth_profile.cluster = @cluster
    growth_profile.save
    render nothing: true
  end

  private

  def find_cluster
    @cluster ||= Cluster.last || Cluster.new
  end

  def find_growth_profile
    @growth_profile ||= GrowthProfile.last || GrowthProfile.new
  end

  def growth_profile
    GrowthProfile.find_or_initialize_by(cycle: params[:cycle]) do |gp|
      gp.assign_attributes(growth_profile_params)
    end
  end

  def growth_profile_params
    {
      cycle: params[:cycle],
    }
  end

  def current_cycle
    today = Date.today

    cycle_number = 1
    cycle_number += 1 if today >= Date.new(today.year, 7, 20)
    cycle_number += 1 if today >= Date.new(today.year, 10, 20)
    cycle_number += 1 if today >= Date.new(today.year + 1, 1, 20)

    year = ((today - Date.new(1844, 4, 20)).days/1.year).ceil

    "#{cycle_number}-#{year}"
  end
end

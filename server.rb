# frozen_string_literal: true

require './calculate_caloric_metabolism.rb'
require './factors.rb'
require 'bundler'
Bundler.require

get '/index' do
  erb :index
end

post '/index' do
  person_params = {
    gender: params[:gender],
    age_in_years: params[:age_in_years].to_f,
    height_in_cm: params[:height_in_cm].to_f,
    weight_in_kilograms: params[:weight_in_kilograms].to_f
  }

  activity_params = {
    hours_sleeping: params[:hours_sleeping].to_f,
    hours_sitting_low: params[:hours_sitting_low].to_f,
    hours_sitting_middle: params[:hours_sitting_middle].to_f,
    hours_sitting_high: params[:hours_sitting_high].to_f,
    hours_standing: params[:hours_standing].to_f,
    hours_exerting: params[:hours_exerting].to_f
  }

  calculator = CalculateCaloricMetabolism.new(person_params)
  @result = calculator.call(activity_params)

  erb :result
end

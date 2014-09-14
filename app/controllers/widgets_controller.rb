class WidgetsController < ApplicationController

  def index

  end

  def add
    @widget = Widget.new(type: "Widget::#{params[:name].typify}")
  end

  def configure

  end

end

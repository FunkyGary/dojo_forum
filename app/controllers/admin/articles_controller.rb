class Admin::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  # 其他程式碼
end

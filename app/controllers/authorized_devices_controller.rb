class AuthorizedDevicesController < ApplicationController
  before_action :set_authorized_device, only: [:show, :edit, :update, :destroy]

  def index
    @authorized_devices = AuthorizedDevice.all
  end

  def show; end

  def new
    @authorized_device = AuthorizedDevice.new
  end

  def create
    @authorized_device = AuthorizedDevice.new(authorized_device_params)
    if @authorized_device.save
      redirect_to authorized_devices_path,
                    notice: t('controller.authorized_device.create.success')
    else
      redirect_back fallback_location: authorized_devices_path,
        flash: {error: t('controller.fail',
        errors: "<br><hr> #{@authorized_device.errors.full_messages.join("<br>")}")}
    end
  end

  def edit; end

  def update
    if @authorized_device.update(authorized_device_params)
      redirect_to authorized_devices_path,
                    notice: t('controller.authorized_device.update.success')
    else
      redirect_back fallback_location: root_path,
                    notice: t('controller.fail',
                            @authorized_device.errors.messages[:description].first)
    end
  end

  def destroy
    if @authorized_device.desroy
      redirect_to authorized_devices_path,
                    notice: t('controller.authorized_device.desroy.success')
    else
      redirect_back fallback_location: root_path,
                    notice: t('controller.fail',
                            @authorized_device.errors.messages[:description].first)
    end
  end

  private
    def authorized_device_params
      params.require(:authorized_device).permit(:name, :serial_number)
    end

    def set_authorized_device
      @authorized_device = AuthorizedDevice.find(params[:id])
    end
end

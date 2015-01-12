class AirvmsController < ApplicationController
  before_action :set_airvm, only: [:show, :edit, :update, :destroy]

  #NO ACCESS TO INDEX!
  # GET /airvms
  # GET /airvms.json
  def index
    #@airvms = Airvm.all
    begin
      @airvms = Aitvm.watchmakallit.itaintgonnawork
    rescue
      redirect_to :root, notice: "Bad Boy! You know you're not supposed to look there."
    end
  end

  # GET /airvms/1
  # GET /airvms/1.json
  def show
    begin
      vcloud = Fog::Compute::VcloudDirector.new(
        :vcloud_director_username => @airvm.user,
        :vcloud_director_password => @airvm.password,
        :vcloud_director_host => @airvm.host,
        :vcloud_director_show_progress => false, # task progress bar on/off
      )
      @organizations = vcloud.organizations.all
    rescue
      @airvm.destroy
      redirect_to :root, notice: 'Bad Credentials Supplied. Please Try Again.'
    end
  end

  def getVdcsFromOrg
      vcloud = Fog::Compute::VcloudDirector.new(
        :vcloud_director_username => params[:user],
        :vcloud_director_password => params[:password],
        :vcloud_director_host => params[:host],
        :vcloud_director_show_progress => false, # task progress bar on/off
      )

      org = vcloud.organizations.get_by_name(params[:org])
      @vdcs = org.vdcs.all

      respond_to do |format|
        format.html
        format.json { render :json => @vdcs }
      end
  end

  def getvAppsFromVDC
    vcloud = Fog::Compute::VcloudDirector.new(
      :vcloud_director_username => params[:user],
      :vcloud_director_password => params[:password],
      :vcloud_director_host => params[:host],
      :vcloud_director_show_progress => false, # task progress bar on/off
    )

    org = vcloud.organizations.get_by_name(params[:org])
    @vapps = org.vdcs.get_by_name(params[:vdc]).vapps.all

    respond_to do |format|
      format.html
      format.json { render :json => @vapps }
    end
  end

  def getVMFromvApps
    vcloud = Fog::Compute::VcloudDirector.new(
      :vcloud_director_username => params[:user],
      :vcloud_director_password => params[:password],
      :vcloud_director_host => params[:host],
      :vcloud_director_show_progress => false, # task progress bar on/off
    )



    org = vcloud.organizations.get_by_name(params[:org])
    vapp = org.vdcs.get_by_name(params[:vdc]).vapps.get_by_name(params[:vapp])
    vms = vapp.vms.all

    vappPayload = {
            vappname: vapp.name,
            vappowner: vapp.owner[:name],
            description: vapp.description,
            network: vapp.network_config[:networkName],
            vms: [],
        }.to_json

    @payload_hash = JSON.parse(vappPayload)

    vms.each do |vm|
      @payload_hash['vms'] << {vmname: vm.name, vmstatus: vm.status, vmos: vm.operating_system, vmip: vm.ip_address, vmcpu: vm.cpu, vmram: vm.memory, vmhdd:vm.hard_disks}
    end
    
    puts @payload_hash

    respond_to do |format|
      format.html
      format.json { render :json => @payload_hash }
    end
  end



  # GET /airvms/new
  def new
    @airvm = Airvm.new
  end

  # GET /airvms/1/edit
  def edit
  end

  # POST /airvms
  # POST /airvms.json
  def create
    @airvm = Airvm.new(airvm_params)

    respond_to do |format|
      if @airvm.save
        format.html { redirect_to @airvm, notice: 'Airvm was successfully created.' }
        format.json { render :show, status: :created, location: @airvm }
      else
        format.html { render :new }
        format.json { render json: @airvm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airvms/1
  # PATCH/PUT /airvms/1.json
  def update
    respond_to do |format|
      if @airvm.update(airvm_params)
        format.html { redirect_to @airvm, notice: 'Airvm was successfully updated.' }
        format.json { render :show, status: :ok, location: @airvm }
      else
        format.html { render :edit }
        format.json { render json: @airvm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airvms/1
  # DELETE /airvms/1.json
  def destroy
    @airvm.destroy
    respond_to do |format|
      format.html { redirect_to :root, notice: 'Airvm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airvm
      @airvm = Airvm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def airvm_params
      params.require(:airvm).permit(:user, :password, :host)
    end
end

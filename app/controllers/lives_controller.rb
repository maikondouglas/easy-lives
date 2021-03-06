class LivesController < ApplicationController
  before_action :set_live, only: %i[edit update]

  # GET /lives
  def index
    @lives = Live.all
  end

  # GET /lives/new
  def new
    @live = Live.new
  end

  # GET /lives/1/edit
  def edit
    if @live.author != current_user
      redirect_to lives_path, alert: 'Você não tem permissão editar essa live'
    end
  end

  # POST /lives
  def create
    @live = Live.new(live_params.merge(author: current_user))

    if @live.save
      redirect_to lives_path, notice: 'Sugestão de Live foi criada com sucesso!'
    else
      # flash.now[:alert] = @live.errors.full_message.to_sentence
      render :new
    end
  end

  # PATCH/PUT /lives/1
  def update
    if @live.update(live_params)
      redirect_to lives_path, notice: 'Sugestão de Live foi atualizada com sucesso'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_live
      @live = Live.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def live_params
      params.require(:live).permit(:subject, :description)
    end
end

class UrlExamplesController < ApplicationController
  before_action :set_url_example, only: [:show, :edit, :update, :destroy]
  # GET /url_examples
  # GET /url_examples.json
  def index
    @url_examples = UrlExample.order(:longUrl).page(params[:page]).per(5)
  end

  # GET /url_examples/1
  # GET /url_examples/1.json
  def show
    @url_example.qtdAcesso = ((@url_example.qtdAcesso).to_i + 1).to_s
    
    @url_example.save
  end

  # GET /url_examples/new
  def new
    @url_example = UrlExample.new
  end

  # GET /url_examples/1/edit
  def edit
  end

  # POST /url_examples
  # POST /url_examples.json
  def create
    require 'securerandom'
    @url_example = UrlExample.new(url_example_params)
   
    @aux = UrlExample.where(customAlias: @url_example.customAlias)
    
    #Verifica se o custom alias já foi cadastrao
    if(@aux.count<1)
      ##Verifica se a URL é valida
      if(@url_example.longUrl[0, 7] == 'http://' || @url_example.longUrl[0, 8] == 'https://')
        
        #redirect_to @url_example.longUrl
        
        @url_example.shortUrl = 'https://shorturl/'
        
        
        if(@url_example.customAlias == nil || @url_example.customAlias == '' || @url_example.customAlias == ' ')
          @url_example.customAlias = SecureRandom.hex(2) + rand(1..10).to_s
        end
        
        @url_example.shortUrl = @url_example.shortUrl << @url_example.customAlias      
            
        respond_to do |format|
          if @url_example.save
            format.html { redirect_to url_examples_path, notice:  'Url gerada com sucesso! Alias: ' + @url_example.customAlias }
            format.json { render :show, status: :created, location: @url_example }
          else
            format.html { render :new }
            format.json { render json: @url_example.errors, status: :unprocessable_entity }
          end
        end
      ### URL INVALIDA 
      else
      respond_to do |format|
        format.html { redirect_to url_examples_path, notice:  'Url inválida' }
        format.json { render json: @url_example.errors, status: :unprocessable_entity }
        end
      end
    
    ## Custom Alias já existe:
  else
     respond_to do |format|
        format.html { redirect_to url_examples_path, notice:  '{ERR_CODE: 001, Description:CUSTOM ALIAS ALREADY EXISTS}' }
        format.json { render json: @url_example.errors, status: :unprocessable_entity }
        end
    end
   
  end

  # PATCH/PUT /url_examples/1
  # PATCH/PUT /url_examples/1.json
  def update
    respond_to do |format|
      if @url_example.update(url_example_params)
        format.html { redirect_to @url_example, notice: 'Url example was successfully updated.' }
        format.json { render :show, status: :ok, location: @url_example }
      else
        format.html { render :edit }
        format.json { render json: @url_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /url_examples/1
  # DELETE /url_examples/1.json
  def destroy
    @url_example.destroy
    respond_to do |format|
      format.html { redirect_to url_examples_url, notice: I18n.t('messages.destroy') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url_example
      @url_example = UrlExample.find(params[:id])
    end
    
   #Never trust parameters from the scary internet, only allow the white list through.
    def url_example_params
      params.require(:url_example).permit(:longUrl, :shortUrl, :customAlias, :qtdAcesso)
    end
end

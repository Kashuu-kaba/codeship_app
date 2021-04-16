class ProductsController < ApplicationController
before_action :correct_user, only: [:new, :destroy, :edit]

    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            redirect_to products_path, notice: "登録しました"
        else
            render :new
        end
    end

    def show
        @product = Product.find(params[:id])
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            redirect_to product_path(@product), notice: "更新しました"
        else
            render :edit
        end
    end

    def destroy
        @product = Product.find(params[:id])
        if @product.destroy
            redirect_to products_path, notice: "削除しました"
        else
            render :show
        end
    end

    private
    def product_params
        params.require(:product).permit(:name, :description, :price, :image)
    end

    def correct_user
        if current_user.admin == false
            redirect_back(fallback_location: root_path)
        end
    end
end

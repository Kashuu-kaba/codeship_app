class CartProductsController < ApplicationController
    def create
        cart = current_user.cart || current_user.create_cart
        @product = Product.find_by(id: params[:product_id])
        cart.cart_products.create(product_id: @product.id)
        redirect_to cart_products_path, notice: "カートに追加しました"
    end

    def index
        cart = current_user.cart || current_user.create_cart
        @products = cart.products
        @total_price = @products.pluck(:price).sum()
        @product_group = @products.group(:name).count
    end

    def destroy
        cart = current_user.cart
        product = Product.find(params[:product_id])
        delete_product = cart.cart_products.find_by(product_id: product.id)
        delete_product.destroy
        redirect_to products_path, notice: "削除しました"
    end
end

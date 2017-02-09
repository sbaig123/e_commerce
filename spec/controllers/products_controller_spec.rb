require 'rails_helper'

Rails.describe ProductsController do

	describe "Guest Access:" do
    it "index page" do
      get 'index'
			assert_equal Product.all, assigns(:products)
      assert_template 'products/index'
    end

		it "show page" do
			product = create :product
			get 'show', params: { id: product.id }
			assert_equal product, assigns(:product)
			assert_template 'products/show'
		end

		it 'no access to new page' do
			get 'new'
			expect(response).to redirect_to(sign_in_path)
		end

		it 'no access to edit page' do
			product = create :product
			get 'edit', params: {id: product.id}
			expect(response).to redirect_to(sign_in_path)
		end
	end

	describe "Customer Access:" do

		before do
			customer = create :user
			sign_in customer
		end

		it 'no access to new page' do
			get 'new'
			expect(response).to redirect_to(products_path)
			expect(flash[:error]).to match(/User is not authorised/)
		end

		it 'no access to edit page' do
			product = create :product
			get 'edit', params: {id: product.id}
			expect(response).to redirect_to(products_path)
			expect(flash[:error]).to match(/User is not authorised/)
		end

		it 'cannot be posted' do
			post 'create', params: {product: {name: 'New', price: 1.99, description: 'Great Product'}}
			expect(flash[:error]).to match(/User is not authorised/)
			expect(response).to redirect_to(products_path)
		end

		it 'cannot be updated' do
			product = create :product
			put 'update', params: {id: product.id, product: {name: 'updated'}}
			expect(flash[:error]).to match(/User is not authorised/)
			expect(response).to redirect_to(products_path)
		end

		it 'cannot be destroyed' do
			product = create :product
			delete 'destroy', params: {id: product.id}
			expect(response).to redirect_to(products_path)
			expect(flash[:error]).to match(/User is not authorised/)
		end

  end

	describe "Admin Access:" do

		before do
			admin = create :user, admin: true
			sign_in admin
		end
		
		it 'new page' do
			get 'new'
			assert_template 'products/new'
		end

		it 'can create' do
			post 'create', params: {product: {name: 'New', price: 1.99, description: 'Great Product'}}
			expect(flash[:notice]).to match(/Product was successfully created/)
		end

		it 'edit page' do
			product = create :product
			get 'edit', params: {id: product.id}
			assert_template 'products/edit'
		end

		it 'can update with valid params' do
			product = create :product
			put 'update', params: {id: product.id, product: {name: 'updated'}}
			expect(flash[:notice]).to match(/Product was successfully updated/)
			expect(response).to redirect_to(product_path(id: product.id))
		end

		it 'cannot update with invalid params' do
			product = create :product
			put 'update', params: {id: product.id, product: {name: ''}}
			expect(response).to render_template('products/edit')
		end

		it 'can be destroyed by admin' do
			product = create :product
			delete 'destroy', params: {id: product.id}
			expect(response).to redirect_to(products_path)
			expect(flash[:notice]).to match(/Product has been removed/)
		end

	end

end

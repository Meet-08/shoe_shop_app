# shop_app

A Flutter shoe store app with cart functionality.

## Features

- Browse a collection of shoes from brands like Nike, Adidas, and Puma
- Filter products by brand
- Search for products by name
- View product details and select size
- Add products to a cart
- Remove products from the cart

## Project Structure

- `lib/global_variable.dart`: Contains the product data used throughout the app
- `lib/main.dart`: App entry point, sets up theme and provider
- `lib/pages/home_page.dart`: Main page with bottom navigation (Home & Cart)
- `lib/pages/cart_page.dart`: Displays products added to the cart, allows removal
- `lib/pages/product_details_page.dart`: Shows product details and allows adding to cart
- `lib/provider/cart_provider.dart`: Manages cart state using Provider
- `lib/widgets/product_card.dart`: UI widget for displaying a product summary
- `lib/widgets/product_list.dart`: Displays and filters the list of products

function add_to_cart(pid, pname, price)
{
    let cart = localStorage.getItem("cart");

    if (cart == null)
    {
        //no cart yet

        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        console.log("Product is added for the first time");
        showToast("Item is added to cart.");
        
    } else
    {
        //cart is already present
        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find((item) => item.productId == pid);
        console.log(oldProduct);

        if (oldProduct)
        {
            //we have to increase the quantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;
            pcart.map((item) => {
                if (item.productId === oldProduct.productId)
                {
                    item.productQuantity = oldProduct.productQuantity;
                }
            });
            localStorage.setItem("cart", JSON.stringify(pcart));
            console.log("Product quantity is increased");
            showToast(oldProduct.productName + " quantity is increased productQuantity. Quantity= "+ oldProduct.productQuantity);
            
        } else {
            //we have to add product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            console.log("Product is added");
            showToast("Product is added to cart.");
        }
    }

    updateCart();
}


//update cart
function updateCart()
{
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);

    if (cart == null || cart.length == 0)
    {
        console.log("Cart is empty !!!");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart doesn't have any item</h3>");
        $(".checkout-btn").attr('disabled',true);
    } else {
        //there is items in cart
        console.log(cart);
        $(".cart-items").html(`( ${cart.length} )`);

        let table = `
        
        <table class='table'>
                <thead class='thead-light'>
                    <tr>
                        <th>Item Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total Price</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
        
        
    `;


        let totalPrice = 0;

        cart.map((item)=>{
            
                    table+= `
                    
                    <tr>
                        <td> ${item.productName} </td>
                        <td> ${item.productPrice} </td>
                        <td> ${item.productQuantity} </td>
                        <td> ${item.productQuantity * item.productPrice} </td>
                        <td> <button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Remove</button>
                    </tr>


                    `;
        
        totalPrice += item.productPrice * item.productQuantity;
        
        });
        
        
        
        table = table + `
            <tr><td colspan='5' class='text-right font-weight-bold m-5'> Total Price : ${totalPrice} </td></tr>
            </tbody></table>`;
        $(".cart-body").html(table);

        $(".checkout-btn").attr('disabled',false);
    }
}

//delete item
function deleteItemFromCart(pid)
{
    let cart = JSON.parse(localStorage.getItem('cart'));
    
    let newcart = cart.filter((item) => item.productId != pid);
    
    localStorage.setItem('cart', JSON.stringify(newcart));
    
    updateCart();
    
    showToast("Item is removed from the cart.");
}


$(document).ready(function () {
    updateCart();
    });



function showToast(content) {
    $('#toast').addClass("display");
    $('#toast').html(content);
    setTimeout(()=> {
        $('#toast').removeClass('display');
    }, 2000);
}


function goToCheckout() {
    let cart = localStorage.getItem("cart");

    if (!cart) {
        alert("Cart is empty!");
        return;
    }

    // Send cart JSON via form
    let form = document.createElement("form");
    form.method = "POST";
    form.action = "PlaceOrderServlet";

    let input = document.createElement("input");
    input.type = "hidden";
    input.name = "cartJson";
    input.value = cart;

    form.appendChild(input);
    document.body.appendChild(form);
    form.submit();
}



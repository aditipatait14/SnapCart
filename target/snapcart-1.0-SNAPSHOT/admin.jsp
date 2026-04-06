
<%@page import="com.cart.snapcart.helper.Helper"%>
<%@page import="java.util.*"%>
<%@page import="com.cart.snapcart.entities.Category"%>
<%@page import="com.cart.snapcart.dao.CategoryDao"%>
<%@page import="com.cart.snapcart.helper.FactoryProvider"%>
<%@page import="com.cart.snapcart.entities.User"%>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in!! Login first");
        response.sendRedirect("login.jsp");
        return;

    } else {

        if (user.getUserType().equals("normal")) {

            session.setAttribute("message", "You are not Admin!! Don't access this page");
            response.sendRedirect("login.jsp");
            return;
        }
    }


%>

<%  CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cdao.getCategories();

//getting count
    Map<String, Long> m = Helper.getCounts(FactoryProvider.getFactory());

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>



    </head>
    <body>

        <%@include  file="components/navbar.jsp"%>

        <div class="container admin">


            <div class="container-fluid mt-3">
                <%@include file = "components/message.jsp" %>
            </div>



            <div class="row mt-3">

                <!--First col-->
                <div class="col-md-4">

                    <!--first box-->
                    <div class="card">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width:125px " class="img-fluid" src ="img/team.png" alt="user_icon">
                            </div>
                            <h1><%=m.get("userCount")%></h1>
                            <h1 class="text-muted">USERS</h1>

                        </div>
                    </div>
                </div>


                <!--Second col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width:125px " class="img-fluid" src ="img/options.png" alt="user_icon">
                            </div>
                            <h1><%=list.size()%></h1>
                            <h1 class="text-muted">CATEGORIES</h1>

                        </div>
                    </div>
                </div>

                <!--Third col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width:125px " class="img-fluid" src ="img/products.png" alt="user_icon">
                            </div>
                            <h1> <%=m.get("productCount")%> </h1>
                            <h1 class="text-muted">PRODUCTS</h1>

                        </div>
                    </div>
                </div>

            </div>


            <!--Second row-->
            <div class="row mt-3">

                <!--second row first col-->
                <div class="col-md-4">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width:125px " class="img-fluid" src ="img/menu.png" alt="user_icon">
                            </div>

                            <h1 class="text-muted">ADD CATEGORIES</h1>

                        </div>
                    </div>
                </div>

                <!--second row second col-->
                <div class="col-md-4">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width:125px; height: 173px" class="img-fluid" src ="img/add.png" alt="user_icon">
                            </div>

                            <h1 class="text-muted">ADD PRODUCTS</h1>

                        </div>
                    </div>
                </div>


                <div class="col-md-4">
                    <div class="card" data-toggle="modal" data-target="#add-order-modal">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width:125px; height: 173px" class="img-fluid" src ="img/order.png" alt="user_icon">
                            </div>

                            <h1 class="text-muted">ORDERS</h1>

                        </div>
                    </div>
                </div>

            </div>
        </div>



        <!-- Add category modal --> 
        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">

                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required />
                            </div>
                            <div class="form-group">
                                <textarea style="height: 200px" class="form-control" name="catDescription" placeholder="Enter category description"></textarea>
                            </div>

                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-outline-success" data-dismiss="modal">Close</button>
                            </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>
        <!-- End of add category modal -->


        <!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

        <!-- Add product modal --> 

        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                            <input type="hidden" name="operation" value="addproduct">

                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Enter product name" name="pName" required/>
                            </div>

                            <div class="form-group">
                                <textarea style="height: 150px" class="form-control" name="pDescription" placeholder="Enter product description"></textarea>
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter product price" name="pPrice" required/>
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter product discount" name="pDiscount" required/>
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter product quantity" name="pQuantity" required/>
                            </div>


                            <!--product category-->


                            <div class="form-group">
                                <select name="catId" class="form-control" >

                                    <%
                                        for (Category c : list) {
                                    %>

                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>

                                    <% }%>

                                </select>
                            </div>


                            <!-- product file -->
                            <div class="form-group">
                                <input type="file" name="pPic" required/>
                            </div>

                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>
                                <button type="button" class="btn btn-outline-success" data-dismiss="modal">Close</button>
                            </div> 
                        </form>

                    </div>
                </div>
            </div>
        </div>
        <!-- End of add product modal -->

        <!--        ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->

        <!-- Admin ORDER MOdal -->

        <div class="modal fade" id="add-order-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">🛒 All User Orders Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <table class="table table-bordered table-striped text-center">
                            <thead>
                                <tr>
                                <tr>
                                    <th>Order ID</th>
                                    <th>User</th>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="order" items="${orderList}">
                                
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td>${order.userName}</td>
                                    <td>${order.orderDate}</td>
                                    <td>${order.totalAmount}</td>
                                    <td>${order.paymentStatus}</td>
                                    <td>${order.deliveryStatus}</td>
                                    <td class="action-buttons">
                                       <button onclick="openViewModal(${order.orderId})" style="background-color: #4CAF50; color: white; padding: 4px 8px; border: none; font-size: 12px; margin: 2px; cursor: pointer; border-radius: 3px;">View</button>
                                       <button onclick="openEditModal(${order.orderId})" style="background-color: #2196F3; color: white; padding: 4px 8px; border: none; font-size: 12px; margin: 2px; cursor: pointer; border-radius: 3px;">Edit</button>
                                    </td>                                                                                                        
                                </tr>
                              
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="components/common_modals.jsp"  %>

    </body>
</html>

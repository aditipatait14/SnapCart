<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>

        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>

        <%@include  file="components/navbar.jsp"%>

        <div class="container-fluid">

            <div class="row mt-4">

                <div class=" col-md-6 offset-md-3">

                    <div class="card">

                        <%@include file="components/message.jsp" %>

                        <div class="card-header custom-bg text-white text-center">
                            <h3>Sign Up</h3>
                        </div> 

                        <div class="card-body px-3"> 

                            <form action="RegisterServlet" method="post">

                                <div class="form-group mb-3 mt-3">
                                    <label for="fname">Name:</label>
                                    <input name="user_name" type="text" class="form-control" id="fname" placeholder="Enter your name" required>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="email">Email Address:</label>
                                    <input name="user_email" type="email" class="form-control" id="email" placeholder="Enter your email" required>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="password">Password:</label>
                                    <input name="user_password" type="password" class="form-control" id="password" placeholder="Enter password" minlength="6" required>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="phone">Phone No.:</label>
                                    <input name="user_phone" type="tel" class="form-control" id="phone" placeholder="Enter phone no." pattern="[0-9]{10}" title="Enter a valid 10-digit phone number" required>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="address">Address:</label>
                                    <textarea name="user_address" class="form-control" placeholder="Enter Your Address" required></textarea>
                                </div>

                                <div class="container text-center">
                                    <button class="btn btn-primary custom-bg border-0" type="submit">Register</button>
                                    <button class="btn btn-primary custom-bg border-0" type="reset">Reset</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </body>
</html>

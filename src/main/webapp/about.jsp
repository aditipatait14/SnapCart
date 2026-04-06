<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>About Us | Aditi Mobile & Computer</title>
    <%@include file="components/common_css_js.jsp" %>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
        }

        .about-section {
            padding: 60px 20px;
            text-align: center;
            background: linear-gradient(135deg, #5c6bc0, #8e99f3);
            color: white;
        }

        .about-section h1 {
            font-size: 80px;
            font-weight: bold;
            margin-bottom: 20px;
            font-family: 'Georgia', serif;
        }

        .about-section p {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .about-section img {
            background-color: #8e99f3;
            width: 100%;
            max-height: 500px;
            max-width: 700px;
            object-fit: contain;
            border-radius: 10px;
            margin-top: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .highlight-line {
            font-size: 24px;
            font-weight: bold;
            margin-top: 40px;
            color: #fff;
        }

        .containerCont {
            background-color: #e2e2e2;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            margin: 60px auto;
        }

        .containerCont h2 {
            color: #3f51b5;
            font-size: 36px;
            margin-bottom: 20px;
        }

        input[type=text], textarea {
            width: 100%;
            padding: 12px 15px;
            margin: 8px 0 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }

        button[type=submit], button[type=reset] {
            padding: 12px 25px;
            margin: 5px;
            font-size: 16px;
            border: none;
            border-radius: 25px;
            background-color: #6a1b9a;
            color: white;
            transition: 0.3s;
        }

        button:hover {
            background-color: #8e24aa;
        }

        @media screen and (max-width: 600px) {
            .about-section h1 {
                font-size: 50px;
            }

            .containerCont {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <%@include file="components/navbar.jsp" %>

    <div class="about-section">
        <h1>About Us</h1>
        <p>"Where gadgets meet greatness, and tech finds its home,<br>
            At Aditi Mobile & Computer, let innovation roam." 🚀✨</p>

        <img src="img/about us.png" alt="About Dhani Mobile & Computer" />

        <p>
            At Aditi Mobile & Computer, we bring technology to life! Whether you're searching for the latest smartphones,
            powerful laptops, or must-have accessories, we’ve got you covered with top brands like Apple, Samsung, Dell, HP, and Lenovo.
        </p>
        <p>
            But we’re more than just a store—we’re your tech partner! Need a quick device repair? A smooth software update?
            Or perhaps you’re looking to trade in your old gadget for an upgrade? Our expert team is here to help,
            ensuring you get the best service every step of the way.
        </p>
        <p>
            From business professionals to passionate gamers and everyday users, we offer customized tech solutions to match your needs.
            Our friendly and knowledgeable staff will guide you with expert recommendations, seamless troubleshooting, and hassle-free setup.
        </p>
        <p>
            At Aditi Mobile & Computer, we don’t just sell devices—we enhance your digital experience. Step in today and discover technology at its best!
        </p>

        <div class="highlight-line">
            <h4>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</h4>
            <h4>Bringing technology closer to you!<br>️ Contact us and let’s make innovation happen. 📩</h4>
        </div>
    </div>

    <div class="containerCont">
        <div class="text-center">
            <h2>Contact Us</h2>
            <p style="font-weight: bold;">Leave us a message!!</p>
        </div>

        <form style="font-weight: bold;">
            <label for="fname">Name:</label>
            <input type="text" id="fname" name="firstname" placeholder="Your name..">

            <label for="lname">Contact No.:</label>
            <input type="text" id="lname" name="lastname" placeholder="Contact no.">

            <label for="subject">Message:</label>
            <textarea id="subject" name="subject" placeholder="Write something.." style="height:150px"></textarea>

            <div class="text-center">
                <button type="submit">Submit</button>
                <button type="reset">Reset</button>
            </div>
        </form>
    </div>

    <%@include file="components/common_modals.jsp" %>

</body>
</html>

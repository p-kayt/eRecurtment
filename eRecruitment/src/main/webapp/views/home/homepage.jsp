<%-- 
    Document   : homepage
    Created on : Sep 27, 2022, 5:47:58 PM
    Author     : MINH TRI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>eRecruitment</title>
	</head>
	<body>
		<header>
			<!-- navi -->
			<nav class="navbar navbar-expand-xl navbar-expand-sm justify-content-center">
				<button
					class="navbar-toggler bg-dark col-6"
					type="button"
					data-toggle="collapse"
					data-target="#Navbar"
					aria-controls="Navbar"
					aria-expanded="false"
					aria-label="Toggle navigation"
				>
					<span class="navbar-toggler-icon"></span>
				</button>
				<!--  -->
				<div class="collapse navbar-collapse col-8" id="Navbar">
					<ul class="navbar-nav mr-auto d-flex flex-row">
						<li class="nav-item active col-6">
							<!-- logo img -->
							<a class="nav-link" href="homepage.html"
								><span class="fa fa-home fa-lg bg-dark"></span>Home</a
							>
						</li>

						<li class="nav-item col-4">
							<a class="nav-link hyper" href="#">Section 1</a>
						</li>

						<li class="nav-item col-4">
							<a class="nav-link hyper" href="#">Section 2</a>
						</li>

						<li class="nav-item col-4">
							<a class="nav-link hyper" href="#">Section 3</a>
						</li>
					</ul>
				</div>

				<div>
					<a href="login.html">
						<span class="fa fa-sign-in"></span>Login
					</a>
				</div>
			</nav>
			<div class="container">
				<!-- banner -->
				<!-- carousel -->
				<div
					class="bg-dark"
					style="height: 350px; border: 1px; margin-top: 10px"
				></div>
			</div>
		</header>
	</body>
</html>


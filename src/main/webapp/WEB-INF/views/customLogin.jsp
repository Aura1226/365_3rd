<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<head>
<title>36.5℃ 사진관</title>
<meta name="google-signin-client_id" content="1063625427503-fqtdju4bmftbhdm7n20qbk6j7ubiqsnr.apps.googleusercontent.com">
</head>
<style>
body
{
    background: url('http://farm3.staticflickr.com/2832/12303719364_c25cecdc28_b.jpg') fixed;
    background-size: cover;
    padding: 0;
    margin: 0;
}

.container
{
    display: flex;
    justify-content: center;
    align-items: center;
  	margin-top: 2%;
  	
    z-index: 99;
}



form
{
    width: 250px;
    margin: 0 auto;
}

form.login input[type="text"], form.login input[type="password"]
{
    width: 100%;
    margin: 0;
    padding: 5px 10px;
    background: 0;
    border: 0;
    border-bottom: 1px solid #FFFFFF;
    outline: 0;
    font-style: italic;
    font-size: 12px;
    font-weight: 400;
    letter-spacing: 1px;
    margin-bottom: 5px;
    color: #FFFFFF;
    outline: 0;
}

form.login input[type="submit"]
{
    width: 100%;
    font-size: 14px;
    text-transform: uppercase;
    font-weight: 500;
    margin-top: 16px;
    outline: 0;
    cursor: pointer;
    letter-spacing: 1px;
}

form.login input[type="submit"]:hover
{
    transition: background-color 0.5s ease;
}

form.login .remember-forgot
{
    float: left;
    width: 100%;
    margin: 10px 0 0 0;
}
form.login .forgot-pass-content
{
    min-height: 20px;
    margin-top: 10px;
    margin-bottom: 10px;
}
form.login label, form.login a
{
    font-size: 12px;
    font-weight: 400;
    color: #FFFFFF;
}

form.login a
{
    transition: color 0.5s ease;
}

form.login a:hover
{
    color: #2ecc71;
}

.pr-wrap
{
    width: 100%;
    height: 100%;
    min-height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 999;
    display: none;
}

.show-pass-reset
{
    display: block !important;
}

.pass-reset
{
    margin: 0 auto;
    width: 250px;
    position: relative;
    margin-top: 22%;
    z-index: 999;
    background: #FFFFFF;
    padding: 20px 15px;
}

.pass-reset label
{
    font-size: 12px;
    font-weight: 400;
    margin-bottom: 15px;
}

.pass-reset input[type="email"]
{
    width: 100%;
    margin: 5px 0 0 0;
    padding: 5px 10px;
    background: 0;
    border: 0;
    border-bottom: 1px solid #000000;
    outline: 0;
    font-style: italic;
    font-size: 12px;
    font-weight: 400;
    letter-spacing: 1px;
    margin-bottom: 5px;
    color: #000000;
    outline: 0;
}

.pass-reset input[type="submit"]
{
    width: 100%;
    border: 0;
    font-size: 14px;
    text-transform: uppercase;
    font-weight: 500;
    margin-top: 10px;
    outline: 0;
    cursor: pointer;
    letter-spacing: 1px;
}

.pass-reset input[type="submit"]:hover
{
    transition: background-color 0.5s ease;
}
.posted-by
{
    position: absolute;
    bottom: 26px;
    margin: 0 auto;
    color: #FFF;
    background-color: rgba(0, 0, 0, 0.66);
    padding: 10px;
    left: 45%;
}
.g-signin2
{
	display: flex;
	justify-content: center;
}
.checkbox
{
color: white;
}
.login
{
color: white;
font-size: 32px;
}
.logo
{
display: flex;
justify-content: center;
align-items: center;
flex-shrink: 1 10px;

}


</style>
<div class="logo">
<img alt="LOGO" src="../resources/image/Logo2.png">
</div>

<div class="container">

    <div class="row">
        <div class="col-md-12">
            <div class="pr-wrap">
                <div class="pass-reset">
                    <label>
                        Enter the email you signed up with</label>
                    <input type="email" placeholder="Email" />
                    <input type="submit" value="Submit" class="pass-reset-submit btn btn-success btn-sm" />
                </div>
            </div>
            <div class="wrap">
                <div class="login">
                <label>Login</label>
                </div>
                <form role="form" method="post" action="/login">
                            
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="ID" name="username" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="PASSWORD" name="password" type="password" value="">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="remember-me" type="checkbox">Remember Me
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                   <a href="index.html" class="btn btn-lg btn-success btn-block">Login</a>
                     
                            </fieldset>
                               <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>

                    
                    <div class="g-signin2" data-onsuccess="onSignIn"></div>
                </form>
                </div>
                
            </div>
        </div>
    </div>


<script src="https://apis.google.com/js/platform.js" async defer></script>



<script>
$(document).ready(function () {
    
	   $(".btn-success").on("click", function(e){
		    
	       e.preventDefault();
	       $("form").submit();
	    });
	   function onSignIn(googleUser) {
			  var profile = googleUser.getBasicProfile();
			  var id_token = googleUser.getAuthResponse().id_token;
			  $("#googleBtn").click(function(){
				  $.ajax({
					  url: 'http://localhost:8081/customLogin',
					  type: 'POST',
					  data: 'idtoken=' + id_token, 
					  dataType: 'JSON',
					  beforeSend : function(xhr){
						  xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
					  },
					  success: function(json) {
						  if (json.login_result == "success"){
							  location.href = "http://localhost:8081/board/list";
						  }//end if
			          }//success
				  });//ajax
			  });//click
/* 	
	 function onSignIn(googleUser) {
   	  var profile = googleUser.getBasicProfile();
   	  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
   	  console.log('Name: ' + profile.getName());
   	  console.log('Image URL: ' + profile.getImageUrl());
   	  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
   	} */
	
	$('.forgot-pass').click(function(event) {
      $(".pr-wrap").toggleClass("show-pass-reset");
    }); 
    
    $('.pass-reset-submit').click(function(event) {
      $(".pr-wrap").removeClass("show-pass-reset");
    }); 
    
});
</script>